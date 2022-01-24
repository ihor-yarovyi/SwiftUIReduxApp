//
//  
//  RestorePassword+StatusView.swift
//  RestorePassword
//
//  Created by Ihor Yarovyi on 02.01.2022.
//
//

import SwiftUI
import Resources
import UICore

public extension RestorePassword {
    struct StatusView: View {
        let email: String
        let resendAction: Action
        let signInAction: Action
        let screenProgress: Progress

        // MARK: - Private Properties
        @EnvironmentObject
        private var routeManager: RouteManager
        
        // MARK: - Initializator
        public init(email: String,
                    resendAction: Action,
                    signInAction: Action,
                    screenProgress: Progress) {
            self.email = email
            self.resendAction = resendAction
            self.signInAction = signInAction
            self.screenProgress = screenProgress
        }

        public var body: some View {
            VStack {
                Spacer()
                imageStatus()
                title()
                description()
                resendButton()
                Spacer()
                signInButton()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Strings.RestorePassword.title)
            .navigationBarBackButtonHidden(true)
            .isLoading(screenProgress == .active)
            .errorAlert(isPresented: .constant(screenProgress.isPresented), with: screenProgress.message)
        }
    }
}

// MARK: - Private Views
private extension RestorePassword.StatusView {
    func imageStatus() -> some View {
        Image(uiImage: Asset.success.image)
            .resizable()
            .frame(width: Defaults.Image.size.width, height: Defaults.Image.size.height)
    }
    
    func title() -> some View {
        Text(Strings.RestorePassword.Labels.requestDidSend)
            .font(Font.system(size: Defaults.Labels.Title.fontSize).bold())
            .foregroundColor(Color(Colors.greyishBrown.color))
            .padding(.top, Defaults.Padding.Title.top)
    }
    
    func description() -> some View {
        Text(Strings.RestorePassword.Labels.restoreLinkSentTo(email))
            .font(Font.system(size: Defaults.Labels.Description.fontSize))
            .foregroundColor(Color(Colors.greyishBrown.color))
            .multilineTextAlignment(.center)
            .padding(.top, Defaults.Padding.Description.top)
    }
    
    func resendButton() -> some View {
        HStack {
            Text(Strings.RestorePassword.Labels.dontHaveLink)
                .font(Font.system(size: Defaults.Labels.DoNotHaveLink.fontSize))
                .foregroundColor(Color(Colors.greyishBrown.color))
            Button(Strings.RestorePassword.Buttons.resend) {
                onResend()
            }
            .font(Font.system(size: Defaults.Buttons.Resend.fontSize))
            .foregroundColor(Color(Colors.fadedOrange.color))
        }.padding(.top, Defaults.Padding.Resend.top)
    }
    
    func signInButton() -> some View {
        Button {
            onSignIn()
        } label: {
            Spacer()
            Text(Strings.RestorePassword.Buttons.signIn.uppercased())
                .font(.system(size: Defaults.Buttons.SignIn.fontSize))
            Spacer()
        }
        .mainButton()
        .frame(alignment: .center)
        .padding(.horizontal, Defaults.Padding.SignIn.horizontal)
        .padding(.bottom, Defaults.Padding.SignIn.bottom)
    }
}

// MARK: - Handle Actions
private extension RestorePassword.StatusView {
    func onSignIn() {
        routeManager.unselect(.restorePassword)
        
        if case let .available(action) = signInAction {
            action()
        }
    }
    
    func onResend() {
        guard case let .available(action) = resendAction else { return }
        action()
    }
}

// MARK: - Defaults
private extension RestorePassword.StatusView {
    enum Defaults {
        enum Image {
            static let size: CGSize = .init(width: 163, height: 148)
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
                static let top: CGFloat = 16
            }
            
            enum Resend {
                static let top: CGFloat = 24
            }
            
            enum SignIn {
                static let horizontal: CGFloat = 46
                static let bottom: CGFloat = 32
            }
        }
    }
}

#if DEBUG
struct RestorePasswordStatusView_Previews: PreviewProvider {
    static var previews: some View {
        RestorePassword.StatusView(
            email: "test@example.com",
            resendAction: .unavailable,
            signInAction: .unavailable,
            screenProgress: .none
        )
    }
}
#endif
