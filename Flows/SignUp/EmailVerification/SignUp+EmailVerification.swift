//
//  
//  SignUp+EmailVerification.swift
//  SignUp
//
//  Created by Ihor Yarovyi on 9/13/21.
//
//

import SwiftUI
import Resources
import UICore

public extension SignUp {
    struct EmailVerification: View {
        let email: String
        let disappearAction: Action
        let resendAction: Action
        let signInAction: Action
        let screenProgress: Progress

        // MARK: - Private Properties
        @EnvironmentObject
        private var routeManager: RouteManager
        
        public init(email: String,
                    disappearAction: Action,
                    resendAction: Action,
                    signInAction: Action,
                    screenProgress: Progress) {
            self.email = email
            self.disappearAction = disappearAction
            self.resendAction = resendAction
            self.signInAction = signInAction
            self.screenProgress = screenProgress
        }

        public var body: some View {
            VStack(spacing: .zero) {
                Spacer()
                image()
                title()
                description()
                resendButton()
                Spacer()
                signInButton()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Strings.EmailVerification.title)
            .isLoading(screenProgress == .active)
            .errorAlert(isPresented: .constant(screenProgress.isPresented), with: screenProgress.message)
            .onDisappear {
                onDisappear()
            }
        }
    }
}

// MARK: - Private Views
private extension SignUp.EmailVerification {
    func image() -> some View {
        Image(uiImage: Asset.imMailSent.image)
            .frame(width: Defaults.Image.width, height: Defaults.Image.height)
    }
    
    func title() -> some View {
        Text(Strings.EmailVerification.Labels.title)
            .font(Font.system(size: Defaults.Labels.Title.fontSize).bold())
            .foregroundColor(Color(Colors.greyishBrown.color))
            .padding(.top, Defaults.Padding.Title.top)
    }

    func description() -> some View {
        Text(Strings.EmailVerification.Labels.description(email))
            .font(Font.system(size: Defaults.Labels.Description.fontSize))
            .foregroundColor(Color(Colors.greyishBrown.color))
            .padding(.top, Defaults.Padding.Description.top)
            .padding(.horizontal, Defaults.Padding.Description.horizontal)
    }
    
    func resendButton() -> some View {
        HStack {
            Text(Strings.EmailVerification.Labels.doNotHaveALink)
                .font(Font.system(size: Defaults.Labels.DoNotHaveLink.fontSize))
                .foregroundColor(Color(Colors.greyishBrown.color))
            Button(Strings.EmailVerification.Buttons.resend) {
                onResend()
            }
            .font(Font.system(size: Defaults.Buttons.Resend.fontSize))
            .foregroundColor(Color(Colors.fadedOrange.color))
        }
        .padding(.top, Defaults.Padding.Resend.top)
    }
    
    func signInButton() -> some View {
        Button(action: {
            onSignIn()
        }, label: {
            Spacer()
            Text(Strings.EmailVerification.Buttons.signIn.uppercased())
                .font(.system(size: Defaults.Buttons.SignIn.fontSize))
            Spacer()
        })
        .mainButton()
        .frame(alignment: .center)
        .padding(.horizontal, Defaults.Padding.SignIn.horizontal)
        .padding(.bottom, Defaults.Padding.SignIn.bottom)
    }
}

// MARK: - Handle Actions
private extension SignUp.EmailVerification {
    func onDisappear() {
        guard case let .available(action) = disappearAction else { return }
        action()
    }
    
    func onResend() {
        guard case let .available(action) = resendAction else { return }
        action()
    }
    
    func onSignIn() {
        guard case let .available(action) = signInAction else { return }
        action()
        routeManager.unselect(.signUp)
    }
}

// MARK: - Defaults
private extension SignUp.EmailVerification {
    enum Defaults {
        enum Image {
            static let width: CGFloat = 163
            static let height: CGFloat = 149
        }
        
        enum Labels {
            enum Title {
                static let fontSize: CGFloat = 17
            }

            enum Description {
                static let fontSize: CGFloat = 17
            }
            
            enum DoNotHaveLink {
                static let fontSize: CGFloat = 17
            }
        }
        
        enum Buttons {
            enum Resend {
                static let fontSize: CGFloat = 17
            }
            
            enum SignIn {
                static let fontSize: CGFloat = 15
            }
        }
        
        enum Padding {
            enum Title {
                static let top: CGFloat = 54
            }
            
            enum Description {
                static let top: CGFloat = 19
                static let horizontal: CGFloat = 46
            }
            
            enum Resend {
                static let top: CGFloat = 26
            }
            
            enum SignIn {
                static let horizontal: CGFloat = 46
                static let bottom: CGFloat = 32
            }
        }
    }
}

#if DEBUG
struct SignUpEmailVericationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignUp.EmailVerification(
                email: "test@example.com",
                disappearAction: .unavailable,
                resendAction: .unavailable,
                signInAction: .unavailable,
                screenProgress: .none
            )
        }
    }
}
#endif
