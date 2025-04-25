//
//  ContentView.swift
//  PetTranslator
//
//  Created by Денис Меркотун on 24.04.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: TabViewEnum = .translator
    var body: some View {
        ZStack(alignment: .bottom) {
            Background()
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
