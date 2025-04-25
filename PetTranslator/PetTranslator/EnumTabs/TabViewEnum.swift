//
//  TabViewEnum.swift
//  PetTranslator
//
//  Created by Денис Меркотун on 24.04.2025.
//

import SwiftUI

struct TabItem {
    let name: String
    let systemImage: String
}

enum TabViewEnum: Identifiable, CaseIterable, View {
    case translator, clicker
    
    var id: Self {self}
    
    var tabItem: TabItem {
        switch self {
        case .translator:
                .init(name: "Translator", systemImage: "translate")
        case .clicker:
                .init(name: "Clicker", systemImage: "gearshape")
        }
    }
    
    var body: some View {
        switch self {
        case .translator:
            Translator()
        case .clicker:
            Clicker()
        }
    }
}
