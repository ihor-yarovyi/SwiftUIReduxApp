//
//  
//  RestorePassword+NewPasswordView.swift
//  RestorePassword
//
//  Created by Ihor Yarovyi on 1/3/22.
//
//

import SwiftUI
import Resources
import UICore

public extension RestorePassword {
    struct NewPasswordView: View {
        var password: Binding<String>
        var confirmPassword: Binding<String>
        let restorePasswordAction: Action
        let disappearAction: Action
        let screenProgress: Progress

        // MARK: - Private Properties
        @State
        private var alertItem: AlertItem?
        
        @Environment(\.presentationMode)
        private var presentationMode
        
        // MARK: - Initializator
        public init(password: Binding<String>,
                    confirmPassword: Binding<String>,
                    restorePasswordAction: Action,
                    disapeearAction: Action,
                    screenProgress: Progress) {
            self.password = password
            self.confirmPassword = confirmPassword
            self.restorePasswordAction = restorePasswordAction
            self.disappearAction = disapeearAction
            self.screenProgress = screenProgress
        }

        public var body: some View {
            VStack {
                passwordField()
                confirmPasswordField()
                restorePasswordButton()
                Spacer()
            }
            .padding(.horizontal, Defaults.Padding.horizontal)
            .isLoading(screenProgress == .active)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle(Strings.RestorePassword.title)
            .alert(item: $alertItem) { item in item.alert }
            .onChange(of: screenProgress, perform: onChangeScreenProgress(_:))
            .onDisappear(perform: onDisappear)
        }
    }
}

// MARK: - Private Views
private extension RestorePassword.NewPasswordView {
    func passwordField() -> some View {
        SecureField(Strings.RestorePassword.Inputs.newPassword, text: password)
            .keyboardType(.default)
            .textContentType(.password)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .roundedTextField()
            .padding(.top)
    }
    
    func confirmPasswordField() -> some View {
        SecureField(Strings.RestorePassword.Inputs.confirmNewPassword, text: confirmPassword)
            .keyboardType(.default)
            .textContentType(.password)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .roundedTextField()
    }
    
    func restorePasswordButton() -> some View {
        Button {
            onRestorePassword()
        } label: {
            Spacer()
            Text(Strings.RestorePassword.title.uppercased())
                .font(Font.system(size: Defaults.Buttons.RestorePassword.fontSize))
            Spacer()
        }
        .mainButton()
        .padding(.top)
    }
}

// MARK: - Handle Actions
private extension RestorePassword.NewPasswordView {
    func onRestorePassword() {
        guard case let .available(action) = restorePasswordAction else { return }
        action()
    }
    
    func onChangeScreenProgress(_ progress: Progress) {
        if progress.isPresented, let message = progress.message {
            alertItem = .init(alert: Alert.error(message: message, onDismiss: onDismissAlert))
        } else if progress == .success {
            alertItem = .init(alert: successAlert())
        }
    }
    
    func onDismissAlert() {
        alertItem = nil
    }
    
    func onDismissSuccessAlert() {
        onDismissAlert()
        presentationMode.wrappedValue.dismiss()
    }
    
    func onDisappear() {
        guard case let .available(action) = disappearAction else { return }
        action()
    }
}

// MARK: - Private Helpers
private extension RestorePassword.NewPasswordView {
    func successAlert() -> Alert {
        .init(
            title: Text(Strings.Alert.Titles.passwordChanged),
            dismissButton: .default(Text(Strings.Alert.Actions.ok), action: onDismissSuccessAlert)
        )
    }
}

// MARK: - AlertItem
private extension RestorePassword.NewPasswordView {
    struct AlertItem: Identifiable {
        var id = UUID()
        var alert: Alert
    }
}

// MARK: - Defaults
private extension RestorePassword.NewPasswordView {
    enum Defaults {
        enum Buttons {
            enum RestorePassword {
                static let fontSize: CGFloat = 15
            }
        }
        
        enum Padding {
            static let horizontal: CGFloat = 38
        }
    }
}

#if DEBUG
struct RestorePasswordNewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        RestorePassword.NewPasswordView(
            password: .empty,
            confirmPassword: .empty,
            restorePasswordAction: .unavailable,
            disapeearAction: .unavailable,
            screenProgress: .none
        )
    }
}
#endif
