//
//  ContentView.swift
//  Rickipedia
//
//  Created by App_team on 2024/12/14.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab: Int = 0
    
    let tabItems = TabItem.allItems
    
    var body: some View {
        ZStack {
            Color(hex: "#051622")
            Group {
                switch selectedTab {
                case 0:
                    CharactersView()
                case 1:
                    LocationView()
                case 2:
                    EpisodesView()
                default:
                    CharactersView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $selectedTab, tabItems: tabItems)
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    RootView()
        .preferredColorScheme(.dark)
}
