//
//  
//  SignUp+CompleteProfile.swift
//  SignUp
//
//  Created by Ihor Yarovyi on 10/9/21.
//
//

import SwiftUI
import Resources
import UICore
import Utils

public extension SignUp {
    struct CompleteProfile: View {
        // MARK: - Internal Properties
        let createAccountAction: Action
        let chooseFromCameraAction: Action
        let chooseFromGalleryAction: Action
        let screenProgress: Progress
        let firstName: Binding<String>
        let lastName: Binding<String>
        let phoneNumber: Binding<String>
        let bio: Binding<String>
        let photoState: Binding<Utils.PhotoGallery.TakePhotoState>
        
        // MARK: - Private Properties
        @State
        private var shouldShowSheet: Bool = false
        
        @State
        private var selectedImage: UIImage?
        
        @State
        private var alertItem: AlertItem?
        
        private var canPresentImagePicker: Binding<Bool> {
            guard case .take = photoState.wrappedValue else { return .constant(false) }
            return .constant(!shouldShowSheet)
        }
        
        private var imagePickerSourceType: Utils.PhotoGallery.Source? {
            guard case let .take(source) = photoState.wrappedValue else { return nil }
            return source
        }
        
        private var canPresentImageCrop: Binding<Bool> {
            guard case .crop = photoState.wrappedValue else { return .constant(false) }
            return .constant(!shouldShowSheet)
        }
        
        private var cropViewSource: UIImage? {
            guard case let .crop(image) = photoState.wrappedValue else { return nil }
            return image
        }
        
        private var isPermissionDenied: Bool {
            guard case .denied = photoState.wrappedValue else { return false }
            return true
        }
        
        private var isPermissionErrorOccur: Bool {
            guard case .failed = photoState.wrappedValue else { return false }
            return true
        }
        
        private var permissionErrorMessage: Text? {
            guard case let .failed(message) = photoState.wrappedValue else { return nil }
            return Text(message)
        }
        
        private var avatarImage: UIImage {
            selectedImage ?? Asset.uploadImagePlaceholder.image
        }

        // MARK: - Initializator
        public init(createAccountAction: Action,
                    chooseFromCameraAction: Action,
                    chooseFromGalleryAction: Action,
                    screenProgress: Progress,
                    firstName: Binding<String>,
                    lastName: Binding<String>,
                    phoneNumber: Binding<String>,
                    bio: Binding<String>,
                    photoState: Binding<Utils.PhotoGallery.TakePhotoState>) {
            self.createAccountAction = createAccountAction
            self.chooseFromCameraAction = chooseFromCameraAction
            self.chooseFromGalleryAction = chooseFromGalleryAction
            self.screenProgress = screenProgress
            self.firstName = firstName
            self.lastName = lastName
            self.phoneNumber = phoneNumber
            self.bio = bio
            self.photoState = photoState
        }

        public var body: some View {
            VStack {
                Spacer()
                uploadPhoto()
                Spacer()
                firstNameField()
                lastNameField()
                phoneNumberField()
                bioField()
                Spacer()
                createAccountButton()
            }
            .padding(.horizontal, Defaults.Padding.horizontal)
            .navigationTitle(Strings.CompleteProfile.title)
            .navigationBarBackButtonHidden(true)
            .isLoading(screenProgress == .active)
            .alert(item: $alertItem, content: { item in
                item.alert
            })
            .sheet(isPresented: canPresentImagePicker, onDismiss: onDismiss, content: imagePickerView)
            .sheet(isPresented: canPresentImageCrop, onDismiss: onDismiss, content: cropView)
            .onChange(of: screenProgress) { newValue in
                guard newValue.isPresented, let message = newValue.message else { return }
                alertItem = AlertItem(alert: Alert.error(message: message, onDismiss: onDismissAlert))
            }
            .onChange(of: isPermissionDenied) { newValue in
                guard newValue else { return }
                alertItem = AlertItem(alert: permissionAlert())
            }
            .onChange(of: isPermissionErrorOccur) { newValue in
                guard newValue else { return }
                alertItem = AlertItem(alert: Alert.error(message: permissionErrorMessage, onDismiss: onDismissPermissionAlert))
            }
        }
    }
}

// MARK: - Private Views
private extension SignUp.CompleteProfile {
    func uploadPhoto() -> some View {
        Label {
            Text(Strings.CompleteProfile.Buttons.uploadPhoto)
                .font(Font.system(size: Defaults.UploadPhoto.fontSize))
        } icon: {
            Image(uiImage: avatarImage)
                .resizable()
                .frame(width: Defaults.UploadPhoto.ImageView.width,
                       height: Defaults.UploadPhoto.ImageView.height,
                       alignment: .center)
        }
        .labelStyle(VerticalLabelStyle())
        .onTapGesture(perform: onUploadPhoto)
        .actionSheet(isPresented: $shouldShowSheet, content: {
            ActionSheet(
                title: Text(Strings.CompleteProfile.Sheet.title),
                buttons: [
                    .default(Text(Strings.Sheet.Action.camera), action: onChooseCamera),
                    .default(Text(Strings.Sheet.Action.gallery), action: onChooseGallery),
                    .cancel()
                ]
            )
        })
    }
    
    func firstNameField() -> some View {
        TextField(Strings.CompleteProfile.Inputs.FirstName.placeholder, text: firstName)
            .keyboardType(.default)
            .textContentType(.givenName)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .roundedTextField()
    }
    
    func lastNameField() -> some View {
        TextField(Strings.CompleteProfile.Inputs.LastName.placeholder, text: lastName)
            .keyboardType(.default)
            .textContentType(.middleName)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .roundedTextField()
    }
    
    func phoneNumberField() -> some View {
        TextField(Strings.CompleteProfile.Inputs.PhoneNumber.placeholder, text: phoneNumber)
            .keyboardType(.phonePad)
            .textContentType(.telephoneNumber)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .roundedTextField()
    }
    
    func bioField() -> some View {
        TextField(Strings.CompleteProfile.Inputs.Bio.placeholder, text: bio)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .roundedTextField()
    }
    
    func createAccountButton() -> some View {
        Button(action: {
            onCreateAccount()
        }, label: {
            Spacer()
            Text(Strings.CompleteProfile.Buttons.createAccount.uppercased())
                .font(Font.system(size: Defaults.Buttons.CreateAccount.fontSize))
            Spacer()
        })
        .mainButton()
        .padding(.bottom, Defaults.Buttons.CreateAccount.bottomPadding)
    }
    
    func imagePickerView() -> AnyView {
        guard let sourceType = imagePickerSourceType else { return EmptyView().eraseToAnyView() }
        return ImagePicker(sourceType: sourceType, selectedImageData: Binding<UIImage?>(get: {
            selectedImage
        }, set: { image in
            image.map { photoState.wrappedValue = .crop($0) }
        })).eraseToAnyView()
    }
    
    func cropView() -> AnyView {
        guard let source = cropViewSource else { return EmptyView().eraseToAnyView() }
        return Cropping.ImageView(
            source,
            shape: Cropping.CircleShapeProvider(),
            onCancel: onDismiss,
            onCrop: onCropImage(_:)
        ).eraseToAnyView()
    }
    
    func permissionAlert() -> Alert {
        Alert.permissionDenied(onSettings: onDismissPermissionAlert, onCancel: onDismissPermissionAlert)
    }
}

// MARK: - Handle Actions
private extension SignUp.CompleteProfile {
    func onCropImage(_ image: UIImage?) {
        guard let image = image else {
            onDismiss()
            return
        }
        selectedImage = image
        photoState.wrappedValue = .compress(image)
    }
    
    func onDismiss() {
        photoState.wrappedValue = .none
    }
    
    func onDismissAlert() {
        alertItem = nil
    }
    
    func onDismissPermissionAlert() {
        onDismiss()
        onDismissAlert()
    }
    
    func onUploadPhoto() {
        shouldShowSheet = true
    }
    
    func onCreateAccount() {
        guard case let .available(action) = createAccountAction else { return }
        action()
    }
    
    func onChooseCamera() {
        guard case let .available(action) = chooseFromCameraAction else { return }
        action()
    }
    
    func onChooseGallery() {
        guard case let .available(action) = chooseFromGalleryAction else { return }
        action()
    }
}

// MARK: - AlertItem
private extension SignUp.CompleteProfile {
    struct AlertItem: Identifiable {
        var id = UUID()
        var alert: Alert
    }
}

// MARK: - Defaults
private extension SignUp.CompleteProfile {
    enum Defaults {
        enum UploadPhoto {
            enum ImageView {
                static let height: CGFloat = 90
                static let width: CGFloat = 90
            }
            static let fontSize: CGFloat = 17
        }
        
        enum Padding {
            static let horizontal: CGFloat = 38
        }

        enum Buttons {
            enum CreateAccount {
                static let fontSize: CGFloat = 15
                static let bottomPadding: CGFloat = 16
            }
        }
    }
}

// MARK: - Preview
struct SignUpCompleteProfile_Previews: PreviewProvider {
    static var previews: some View {
        SignUp.CompleteProfile(
            createAccountAction: .unavailable,
            chooseFromCameraAction: .unavailable,
            chooseFromGalleryAction: .unavailable,
            screenProgress: .none,
            firstName: .empty,
            lastName: .empty,
            phoneNumber: .empty,
            bio: .empty,
            photoState: .constant(.none)
        )
    }
}
