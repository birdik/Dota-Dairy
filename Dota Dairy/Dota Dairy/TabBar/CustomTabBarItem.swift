//
//  CustomTabBarItem.swift
//  Dota Dairy
//
//  Created by birdik on 15.06.2024.
//

import SwiftUI

struct CustomTabBarItem: View {
    var imageName: String
    var spaceAbove: CGFloat
    
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            VStack {
                Spacer().frame(height: spaceAbove)
                Image(systemName: imageName)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .color2 : .gray)
            }
        }
    }
}

