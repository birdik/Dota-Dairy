//
//  User1Onboard3.swift
//  Dota Dairy
//
//  Created by birdik on 14.06.2024.
//

import SwiftUI
import OneSignalFramework

struct User1Onboard3: View {
    @AppStorage("view1") var view1: Bool = false
    
    var body: some View {
        ZStack {
            Color.load1
                .ignoresSafeArea()
            
            Image("notifi")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 237, height: 267)

            
            VStack (alignment: .center, spacing: 5) {
                Text("")
                    .frame(width: 152, height: 6)
                    .padding()
                VStack {
                    Text("Don’t miss anything")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(1)
                    Text("Don’t miss the most userful information")
                        .foregroundColor(.init(white: 0.8))
                        .font(.subheadline)
                    
                }
                
                Spacer()
                
                Button {
                    OneSignal.Notifications.requestPermission({ accepted in
                      print("User accepted notifications: \(accepted)")
                        view1 = true
                    }, fallbackToSettings: true)
                } label: {
                    Text("Enable notifications")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color("Color"))
                        .cornerRadius(15)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    User1Onboard3()
}
