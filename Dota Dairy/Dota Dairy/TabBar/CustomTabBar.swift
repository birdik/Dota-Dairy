//
//  CustomTabBar.swift
//  Dota Dairy
//
//  Created by birdik on 15.06.2024.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack {
            CustomTabBarItem(imageName: "gamecontroller.fill", spaceAbove: 10, isSelected: selectedIndex == 0) {
                selectedIndex = 0
            }
            
            Spacer()
            
            CustomTabBarItem(imageName: "trophy.fill", spaceAbove: 10, isSelected: selectedIndex == 1) {
                selectedIndex = 1
            }
            
            Spacer()
            
            CustomTabBarItem(imageName: "chart.xyaxis.line", spaceAbove: 10, isSelected: selectedIndex == 2) {
                selectedIndex = 2
            }
            
            Spacer()
            
            CustomTabBarItem(imageName: "gearshape.fill", spaceAbove: 10, isSelected: selectedIndex == 3) {
                selectedIndex = 3
            }
        }
        .padding(.horizontal)
        .padding(.top, 1)
        .background(Color.color1)
    }
}


