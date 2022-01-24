//
//  
//  SideEffect+SignUp.swift
//  SideEffects
//
//  Created by Ihor Yarovyi on 9/11/21.
//
//

import Redux
import Models
import Core
import NetworkClient
import DatabaseClient
import Utils

public extension SideEffects {
    struct SignUp: RequestManager {
        // MARK: - Public Properties
        public let databaseClient: DatabaseClient.Instance
        public let store: Store
        public var asObserver: Observer {
            Observer(queue: QueueProvider.shared.queue) { state in
                observe(state: state)
                return .active
            }
        }

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
            
            handleSignUpFlow(state: state, requests: &requests)
            handleResendEmailFlow(state: state, requests: &requests)
            handleEmailVerificationFlow(state: state, requests: &requests)
        }
    }
}

// MARK: - Handle Flows
private extension SideEffects.SignUp {
    func handleSignUpFlow(state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        switch state.signUpFlow {
        case .none:
            break
        case .validation:
            onValidateCredential(state: state)
        case let .signUp(id):
            onSignUp(id: id, state: state, requests: &requests)
        }
    }
    
    func handleResendEmailFlow(state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        switch state.resendEmailFlow {
        case .none:
            break
        case let .resendEmail(id):
            onResendEmail(id: id, state: state, requests: &requests)
        }
    }
    
    func handleEmailVerificationFlow(state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        switch state.emailVerificationFlow {
        case .none:
            break
        case let .verifyToken(id, token):
            onVerifyToken(id: id, token: token, state: state, requests: &requests)
        }
    }
}

// MARK: - Handle Actions
private extension SideEffects.SignUp {
    func onVerifyToken(id: UUID, token: String, state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        add(
            id,
            request: NetworkClient.auth.verifyToken(token),
            to: &requests) { response in
            switch response {
            case let .success(session):
                let session = Models.Mappers.Auth.map(session.data)
                NetworkClient.network.token = NetworkClient.Utils.AuthTokenProvider(token: session.accessToken)
                store.dispatch(action: Actions.EmailVerification.TokenValidatedSuccessfully(session: session))
            case let .failed(error):
                store.dispatch(action: Actions.EmailVerification.TokenIsInvalid(error: error))
            default:
                preconditionFailure("Unexpected case")
            }
        }
    }
    
    func onResendEmail(id: UUID, state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        let email = state.signUpForm.credential?.email.value ?? ""
        add(
            id,
            request: NetworkClient.auth.resendEmailVerifications(email),
            to: &requests) { response in
            switch response {
            case .success, .successWithoutResult:
                store.dispatch(action: Actions.ResendEmailVerification.DidSendEmail())
            case let .failed(error):
                store.dispatch(action: Actions.ResendEmailVerification.DidFailSend(error: error))
            default:
                preconditionFailure("Unexpected case")
            }
        }
    }
    
    func onSignUp(id: UUID, state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        let email = state.signUpForm.credential?.email.value ?? ""
        let username = state.signUpForm.credential?.username.value ?? ""
        let password = state.signUpForm.credential?.password.value ?? ""
        add(
            id,
            request: NetworkClient.auth.signUp(email: email, username: username, password: password),
            to: &requests) { response in
            switch response {
            case .success:
                store.dispatch(action: Actions.SignUp.DidSendSignUp())
            case let .failed(error):
                store.dispatch(action: Actions.SignUp.InvalidSignUpRequest(error: error))
            default:
                preconditionFailure("Unexpected case")
            }
        }
    }
    
    func onValidateCredential(state: AppState) {
        do {
            let email = try Models.Auth.Email.parse(value: state.signUpForm.email).get()
            let username = try Models.Auth.Username.parse(value: state.signUpForm.username).get()
            let password = try Models.Auth.Password.parse(value: state.signUpForm.password).get()
            let confirmPassword = try Models.Auth.ConfirmPassword.parse(value: state.signUpForm.confirmPassword, with: password).get()
            let credential = Models.Auth.SignUpCredential(email: email, username: username, password: password, confirmPassword: confirmPassword)
            store.dispatch(action: Actions.SignUp.UpdateCredential(credential: credential))
            store.dispatch(action: Actions.SignUp.CredentialsValidated())
        } catch {
            store.dispatch(action: Actions.SignUp.InvalidCredential(error: error))
        }
    }
}
