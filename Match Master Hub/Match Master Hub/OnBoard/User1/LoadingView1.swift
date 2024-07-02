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
            LinearGradient(gradient: Gradient(colors: [.color3, .color4]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Image("logo 1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 210, height: 160)
                Spacer()
                ProgressView(value: isLoading, total: 100)
                    .background(Color.white)
                    .cornerRadius(10)
                    .scaleEffect(2.5)
                    .frame(width: 55, height: 150)
            }
        }
    }
}

struct AddContainer_Previews: PreviewProvider {
    @State static var isLoading = 50.0
  static var previews: some View {
      LoadingView1(isLoading: $isLoading)
  }
}
