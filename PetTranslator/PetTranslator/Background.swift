//
//  Background.swift
//  PetTranslator
//
//  Created by Денис Меркотун on 24.04.2025.
//

import SwiftUI

struct Background: View {
    var body: some View {
        LinearGradient(colors: [.white, Color(red: 0.482, green: 0.996, blue: 0.878).opacity(0.6)],
                       startPoint: .top,
                       endPoint: .bottom)
    }
}
