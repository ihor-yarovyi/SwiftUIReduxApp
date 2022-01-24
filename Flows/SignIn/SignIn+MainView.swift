//
//  SignIn+MainView.swift
//  SignIn
//
//  Created by Ihor Yarovyi on 8/14/21.
//

import SwiftUI
import Resources
import UICore

public extension SignIn {
    struct MainView: View {
        // MARK: - Internal Properties
        var email: Binding<String>
        var password: Binding<String>
        let signInAction: Action
        let signInProgress: Progress
        var onSignUp: () -> AnyView
        var onRestorePassword: () -> AnyView
        
        // MARK: - Private Properties        
        @EnvironmentObject
        private var routeManager: RouteManager
        
        // MARK: - Initializators
        public init(email: Binding<String>,
                    password: Binding<String>,
                    signInAction: Action,
                    signInProgress: Progress,
                    onSignUp: @escaping @autoclosure () -> AnyView,
                    onRestorePassword: @escaping @autoclosure () -> AnyView) {
            self.email = email
            self.password = password
            self.signInAction = signInAction
            self.signInProgress = signInProgress
            self.onSignUp = onSignUp
            self.onRestorePassword = onRestorePassword
        }
    
        public var body: some View {
            NavigationView {
                VStack {
                    Spacer()
                    title()
                    emailField()
                    passwordField()
                    forgotPasswordButton()
                    signInButton()
                    Spacer()
                    signUpButton()
                }
                .padding([.leading, .trailing], Defaults.Padding.horizontal)
                .isLoading(signInProgress == .active)
                .errorAlert(isPresented: .constant(signInProgress.isPresented), with: signInProgress.message)
                .onAppear {
                    routeManager.unselect(.signUp)
                    routeManager.unselect(.restorePassword)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

// MARK: - Private Views
private extension SignIn.MainView {
    func title() -> some View {
        Text(Strings.SignIn.title)
            .font(Font.system(size: Defaults.Title.fontSize).bold())
            .leftAligned()
    }
    
    func emailField() -> some View {
        TextField(Strings.SignIn.Inputs.Email.placeholder, text: email)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .roundedTextField()
    }
    
    func passwordField() -> some View {
        SecureField(Strings.SignIn.Inputs.Password.placeholder, text: password)
            .textContentType(.password)
            .roundedTextField()
    }
    
    func forgotPasswordButton() -> some View {
        NavigationLink(
            destination: onRestorePassword(),
            tag: .restorePassword,
            selection: $routeManager[for: .restorePassword]
        ) {
            Button(action: {
                routeManager.select(.restorePassword)
            }, label: {
                Spacer()
                Text(Strings.SignIn.Buttons.ForgotPassword.title)
                    .font(Font.system(size: Defaults.Buttons.ForgotPassword.fontSize))
                    .foregroundColor(Color(Colors.greyishBrown.color))
                    .frame(height: Defaults.Buttons.ForgotPassword.height)
                    .leftAligned()
                Spacer()
            })
        }.isDetailLink(false)
    }
    
    func signInButton() -> some View {
        Button(action: {
            onSignIn()
        }, label: {
            Spacer()
            Text(Strings.SignIn.Buttons.SignIn.title)
                .font(Font.system(size: Defaults.Buttons.SignIn.fontSize))
            Spacer()
        })
        .mainButton()
    }
    
    func signUpButton() -> some View {
        NavigationLink(
            destination: onSignUp(),
            tag: .signUp,
            selection: $routeManager[for: .signUp]
        ) {
            HStack {
                Text(Strings.SignIn.Labels.doNotHaveAccount)
                    .font(.system(size: Defaults.Labels.DoNotHaveAccount.fontSize))
                    .foregroundColor(Color(Colors.greyishBrown.color))
                Button(Strings.SignIn.Buttons.SignUp.title) {
                    routeManager.select(.signUp)
                }
                .foregroundColor(Color(Colors.fadedOrange.color))
                .font(.system(size: Defaults.Buttons.SignUp.fontSize))
            }
            .frame(alignment: .center)
            .padding(.bottom, Defaults.Buttons.SignUp.bottomPadding)
        }.isDetailLink(false)
    }
}

// MARK: - Handle Actions
private extension SignIn.MainView {
    func onSignIn() {
        guard case let .available(action) = signInAction else { return }
        action()
    }
}

// MARK: - Defaults
private extension SignIn.MainView {
    enum Defaults {
        enum Title {
            static let fontSize: CGFloat = 34
        }
        
        enum TextField {
            static let height: CGFloat = 44
        }
        
        enum Labels {
            enum DoNotHaveAccount {
                static let fontSize: CGFloat = 17
            }
        }
        
        enum Buttons {
            enum ForgotPassword {
                static let fontSize: CGFloat = 13
                static let height: CGFloat = 44
            }
            
            enum SignIn {
                static let fontSize: CGFloat = 15
            }
            
            enum SignUp {
                static let fontSize: CGFloat = 17
                static let bottomPadding: CGFloat = 16
            }
        }
        
        enum Padding {
            static let horizontal: CGFloat = 38
        }
    }
}

#if DEBUG
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignIn.MainView(
            email: .empty,
            password: .empty,
            signInAction: .unavailable,
            signInProgress: .none,
            onSignUp: EmptyView().eraseToAnyView(),
            onRestorePassword: EmptyView().eraseToAnyView()
        )
    }
}
#endif
