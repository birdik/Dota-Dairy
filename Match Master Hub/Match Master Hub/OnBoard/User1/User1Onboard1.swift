//
//  User1Onboard1.swift
//  Dota Dairy
//
//  Created by birdik on 14.06.2024.
//

import SwiftUI

struct User1Onboard1: View {
    var body: some View {
        ZStack {
            Color.load1
                .ignoresSafeArea()
            
            Image("users1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
            
            VStack (alignment: .center, spacing: 5) {
                Image("Frames1")
                    .resizable()
                    .frame(width: 152, height: 6)
                    .padding()
                VStack {
                    Text("Buy and take profit")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(1)
                    Text("Earn money for your dreams")
                        .foregroundColor(.init(white: 0.8))
                        .font(.subheadline)
                }
                
                Spacer()
                
                NavigationLink {
                    User1Onboard2()
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
            }
        }
    }
}

#Preview {
    User1Onboard1()
}
