//
//  
//  SideEffect+UploadImage.swift
//  SideEffects
//
//  Created by Ihor Yarovyi on 12/16/21.
//
//

import Redux
import Models
import Core
import NetworkClient
import Utils
import Combine

public extension SideEffects {
    final class UploadImage: GroupRequestManager {
        // MARK: - Public Properties
        public let store: Store
        public var asObserver: Observer {
            Observer(queue: QueueProvider.shared.queue) { [weak self] state in
                self?.observe(state: state)
                return .active
            }
        }
        
        // MARK: - Private Properties
        private var groupSubscriptions: AnyCancellable?

        // MARK: - Lifecycle
        public init(store: Store) {
            self.store = store
        }

        public func observe(state: AppState) {
            var requests: [NetworkClient.OperatorRequest] = []
            
            defer {
                NetworkClient.network.process(requests: requests)
            }
            
            handleUploadImageFlow(state: state, requests: &requests)
        }
    }
}

// MARK: - Handle Actions
private extension SideEffects.UploadImage {
    func handleUploadImageFlow(state: AppState, requests: inout [NetworkClient.OperatorRequest]) {
        switch state.uploadImageMediaFlow {
        case .none:
            break
        case let .downsample(item):
            onDownsample(item: item)
        case let .prepareS3(id, item, imageItem):
            onPrepare(id: id, item: item, imageItem: imageItem, requests: &requests)
        case let .upload(id, item, fileInfo, imageItem):
            onUpload(id: id, item: item, fileInfo: fileInfo, imageItem: imageItem, requests: &requests)
        case let .updateFileStatus(id, fileId, imageItem):
            onUpdateFileStatus(id: id, fileId: fileId, imageItem: imageItem, requests: &requests)
        case let .addPhoto(id, fileId, imageItem):
            onAddPhoto(id: id, fileId: fileId, imageItem: imageItem, requests: &requests)
        }
    }
    
    func onDownsample(item: Utils.Media.Item) {
        DispatchQueue.global().async {
            guard let original = item.image.pngData(),
                  let small = original.downsample(to: item.type.small),
                  let medium = original.downsample(to: item.type.medium) else { return }
            let resized = Utils.Media.Resized(
                original: original,
                thumbnails: [
                    .init(data: small, size: item.type.small),
                    .init(data: medium, size: item.type.medium)
                ]
            )
            self.store.dispatch(action: Actions.UploadMedia.Resized(id: item.id, item: resized, imageItem: item))
        }
    }
    
    func onPrepare(id: UUID, item: Utils.Media.Resized, imageItem: Utils.Media.Item, requests: inout [NetworkClient.OperatorRequest]) {
        let parameters = NetworkClient.API.Model.Media.PrepareFileParameters(
            contentType: .jpeg,
            fileType: .image,
            resizePrefixes: item.thumbnails.map { $0.size.prefix }
        )
        add(
            id,
            request: NetworkClient.media.prepareS3Files(with: [parameters]),
            to: &requests
        ) { [weak self] response in
            switch response {
            case let .success(fileInfo):
                guard let data = fileInfo.data.first else { return }
                let fileInfo = Models.Mappers.Media.map(data)
                self?.store.dispatch(action: Actions.UploadMedia.PreparedOnS3(fileInfo: fileInfo, item: item, imageItem: imageItem))
            case let .failed(error):
                self?.store.dispatch(action: Actions.UploadMedia.Failed(error, imageItem: imageItem))
            default:
                preconditionFailure("Unexpected case")
            }
        }
    }
    
    func onUpload(id: UUID,
                  item: Utils.Media.Resized,
                  fileInfo: Models.Media.FileInfo,
                  imageItem: Utils.Media.Item,
                  requests: inout [NetworkClient.OperatorRequest]) {
        var uploadRequests = item.thumbnails.enumerated().map { index, thumbnail in
            NetworkClient.media.upload(data: thumbnail.data,
                                       with: Models.Mappers.Media.map(fileInfo.metaForResize[index]),
                                       type: .image)
        }
        uploadRequests.insert(
            NetworkClient.media.upload(data: item.original, with: Models.Mappers.Media.map(fileInfo.meta), type: .image),
            at: .zero
        )
        groupSubscriptions = addGroup(
            requests: uploadRequests,
            to: &requests
        ) { [weak self] response in
            switch response {
            case .success:
                self?.store.dispatch(action: Actions.UploadMedia.Uploaded(fileId: fileInfo.file.id, imageItem: imageItem))
            case let .failed(error):
                self?.store.dispatch(action: Actions.UploadMedia.Failed(error, imageItem: imageItem))
            default:
                preconditionFailure("Unexpected case")
            }
        }
    }
    
    func onUpdateFileStatus(id: UUID, fileId: Int64, imageItem: Utils.Media.Item, requests: inout [NetworkClient.OperatorRequest]) {
        add(
            id,
            request: NetworkClient.media.updateFileStatus(fileId: fileId),
            to: &requests
        ) { [weak self] response in
            switch response {
            case .success, .successWithoutResult:
                self?.store.dispatch(action: Actions.UploadMedia.FileStatusUpdated(fileId: fileId, imageItem: imageItem))
            case let .failed(error):
                self?.store.dispatch(action: Actions.UploadMedia.Failed(error, imageItem: imageItem))
            default:
                preconditionFailure("Unexpected case")
            }
        }
    }
    
    func onAddPhoto(id: UUID, fileId: Int64, imageItem: Utils.Media.Item, requests: inout [NetworkClient.OperatorRequest]) {
        add(
            id,
            request: NetworkClient.media.addPhoto(fileId: fileId),
            to: &requests
        ) { [weak self] response in
            switch response {
            case let .success(avatar):
                let avatar = Models.Mappers.Media.map(avatar.data)
                self?.store.dispatch(action: Actions.UploadMedia.DidUploadImage(avatar, imageItem: imageItem))
            case let .failed(error):
                self?.store.dispatch(action: Actions.UploadMedia.Failed(error, imageItem: imageItem))
            default:
                preconditionFailure("Unexpected case")
            }
        }
    }
}
