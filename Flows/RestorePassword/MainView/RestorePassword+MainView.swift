//
//  
//  RestorePassword+MainView.swift
//  RestorePassword
//
//  Created by Ihor Yarovyi on 01.01.2022.
//
//

import SwiftUI
import Resources
import UICore

public extension RestorePassword {
    struct MainView: View {
        var email: Binding<String>
        let restorePasswordAction: Action
        let disappearAction: Action
        let screenProgress: Progress
        let onRestorePassword: () -> AnyView
        
        // MARK: - Private Properties
        @Environment(\.presentationMode)
        private var presentationMode

        // MARK: - Initializator
        public init(email: Binding<String>,
                    restorePasswordAction: Action,
                    disappearAction: Action,
                    screenProgress: Progress,
                    onRestorePassword: @escaping @autoclosure () -> AnyView) {
            self.email = email
            self.restorePasswordAction = restorePasswordAction
            self.disappearAction = disappearAction
            self.screenProgress = screenProgress
            self.onRestorePassword = onRestorePassword
        }

        public var body: some View {
            VStack {
                emailField()
                restorePasswordButton()
                Spacer()
            }
            .padding(.horizontal, Defaults.Padding.horizontal)
            .isLoading(screenProgress == .active)
            .errorAlert(isPresented: .constant(screenProgress.isPresented), with: screenProgress.message)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle(Strings.RestorePassword.title)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton())
        }
    }
}

// MARK: - Private Views
private extension RestorePassword.MainView {
    func emailField() -> some View {
        TextField(Strings.SignUp.Inputs.Email.placeholder, text: email)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .roundedTextField()
            .padding(.top)
    }
    
    func restorePasswordButton() -> some View {
        NavigationLink(
            destination: onRestorePassword(),
            isActive: .constant(screenProgress == .success),
            label: {
                Button {
                    onRestorePasswordAction()
                } label: {
                    Spacer()
                    Text(Strings.RestorePassword.title.uppercased())
                        .font(Font.system(size: Defaults.Buttons.RestorePassword.fontSize))
                    Spacer()
                }
                .mainButton()
                .padding(.top)
            }
        ).isDetailLink(false)
    }
    
    func backButton() -> some View {
        Button {
            onBack()
        } label: {
            Image(systemName: "chevron.left").font(.title3)
        }.disabled(screenProgress == .active)
    }
}

// MARK: - Handle Actions
private extension RestorePassword.MainView {
    func onRestorePasswordAction() {
        guard case let .available(action) = restorePasswordAction else { return }
        action()
    }
    
    func onBack() {
        presentationMode.wrappedValue.dismiss()
        
        if case let .available(action) = disappearAction {
            action()
        }
    }
}

// MARK: - Defaults
private extension RestorePassword.MainView {
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
struct RestorePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        RestorePassword.MainView(
            email: .empty,
            restorePasswordAction: .unavailable,
            disappearAction: .unavailable,
            screenProgress: .none,
            onRestorePassword: EmptyView().eraseToAnyView()
        )
    }
}
#endif
