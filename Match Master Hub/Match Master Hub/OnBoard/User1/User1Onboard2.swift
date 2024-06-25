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
            if isStar {
                LinearGradient(gradient: Gradient(colors: [.color, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
            } else {
                Color.load1
                    .ignoresSafeArea()
            }
            
            Image(isStar ? "users3" : "users2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
            
            VStack (alignment: .center, spacing: 5) {
                Image(isStar ? "Frames3" : "Frames2")
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
