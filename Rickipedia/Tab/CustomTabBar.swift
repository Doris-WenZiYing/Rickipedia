//
//  CustomTabBar.swift
//  Rickipedia
//
//  Created by App_team on 2024/12/14.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    let tabItems: [TabItem]
    
    var body: some View {
        HStack {
            ForEach(tabItems.indices, id: \.self) { index in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) { // Smooth animation for tab selection
                        selectedTab = index
                    }
                }) {
                    VStack(spacing: 5) {
                        ZStack {
                            if selectedTab == index {
                                Circle()
                                    .fill(Color(hex: "#97CE4C"))
                                    .frame(width: 40, height: 40)
                                    .transition(.scale)
                            }
                            Image(systemName: tabItems[index].icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(selectedTab == index ? Color(hex: "#051622") : Color(hex: "#8A939B"))
                        }
                        Text(tabItems[index].title)
                            .font(.caption)
                            .foregroundColor(selectedTab == index ? Color(hex: "#97CE4C") : Color(hex: "#8A939B"))
                    }
                    .padding(10)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color(hex: "#142F43").opacity(0.95))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 4)
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(0), tabItems: TabItem.allItems)
}
