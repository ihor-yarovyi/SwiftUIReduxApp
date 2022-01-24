//
//  SideEffect+SignIn.swift
//  SideEffects
//
//  Created by Ihor Yarovyi on 8/18/21.
//

import Redux
import Models
import Core
import NetworkClient
import DatabaseClient
import Utils

public extension SideEffects {
    struct SignIn: RequestManager {
        // MARK: - Public Properties
        public let databaseClient: DatabaseClient.Instance
        public let store: Store
        public var asObserver: Observer {
            Observer(queue: QueueProvider.shared.queue) { state in
                observe(state: state)
                return .active
            }
        }
        
        // MARK: - Private Properties
        @Utils.KeychainStorage(service: "com.redux.app.session")
        static var keychainSession: NetworkClient.API.Model.SignInSession?
        
        // MARK: - Lifecycle
        public init(store: Store, databaseClient: DatabaseClient.Instance) {
            self.store = store
            self.databaseClient = databaseClient
        }
        
        public func observe(state: AppState) {
            var requests: [NetworkClient.OperatorRequest] = []
            
            defer {
                NetworkClient.network.process(requests: requests)
            }
            
            switch state.signInFlow {
            case .none:
                break
            case .validation:
                onValidateCredentials(in: state)
            case let .signIn(id):
                onSignIn(id: id, state: state, requests: &requests)
            case .saveSessionToKeychain:
                onSaveSession(state: state)
            case .saveUser:
                onSaveUser(state: state)
            }
        }
    }
}

// MARK: - Handle Actions
private extension SideEffects.SignIn {
    func onSaveUser(state: AppState) {
        guard let user = state.session.session?.user else { return }
        databaseClient.create(from: user) { result in
            switch result {
            case .success:
                store.dispatch(action: Actions.SignIn.DidSignIn())
            case let .failure(error):
                store.dispatch(action: Actions.SignIn.FailedSaveUser(error: error))
            }
        }
    }
    
    func onSaveSession(state: AppState) {
        SideEffects.SignIn.keychainSession = state.session.session.flatMap { Models.Mappers.Auth.map($0) }
        NetworkClient.network.token = state.session.session.map {
            NetworkClient.Utils.AuthTokenProvider(token: $0.session.accessToken)
        }
        store.dispatch(action: Actions.SignIn.SaveUser())
    }
    
    func onSignIn(id: UUID, state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        let login = state.signInForm.credential?.email.value ?? ""
        let password = state.signInForm.credential?.password.value ?? ""
        add(
            id,
            request: NetworkClient.auth.signIn(login: login, password: password),
            to: &requests
        ) { response in
            switch response {
            case let .success(result):
                store.dispatch(action: Actions.Session.ReceiveSession(Models.Mappers.Auth.map(result.data)))
            case let .failed(error):
                store.dispatch(action: Core.Actions.SignIn.BadSignInRequest(error: error))
            default:
                preconditionFailure("Unexpected case")
            }
        }
    }
    
    func onValidateCredentials(in state: AppState) {
        do {
            let email = try Models.Auth.Email.parse(value: state.signInForm.email).get()
            let password = try Models.Auth.Password.parse(value: state.signInForm.password).get()
            let credential = Models.Auth.SignInCredential(email: email, password: password)
            store.dispatch(action: Actions.SignIn.UpdateCredential(credential: credential))
            store.dispatch(action: Actions.SignIn.CredentialsValidated())
        } catch {
            store.dispatch(action: Actions.SignIn.InvalidCredentials(error: error))
        }
    }
}
