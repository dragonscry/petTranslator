//
//  StartTab.swift
//  PetTranslator
//
//  Created by Денис Меркотун on 24.04.2025.
//

import SwiftUI

struct StartTab: View {
    @State private var selectedTab: TabViewEnum = .translator
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabViewEnum.allCases) { tab in
                let tabItem = tab.tabItem
                Tab(
                    tabItem.name,
                    systemImage: tabItem.systemImage, value: tab){
                        tab
                            .toolbarVisibility(.hidden, for: .tabBar)
                    }
            }
        }
        //place our custom bar
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer(minLength: 25)
                CustomTabBar(selectedTab: $selectedTab)
                Spacer(minLength: 25)
            }
            .padding(.bottom, 20)
        }
        
    }
}

#Preview {
    StartTab()
}
