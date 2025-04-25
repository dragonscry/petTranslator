//
//  CustomTabBar.swift
//  PetTranslator
//
//  Created by Денис Меркотун on 24.04.2025.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: TabViewEnum
    var body: some View {
        HStack(spacing: 70) {
            ForEach(TabViewEnum.allCases) { tabView in
                Button {
                    withAnimation {
                        selectedTab = tabView
                    }
                } label: {
                    VStack(spacing: 0) {
                        Image(systemName: tabView.tabItem.systemImage)
                            .font(.system(size: 25))
                        Text(tabView.tabItem.name)
                            .font(.system(size: 13))
                    }
                    .foregroundStyle(tabView == selectedTab ? .black : .gray)
                }
                .disabled(tabView == selectedTab)
                
            }
        }
        .padding(.vertical, 25)
        .padding(.horizontal, 40)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))


    }
}

#Preview {
    @Previewable @State var selectedTab = TabViewEnum.translator
    CustomTabBar(selectedTab: $selectedTab)
}
