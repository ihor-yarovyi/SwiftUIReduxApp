//
//  
//  SideEffect+RestoreSession.swift
//  SideEffects
//
//  Created by Ihor Yarovyi on 9/2/21.
//
//

import Redux
import Models
import Core
import DatabaseClient
import NetworkClient
import Utils
import PredicateKit

public extension SideEffects {
    struct RestoreSession {
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
            switch state.restoreSessionFlow {
            case .none:
                break
            case .fetchFromKeychain:
                onFetchFromKeychain()
            case .fetchUserFromDB:
                onFetchUserFromDB(state: state)
            }
        }
    }
}

// MARK: - Handle Actions
private extension SideEffects.RestoreSession {
    func onFetchUserFromDB(state: AppState) {
        guard let user = state.session.session?.user else { return }
        databaseClient.contains(Models.Auth.User.self) { 
            \(Models.Auth.User.Object).id == Int64(user.id)
        } completion: { result in
            switch result {
            case let .success(isContains):
                if isContains {
                    setTokenForNetwork(state: state)
                    store.dispatch(action: Actions.Session.UserExists())
                } else {
                    store.dispatch(action: Actions.Session.UserDoesNotExist())
                }
            case .failure:
                store.dispatch(action: Actions.Session.UserDoesNotExist())
            }
        }
    }
    
    func onFetchFromKeychain() {
        guard let keychainSession = SideEffects.RestoreSession.keychainSession else {
            store.dispatch(action: Actions.Session.SessionNotAvailable())
            return
        }
        let session = Models.Mappers.Auth.map(keychainSession)
        
        if session.session.isValid {
            store.dispatch(action: Actions.Session.FetchedSession(session))
        } else {
            store.dispatch(action: Actions.Session.SessionExpired())
        }
    }
}

// MARK: - Private Methods
private extension SideEffects.RestoreSession {
    func setTokenForNetwork(state: AppState) {
        NetworkClient.network.token = state.session.session.map {
            NetworkClient.Utils.AuthTokenProvider(token: $0.session.accessToken)
        }
    }
}
