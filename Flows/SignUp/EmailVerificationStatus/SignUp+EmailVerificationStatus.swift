//
//  
//  SignUp+EmailVerificationStatus.swift
//  SignUp
//
//  Created by Ihor Yarovyi on 10/3/21.
//
//

import SwiftUI
import Resources
import UICore

public extension SignUp {
    struct EmailVerificationStatus: View {
        let screenProgress: Progress
        
        // MARK: - Private Properties
        @State
        private var isActive: Bool = false
        
        @Environment(\.presentationMode)
        private var presentationMode: Binding<PresentationMode>
        private let onSuccess: () -> AnyView

        // MARK: - Lifecycle
        public init(screenProgress: Progress, onSuccess: @escaping @autoclosure () -> AnyView) {
            self.screenProgress = screenProgress
            self.onSuccess = onSuccess
        }

        public var body: some View {
            VStack(spacing: .zero) {
                Spacer()
                imageStatus()
                title()
                description()
                Spacer()
                signInButton()
                NavigationLink(
                    destination: onSuccess(),
                    isActive: $isActive,
                    label: {
                        EmptyView()
                    }
                ).isDetailLink(false)
            }
            .navigationTitle(Strings.EmailVerificationStatus.title)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                guard screenProgress == .success else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isActive = true
                }
            }
        }
    }
}

// MARK: - Private Views
private extension SignUp.EmailVerificationStatus {
    func imageStatus() -> some View {
        Image(uiImage: screenProgress == .success ? Asset.success.image :  Asset.failed.image)
            .resizable()
            .frame(width: Defaults.Image.size.width, height: Defaults.Image.size.height)
    }
    
    func title() -> some View {
        Text(
            screenProgress == .success
                ? Strings.EmailVerificationStatus.Labels.Success.title
                : Strings.EmailVerificationStatus.Labels.Failed.title
        ).font(Font.system(size: Defaults.Title.fontSize).bold())
        .padding(.top, Defaults.Padding.Title.top)
    }

    func description() -> some View {
        Text(
            screenProgress == .success
                ? Strings.EmailVerificationStatus.Labels.Success.description
                : Strings.EmailVerificationStatus.Labels.Failed.description
        ).font(Font.system(size: Defaults.Description.fontSize))
        .padding(.top, Defaults.Padding.Description.top)
    }
    
    func signInButton() -> some View {
        Button(action: {
            onSignIn()
        }, label: {
            Spacer()
            Text(Strings.EmailVerificationStatus.Buttons.signIn.uppercased())
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
private extension SignUp.EmailVerificationStatus {
    func onSignIn() {
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Defaults
private extension SignUp.EmailVerificationStatus {
    enum Defaults {
        enum Title {
            static let fontSize: CGFloat = 17
        }

        enum Description {
            static let fontSize: CGFloat = 17
        }

        enum Buttons {
            enum SignIn {
                static let fontSize: CGFloat = 15
            }
        }
        
        enum Image {
            static let size: CGSize = .init(width: 163, height: 148)
        }
        
        enum Padding {
            enum Title {
                static let top: CGFloat = 54
            }
            
            enum Description {
                static let top: CGFloat = 16
            }
            
            enum SignIn {
                static let horizontal: CGFloat = 46
                static let bottom: CGFloat = 32
            }
        }
    }
}

struct SignUpEmailVerificationStatusView_Previews: PreviewProvider {
    static var previews: some View {
        SignUp.EmailVerificationStatus(
            screenProgress: .success,
            onSuccess: EmptyView().eraseToAnyView()
        )
    }
}
