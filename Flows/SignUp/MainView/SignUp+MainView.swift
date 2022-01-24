//
//  
//  SignUp+MainView.swift
//  SignUp
//
//  Created by Ihor Yarovyi on 9/6/21.
//
//

import SwiftUI
import Resources
import UICore

public extension SignUp {
    struct MainView: View {
        var email: Binding<String>
        var username: Binding<String>
        var password: Binding<String>
        var confirmPassword: Binding<String>
        let screenAction: Action
        let signInAction: Action
        let screenProgress: Progress
        let onEmailVerification: () -> AnyView
        
        // MARK: - Private Properties
        @Environment(\.presentationMode)
        private var presentationMode: Binding<PresentationMode>

        public init(email: Binding<String>,
                    username: Binding<String>,
                    password: Binding<String>,
                    confirmPassword: Binding<String>,
                    screenAction: Action,
                    signInAction: Action,
                    screenProgress: Progress,
                    onEmailVerification: @escaping @autoclosure () -> AnyView) {
            self.email = email
            self.username = username
            self.password = password
            self.confirmPassword = confirmPassword
            self.screenAction = screenAction
            self.signInAction = signInAction
            self.screenProgress = screenProgress
            self.onEmailVerification = onEmailVerification
        }

        public var body: some View {
            VStack {
                Spacer()
                title()
                emailField()
                usernameField()
                passwordField()
                confirmPasswordField()
                signUpButton()
                Spacer()
                loginButton()
            }
            .padding([.leading, .trailing], Defaults.Padding.horizontal)
            .isLoading(screenProgress == .active)
            .errorAlert(isPresented: .constant(screenProgress.isPresented), with: screenProgress.message)
            .navigationBarBackButtonHidden(true)
        }
    }
}

// MARK: - Private Views
private extension SignUp.MainView {
    func title() -> some View {
        Text(Strings.SignUp.title)
            .font(Font.system(size: Defaults.Title.fontSize).bold())
    }

    func emailField() -> some View {
        TextField(Strings.SignUp.Inputs.Email.placeholder, text: email)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .roundedTextField()
    }
    
    func usernameField() -> some View {
        TextField(Strings.SignUp.Inputs.Username.placeholder, text: username)
            .keyboardType(.default)
            .textContentType(.username)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .roundedTextField()
    }
    
    func passwordField() -> some View {
        SecureField(Strings.SignUp.Inputs.Password.placeholder, text: password)
            .keyboardType(.default)
            .textContentType(.password)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .roundedTextField()
    }
    
    func confirmPasswordField() -> some View {
        SecureField(Strings.SignUp.Inputs.ConfirmPassword.placeholder, text: confirmPassword)
            .keyboardType(.default)
            .textContentType(.password)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .roundedTextField()
    }
    
    func signUpButton() -> some View {
        NavigationLink(
            destination: onEmailVerification(),
            isActive: .constant(screenProgress == .success),
            label: {
                Button(action: {
                    onSignUp()
                }, label: {
                    Spacer()
                    Text(Strings.SignUp.Buttons.SignUp.title)
                        .font(Font.system(size: Defaults.Buttons.SignUp.fontSize))
                    Spacer()
                })
                .mainButton()
            }
        ).isDetailLink(false)
    }
    
    func loginButton() -> some View {
        HStack {
            Text(Strings.SignUp.Labels.alreadyHaveAnAccount)
                .font(.system(size: Defaults.Labels.AlreadyHaveAccount.fontSize))
                .foregroundColor(Color(Colors.greyishBrown.color))
            Button(Strings.SignUp.Buttons.LogIn.title) {
                onLogin()
            }
            .foregroundColor(Color(Colors.fadedOrange.color))
            .font(.system(size: Defaults.Buttons.Login.fontSize))
        }
        .frame(alignment: .center)
        .padding(.bottom, Defaults.Buttons.Login.bottomPadding)
    }
}

// MARK: - Handle Actions
private extension SignUp.MainView {
    func onLogin() {
        presentationMode.wrappedValue.dismiss()
        
        if case let .available(action) = signInAction {
            action()
        }
    }
    
    func onSignUp() {
        guard case let .available(action) = screenAction else { return }
        action()
    }
}

// MARK: - Defaults
private extension SignUp.MainView {
    enum Defaults {
        enum Title {
            static let fontSize: CGFloat = 34
        }
        
        enum Padding {
            static let horizontal: CGFloat = 38
        }
        
        enum Buttons {
            enum SignUp {
                static let fontSize: CGFloat = 15
            }
            
            enum Login {
                static let fontSize: CGFloat = 17
                static let bottomPadding: CGFloat = 16
            }
        }
        
        enum Labels {
            enum AlreadyHaveAccount {
                static let fontSize: CGFloat = 17
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUp.MainView(
            email: .empty,
            username: .empty,
            password: .empty,
            confirmPassword: .empty,
            screenAction: .unavailable,
            signInAction: .unavailable,
            screenProgress: .none,
            onEmailVerification: SignUp.EmailVerification.Connector().eraseToAnyView()
        )
    }
}
