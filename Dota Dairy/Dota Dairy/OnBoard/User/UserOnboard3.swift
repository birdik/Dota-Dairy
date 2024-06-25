//
//  UserOnboard3.swift
//  Dota Dairy
//
//  Created by birdik on 11.06.2024.
//

import SwiftUI

struct UserOnboard3: View {
    
    @AppStorage("view") var view: Bool = false
    
    var body: some View {
        ZStack {
            Image("Frame")
                .resizable()
                .ignoresSafeArea()
            
            Image("user3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
            
            VStack (alignment: .center, spacing: 5) {
                Image("Frame3")
                    .resizable()
                    .frame(width: 232, height: 6)
                    .padding()
                VStack {
                    Text("Be in focus with games")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(1)
                    Text("Fill out the game calendar!")
                        .foregroundColor(.init(white: 0.8))
                        .font(.subheadline)
                }
                
                Spacer()
                
                Button {
                    view = true
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
    UserOnboard3()
}
