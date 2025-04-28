//
//  Clicker.swift
//  PetTranslator
//
//  Created by Денис Меркотун on 24.04.2025.
//

import SwiftUI

struct Clicker: View {
    
    private let linkDictionary: [(String, AnyView)] = [
        ("Rate Us", AnyView(RateUsView())),
        ("Share App", AnyView(ShareAppView())),
        ("Contact Us", AnyView(ContactUsView())),
        ("Restore Purchases", AnyView(RestorePurchasesView())),
        ("Privacy Policy", AnyView(PrivacyPolicyView())),
        ("Terms of Use", AnyView(TermsOfUseView()))
    ]
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Background()
                VStack(spacing: 30) {
                    Text("Settings")
                        .font(.largeTitle.bold())
                        .padding(.top, 80)
                    VStack(spacing: 20) {
                        ForEach(linkDictionary, id: \.self.0) { key in
                            NavigationLink {
                                key.1
                            } label: {
                                HStack {
                                    Text(key.0)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .foregroundStyle(.black)
                                .font(.system(size: 25))
                                .padding()
                                .background(Color.indigo.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                            .padding(.horizontal, 10)

                        }
                    }
                    
                    Spacer()
                }

            }
            .ignoresSafeArea()        }

    }
}



#Preview {
    Clicker()
}
