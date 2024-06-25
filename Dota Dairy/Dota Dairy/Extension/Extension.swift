//
//  Extension.swift
//  Dota Dairy
//
//  Created by birdik on 14.06.2024.
//

import SwiftUI
import FirebaseRemoteConfig

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

extension Color {
    static let systemTeal = Color(UIColor.systemTeal)
}

enum DataType {
    case bool
    case url
    case string
}

func getFirebaseData(field: String, dataType: DataType, completion: @escaping (Any?) -> Void) {
    let config = RemoteConfig.remoteConfig()
    
    let settings = RemoteConfigSettings()
    settings.minimumFetchInterval = 300
    config.configSettings = settings
    

    config.fetchAndActivate { status, error in
        guard error == nil else {
            print("Ошибка получения конфигурации: \(error!.localizedDescription)")
            return
        }
        
        switch dataType {
        case .bool:
            let value = config.configValue(forKey: field).boolValue
            completion(value)
        case .url:
            if let urlString = config.configValue(forKey: field).stringValue {
                completion(urlString)
            } else {
                return
            }
        case .string:
            let value = config.configValue(forKey: field).stringValue
            completion(value)
        }
    }
}

