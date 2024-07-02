//
//  User1Onboard.swift
//  Dota Dairy
//
//  Created by birdik on 14.06.2024.
//

import SwiftUI
import StoreKit

struct User1Onboard2: View {
    @State private var isStar = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.color5, .color6]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            Image("users3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
            
            VStack (alignment: .center, spacing: 5) {
                Image("Frames2")
                    .resizable()
                    .frame(width: 152, height: 6)
                    .padding()
                VStack {
                    Text("Rate our app in the \n AppStore")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(1)
                    Text("Help make the app even better")
                        .foregroundColor(.init(white: 0.8))
                        .font(.subheadline)
                }
                
                Spacer()
                
                if isStar {
                    NavigationLink {
                        User1Onboard3()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Next")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color("Color"))
                            .cornerRadius(15)
                            .padding()
                    }
                } else {
                    Button {
                        SKStoreReviewController.requestReview()
                        isStar = true
                    } label: {
                        Text("Next")
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
}

#Preview {
    User1Onboard2()
}
