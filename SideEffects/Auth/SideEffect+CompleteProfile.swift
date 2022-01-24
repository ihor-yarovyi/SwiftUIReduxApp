//
//  
//  SideEffect+CompleteProfile.swift
//  SideEffects
//
//  Created by Ihor Yarovyi on 10/16/21.
//
//

import Redux
import Models
import Core
import NetworkClient
import DatabaseClient
import Utils
import Resources

public extension SideEffects {
    struct CompleteProfile: RequestManager {
        // MARK: - Public Properties
        public let databaseClient: DatabaseClient.Instance
        public let store: Store
        public var asObserver: Observer {
            Observer(queue: QueueProvider.shared.queue) { state in
                observe(state: state)
                return .active
            }
        }

        // MARK: - Lifecycle
        public init(store: Store, databaseClient: DatabaseClient.Instance) {
            self.store = store
            self.databaseClient = databaseClient
        }

        public func observe(state: AppState) {
            var requests: [NetworkClient.OperatorRequest] = []
            
            defer {
                NetworkClient.network.process(requests: requests)
            }
            
            handleCompleteProfileFlow(state: state, requests: &requests)
            handleImageUploadFlow(state: state)
        }
    }
}

// MARK: - Handle Flows
private extension SideEffects.CompleteProfile {
    func handleCompleteProfileFlow(state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        switch state.completeProfileFlow {
        case .none:
            break
        case .requestAccessToCamera:
            onRequestAccessToCamera()
        case .requestAccessToGallery:
            onRequestAccessToGallery()
        case .compressPhoto:
            onCompressPhoto(state: state)
        case .validation:
            onValidateCredential(state: state)
        case let .completeProfile(id):
            onCompleteProfile(id: id, state: state, requests: &requests)
        case let .uploadAvatar(id):
            onUploadAvatar(id: id, state: state, requests: &requests)
        case .performUpload:
            onPerformUpload()
        }
    }
    
    func handleImageUploadFlow(state: AppState) {
        switch state.uploadImageMediaStatus {
        case let .success(item):
            guard state.completeProfileForm.imageItem?.id == item.id else { return }
            store.dispatch(action: Actions.CompleteProfile.Completed())
        case let .failed(error, item):
            guard state.completeProfileForm.imageItem?.id == item.id else { return }
            store.dispatch(action: Actions.CompleteProfile.UploadFailed(error, item: item))
        default:
            break
        }
    }
}

// MARK: - Handle Actions
private extension SideEffects.CompleteProfile {
    func onPerformUpload() {
        guard let uploadedItem = store.state.completeProfileForm.imageItem else { return }
        store.dispatch(action: Actions.UploadMedia.Upload(uploadedItem))
    }
    
    func onUploadAvatar(id: UUID, state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        guard case let .done(image) = state.completeProfileForm.photoState else {
            store.dispatch(action: Actions.CompleteProfile.Completed())
            return
        }
        let uploadItem = Utils.Media.Item(id: id, image: image, type: Utils.ImageType.Avatar())
        store.dispatch(action: Actions.CompleteProfile.UploadImageItem(uploadItem))
    }
    
    func onCompleteProfile(id: UUID, state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        guard let credential = state.completeProfileForm.credential else { return }
        add(
            id,
            request: NetworkClient.auth.completeProfile(
                firstName: credential.firstName.value,
                lastName: credential.lastName?.value,
                phone: credential.phoneNumber?.value,
                bio: credential.bio?.value
            ),
            to: &requests
        ) { response in
            switch response {
            case let .success(result):
                store.dispatch(action: Actions.Session.ReceiveSession(Models.Mappers.Auth.map(result.data)))
            case let .failed(error):
                store.dispatch(action: Actions.CompleteProfile.RequestFailed(error))
            default:
                preconditionFailure("Unexpected case")
            }
        }
    }
    
    func onValidateCredential(state: AppState) {
        do {
            let form = state.completeProfileForm
            let firstName = try Models.Auth.FirstName.parse(value: form.firstName).get()
            let lastName = !form.lastName.isEmpty ? try Models.Auth.LastName.parse(value: form.lastName).get() : nil
            let phoneNumber = !form.phoneNumber.isEmpty ? try Models.Auth.PhoneNumber.parse(value: form.phoneNumber).get() : nil
            let bio = !form.bioInfo.isEmpty ? try Models.Auth.BioInfo.parse(value: form.bioInfo).get() : nil
            let credential = Models.Auth.CompleteProfileCredential(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, bio: bio)
            store.dispatch(action: Actions.CompleteProfile.UpdateCredential(credential))
        } catch {
            store.dispatch(action: Actions.CompleteProfile.InvalidCredential(error: error))
        }
    }
    
    func onCompressPhoto(state: AppState) {
        guard case let .compress(image) = state.completeProfileForm.photoState else { return }
        image.compress { compressedImage in
            if let compressedImage = compressedImage {
                store.dispatch(action: Actions.CompleteProfile.UpdatePhotoState(state: .done(compressedImage)))
            } else {
                store.dispatch(action: Actions.CompleteProfile.UpdatePhotoState(state: .none))
            }
        }
    }
    
    func onRequestAccessToCamera() {
        Utils.Permission<Utils.PermissionTypes.Camera>.check { status in
            switch status {
            case .authorized:
                store.dispatch(action: Actions.CompleteProfile.UpdatePhotoState(state: .take(.camera)))
            case .denied:
                onDeniedAccess(to: String(describing: Utils.PermissionTypes.Camera.self))
            case .notDetermined:
                Utils.Permission<Utils.PermissionTypes.Camera>.request { status in
                    handleRequestStatus(status, for: .camera)
                }
            }
        }
    }
    
    func onRequestAccessToGallery() {
        Utils.Permission<Utils.PermissionTypes.Gallery>.check { status in
            switch status {
            case .authorized:
                store.dispatch(action: Actions.CompleteProfile.UpdatePhotoState(state: .take(.gallery)))
            case .denied:
                onDeniedAccess(to: String(describing: Utils.PermissionTypes.Gallery.self))
            case .notDetermined:
                Utils.Permission<Utils.PermissionTypes.Gallery>.request { status in
                    handleRequestStatus(status, for: .gallery)
                }
            }
        }
    }
    
    func onDeniedAccess(to resourceName: String) {
        store.dispatch(action: Actions.CompleteProfile.UpdatePhotoState(
            state: .denied(errorMessage: Strings.Alert.Messages.denied(resourceName)))
        )
    }
    
    func handleRequestStatus(_ status: Utils.PermissionStatus, for resource: Utils.PhotoGallery.Source) {
        switch status {
        case .denied, .notDetermined:
            store.dispatch(action: Actions.CompleteProfile.UpdatePhotoState(state: .none))
        case .authorized:
            store.dispatch(action: Actions.CompleteProfile.UpdatePhotoState(state: .take(resource)))
        }
    }
}
