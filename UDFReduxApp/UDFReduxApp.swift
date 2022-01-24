//
//  UDFReduxApp.swift
//  UDFReduxApp
//
//  Created by Ihor Yarovyi on 7/24/21.
//

import SwiftUI
import Redux
import SideEffects
import DatabaseClient
import EnvConfig
import Core
import Utils

@main
struct UDFReduxApp: App {
    
    private let store = Store(initial: AppState()) { state, action in
        print("Reduce\t\t\t", action)
        state.reduce(action)
    }
    
    private let databaseClient: DatabaseClient.Instance = DatabaseClient.Instance.sqlInstance()
    private let signInSE: SideEffects.SignIn
    private let restoreSessionSE: SideEffects.RestoreSession
    private let signUpSE: SideEffects.SignUp
    private let completeProfileSE: SideEffects.CompleteProfile
    private let uploadImageMediaSE: SideEffects.UploadImage
    private let restorePasswordSE: SideEffects.RestorePassword
    
    init() {
        signInSE = SideEffects.SignIn(store: store, databaseClient: databaseClient)
        restoreSessionSE = SideEffects.RestoreSession(store: store, databaseClient: databaseClient)
        signUpSE = SideEffects.SignUp(store: store, databaseClient: databaseClient)
        completeProfileSE = SideEffects.CompleteProfile(store: store, databaseClient: databaseClient)
        uploadImageMediaSE = SideEffects.UploadImage(store: store)
        restorePasswordSE = SideEffects.RestorePassword(store: store)
        
        store.subscribe(observer: signInSE.asObserver)
        store.subscribe(observer: restoreSessionSE.asObserver)
        store.subscribe(observer: signUpSE.asObserver)
        store.subscribe(observer: completeProfileSE.asObserver)
        store.subscribe(observer: uploadImageMediaSE.asObserver)
        store.subscribe(observer: restorePasswordSE.asObserver)
    }
    
    var body: some Scene {
        WindowGroup {
            StoreProvider(store: store) {
                AppFlowConnector()
            }
            .onAppear {
                // Workaround: this small delay is needed for the correct flow switching
                // in AppFlowBuilder when the user open the app via a deep or universal link
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    store.dispatch(action: Actions.Session.RestoreSession())
                }
            }
            .onOpenURL { url in
                store.dispatch(action: Actions.DeepLink.Start())
                Utils.DeepLink.Handler.handleUserActivity(with: url).map {
                    store.dispatch(action: Actions.DeepLink.DidReceive(kind: $0))
                }
            }
        }
    }
}
