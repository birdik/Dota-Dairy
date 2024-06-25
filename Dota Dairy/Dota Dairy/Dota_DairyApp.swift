//
//  Dota_DairyApp.swift
//  Dota Dairy
//
//  Created by birdik on 11.06.2024.
//

import SwiftUI
import FirebaseCore
import ApphudSDK
import OneSignalFramework
import YandexMobileMetrica


class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Apphud.start(apiKey: "app_jMCMfKVSnnAjGb5fTAVh4ExEpubNqw")
        
        OneSignal.initialize("1c652da4-5cb7-4a0b-8e9a-66c190b7a1d4", withLaunchOptions: launchOptions)


        let configuration = YMMYandexMetricaConfiguration.init(apiKey: "bbd018bf-e5bc-463f-91c5-7cd3db87f0a7")
        YMMYandexMetrica.activate(with: configuration!)
        
        FirebaseApp.configure()
        
        return true
    }
}




@main
struct Dota_DairyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environment(\.colorScheme, .light)
        }
    }
}


