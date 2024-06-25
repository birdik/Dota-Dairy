//
//  UserOnboard1.swift
//  Dota Dairy
//
//  Created by birdik on 11.06.2024.
//

import SwiftUI

struct UserOnboard1: View {
    
    var body: some View {
        ZStack {
            Image("Frame")
                .resizable()
                .ignoresSafeArea()
            
            Image("user1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
            
            VStack (alignment: .center, spacing: 5) {
                Image("Frame1")
                    .resizable()
                    .frame(width: 232, height: 6)
                    .padding()
                VStack {
                    Text("Manage your team!")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(1)
                    Text("Be your own trainer!")
                        .foregroundColor(.init(white: 0.8))
                        .font(.subheadline)
                }
                
                Spacer()
                
                NavigationLink {
                    UserOnboard2()
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
    UserOnboard1()
}
