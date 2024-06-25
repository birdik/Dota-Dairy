//
//  LoadingView1.swift
//  Dota Dairy
//
//  Created by birdik on 17.06.2024.
//

import SwiftUI

struct LoadingView1: View {
    @Binding var isLoading: Double
    
    var body: some View {
        ZStack {
            Color.load1
                .ignoresSafeArea()
            VStack {
                Spacer()
                Image("logo 1")
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: 243, height: 162)
                Spacer()
                ProgressView(value: isLoading, total: 100)
                    .background(Color.white)
                    .cornerRadius(10)
                    .scaleEffect(2.5)
                    .frame(width: 65, height: 230)
            }
        }
    }
}

