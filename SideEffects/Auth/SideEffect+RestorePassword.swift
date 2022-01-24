//
//  
//  SideEffect+RestorePassword.swift
//  SideEffects
//
//  Created by Ihor Yarovyi on 02.01.2022.
//
//

import Redux
import Models
import Core
import NetworkClient
import Utils

public extension SideEffects {
    struct RestorePassword: RequestManager {
        // MARK: - Public Properties
        public let store: Store
        public var asObserver: Observer {
            Observer(queue: QueueProvider.shared.queue) { state in
                observe(state: state)
                return .active
            }
        }

        // MARK: - Lifecycle
        public init(store: Store) {
            self.store = store
        }

        public func observe(state: AppState) {
            var requests: [NetworkClient.OperatorRequest] = []

            defer {
                NetworkClient.network.process(requests: requests)
            }

            handleRestorePasswordFlow(state: state, requests: &requests)
            handleResendRestoreLinkFlow(state: state, requests: &requests)
            handleRestoreTokenVerificationFlow(state: state, requests: &requests)
            handleNewPasswordFlow(state: state, requests: &requests)
        }
    }
}

// MARK: - Handle Flows
private extension SideEffects.RestorePassword {
    func handleRestorePasswordFlow(state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        switch state.restorePasswordFlow {
        case .none:
            break
        case .validation:
            onValidateEmail(state: state)
        case let .restorePassword(id):
            onRestorePassword(id: id, state: state, requests: &requests)
        }
    }
    
    func handleResendRestoreLinkFlow(state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        switch state.resendRestoreLinkFlow {
        case .none:
            break
        case let .resendRestoreLink(id):
            onResendRestoreLink(id: id, state: state, requests: &requests)
        }
    }
    
    func handleRestoreTokenVerificationFlow(state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        switch state.restoreTokenVerificationFlow {
        case .none:
            break
        case let .verifyToken(id, token):
            onVerifyToken(id: id, token: token, state: state, requests: &requests)
        }
    }
    
    func handleNewPasswordFlow(state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        switch state.newPasswordFlow {
        case .none:
            break
        case .validation:
            onValidateNewPassword(state: state)
        case let .passNewPassword(id):
            onPassNewPassword(id: id, state: state, requests: &requests)
        }
    }
}

// MARK: - Handle Actions
private extension SideEffects.RestorePassword {
    func onPassNewPassword(id: UUID, state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        guard let credential = state.newPasswordForm.credential else { return }
        
        add(
            id,
            request: NetworkClient.auth.passNewPassword(credential.password.value, for: state.newPasswordForm.token),
            to: &requests
        ) { response in
            switch response {
            case .success, .successWithoutResult:
                store.dispatch(action: Actions.NewPassword.Success())
            case let .failed(error):
                store.dispatch(action: Actions.NewPassword.Failed(error))
            default:
                preconditionFailure("Unexpected case")
            }
        }
    }
    
    func onValidateNewPassword(state: AppState) {
        do {
            let password = try Models.Auth.Password.parse(value: state.newPasswordForm.password).get()
            let confirmPassword = try Models.Auth.ConfirmPassword.parse(value: state.newPasswordForm.confirmPassword, with: password).get()
            let credential = Models.Auth.RestorePasswordCredential(password: password, confirmPassword: confirmPassword)
            store.dispatch(action: Actions.NewPassword.UpdateCredential(credential))
        } catch {
            store.dispatch(action: Actions.NewPassword.Failed(error))
        }
    }
    
    func onVerifyToken(id: UUID, token: String, state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        guard state.restoreSessionStatus == .success || state.restoreSessionStatus == .failed else { return }
        add(
            id,
            request: NetworkClient.auth.verifyRestorePasswordToken(token),
            to: &requests
        ) { response in
            switch response {
            case .success, .successWithoutResult:
                store.dispatch(action: Actions.RestoreTokenVerification.DidVerify(token))
            case let .failed(error):
                store.dispatch(action: Actions.RestoreTokenVerification.DidFail(error))
            default:
                preconditionFailure("Unexpected case")
            }
        }
    }
    
    func onResendRestoreLink(id: UUID, state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        guard let email = state.restorePasswordForm.email else { return }
        add(
            id,
            request: NetworkClient.auth.restorePassword(for: email.value),
            to: &requests
        ) { response in
            switch response {
            case .success, .successWithoutResult:
                store.dispatch(action: Actions.ResendRestoreLink.DidResend())
            case let .failed(error):
                store.dispatch(action: Actions.ResendRestoreLink.DidFail(error))
            default:
                preconditionFailure("Unexpected case")
            }
        }
    }
    
    func onRestorePassword(id: UUID, state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        guard let email = state.restorePasswordForm.email else { return }
        add(
            id,
            request: NetworkClient.auth.restorePassword(for: email.value),
            to: &requests
        ) { response in
            switch response {
            case .success, .successWithoutResult:
                store.dispatch(action: Actions.RestorePassword.DidSendRequest())
            case let .failed(error):
                store.dispatch(action: Actions.RestorePassword.Failed(error))
            default:
                preconditionFailure("Unexpected case")
            }
        }
    }
    
    func onValidateEmail(state: AppState) {
        do {
            let email = try Models.Auth.Email.parse(value: state.restorePasswordForm.rawEmail).get()
            store.dispatch(action: Actions.RestorePassword.UpdateCredential(email: email))
        } catch {
            store.dispatch(action: Actions.RestorePassword.Failed(error))
        }
    }
}
