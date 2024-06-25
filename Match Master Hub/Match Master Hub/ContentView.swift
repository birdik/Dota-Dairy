//
//  ContentView.swift
//  Match Master Hub
//
//  Created by birdik on 25.06.2024.
//

import SwiftUI
import YandexMobileMetrica

struct ContentView: View {
    @State private var selectedIndex: Int = 0
    
    @AppStorage("isBlock") var isBlock: Bool = true
    @State var isData: Bool = false
    @State var isDead: Bool = false
    
    @State var isLoading: Double = 0
    
    @AppStorage("view") var view: Bool = false
    @AppStorage("view1") var view1: Bool = false
    
    
    var body: some View {
        ZStack {
            Color(.color1)
                .ignoresSafeArea()
            if isData == false {
                if isBlock {
                    LoadingView(isLoading: $isLoading)
                } else {
                    LoadingView1(isLoading: $isLoading)
                }
            } else if isData == true {
                if isBlock {
                    if view {
                        VStack {
                            switch selectedIndex {
                            case 0:
                                MatchesView()
                            case 1:
                                TournamentsView()
                            case 2:
                                StatisticsView()
                            default:
                                SettingView()
                            }
                            
                            CustomTabBar(selectedIndex: $selectedIndex)
                        }
                        .onAppear {
                            YMMYandexMetrica.reportEvent("did_show_main_screen")
                        }
                    } else {
                        NavigationView {
                            UserOnboard1()
                        }
                    }
                } else {
                    if view1 {
                        WebView()
                    } else {
                        NavigationView {
                            User1Onboard1()
                        }
                    }
                }
            }
        }
        .onAppear() {
            checkData()
        }
    }
    
    private func checkData() {
        
        isLoading = 10
        getFirebaseData(field: "isDead", dataType: .bool) { resultDead in
            
            isDead = resultDead as? Bool ?? false
            
            isLoading = 40
            
            getFirebaseData(field: "lastDate", dataType: .string) { lastDate in
                isLoading = 80
                let newDate = lastDate as? String ?? "01.01.2040"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"
                guard let date = dateFormatter.date(from: newDate) else { return }
                let data  = compareDates(dateToCompare: date)
                isLoading = 100
                if data {
                    isData = true
                    isBlock = true
                } else {
                    Task {
                        let result = await NetworkService.fetchDataDevice(data: DeviceInfo.TelephoneData())
                        if result {
                            isData = true
                            isBlock = true
                        } else {
                            isData = true
                            isBlock = isDead
                        }
                    }
                }
            }
        }
            
    }
    
    func compareDates(dateToCompare: Date) -> Bool {
        let currentDate = Date()
        
        if dateToCompare < currentDate {
            return false
        } else {
            return true
        }
    }
}

