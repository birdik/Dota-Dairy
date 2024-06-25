//
//  LoadingView.swift
//  Dota Dairy
//
//  Created by birdik on 11.06.2024.
//

import SwiftUI

struct LoadingView: View {
    @Binding var isLoading: Double
    var body: some View {
        ZStack {
            Image("Frame")
                .resizable()
                .ignoresSafeArea()
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(width: 198, height: 198)
            VStack {
                Spacer()
                ProgressView(value: isLoading, total: 100)
                    .scaleEffect(2.5)
                    .frame(width: 65, height: 230)
            }
        }
    }
}


