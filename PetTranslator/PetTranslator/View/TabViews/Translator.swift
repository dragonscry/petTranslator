//
//  Translator.swift
//  PetTranslator
//
//  Created by Денис Меркотун on 24.04.2025.
//

import SwiftUI

struct Translator: View {
    @StateObject private var viewModel = TranslationDirectionViewModel()
    var body: some View {
        ZStack {
            Background()
                .ignoresSafeArea()
            VStack(spacing: 40) {
                Text("Translator")
                    .font(.system(size: 45, weight: .semibold))
                translatorDirection
                HStack {
                    VStack {
                        Image(systemName: "microphone")
                            .font(.system(size: 80))
                        Text("Start Speak")
                            .font(.system(size: 25, weight: .semibold))
                    }
                    .frame(width: 200, height: 200)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 30))

                    
                    VStack {
                        Image(systemName: "cat")
                        Image(systemName: "dog")
                    }
                    .frame(width: 100, height: 200)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                }
                Spacer()
                Spacer()
            }

        }
    }
    
    private var translatorDirection: some View {
        HStack() {
            Text(viewModel.isSwapped ? "PET" : "HUMAN")
                .frame(maxWidth: .infinity, alignment: .leading)
            imageSwapper
            Text(viewModel.isSwapped ? "HUMAN" : "PET")
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal, 50)
        .fontWeight(.bold)
    }
    
    private var imageSwapper: some View {
        Image(systemName: "arrow.left.arrow.right")
            .onTapGesture {
                withAnimation {
                    viewModel.toggleDirection()
                }
            }
    }
}

#Preview {
    Translator()
}

class TranslationDirectionViewModel: ObservableObject {
    @Published var isSwapped: Bool = false
    
    func toggleDirection() {
        isSwapped.toggle()
    }
}
