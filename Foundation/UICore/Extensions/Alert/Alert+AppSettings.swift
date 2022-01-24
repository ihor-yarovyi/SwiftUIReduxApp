//
//  Alert+AppSettings.swift
//  UICore
//
//  Created by Ihor Yarovyi on 10/31/21.
//

import SwiftUI
import Resources

public extension Alert {
    static func appSettings(title: String, message: String?, onSettings: @escaping (() -> Void), onCancel: @escaping (() -> Void)) -> Alert {
        Alert(
            title: Text(title),
            message: message.map { Text($0) },
            primaryButton: .default(Text(Strings.Alert.Actions.settings), action: {
                guard let url = URL(string: UIApplication.openSettingsURLString),
                      UIApplication.shared.canOpenURL(url) else { return }
                UIApplication.shared.open(url)
                onSettings()
            }),
            secondaryButton: .cancel(onCancel)
        )
    }
    
    static func permissionDenied(onSettings: @escaping (() -> Void), onCancel: @escaping (() -> Void)) -> Alert {
        appSettings(title: Strings.Alert.Titles.permissionDenied, message: nil, onSettings: onSettings, onCancel: onCancel)
    }
}
