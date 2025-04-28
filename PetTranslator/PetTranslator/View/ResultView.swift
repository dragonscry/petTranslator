//
//  ResultView.swift
//  PetTranslator
//
//  Created by Денис Меркотун on 28.04.2025.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.dismiss) private var dismiss
    
    //it mock for displaying repeat button or text from pet
    let recordingTime: Int
    let image: Pet
    var onFinish: (()->Void)? = nil
    var body: some View {
        ZStack {
            Background()
                .ignoresSafeArea()
            VStack {
                VStack {
                    HStack {
                        Button {
                            onFinish?()
                            dismiss()
                        } label: {
                            Image(systemName: "x.circle")
                                .font(.system(size: 32))
                                .foregroundStyle(.black)
                                .frame(width: 64, height: 64)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        Spacer()
                        Text("Result")
                            .font(.system(size: 32, weight: .semibold))
                        Spacer()
                        Color.clear.frame(width: 64, height: 64)

                    }
                    .padding(.horizontal, 20)
                    Spacer()
                    Group {
                        if recordingTime < 3 {
                            repeatButton
                                .padding(.bottom, 65)
                        } else {
                            VStack {
                                Text(returnRandomText())
                                    .font(.system(size: 20, weight: .semibold))
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.black)
                                    .padding(.horizontal, 20)
                                    .padding(.bottom, 70)
                    
                            }
                            .frame(height:200)
                            .frame(maxWidth: .infinity)
                            .background(Color.indigo.opacity(0.3))
                            .clipShape(SpeechBubble())
                        }
                    }
                    .padding(.horizontal, 40)
                }
                .frame(height: 350)
                Group {
                    if image == .cat {
                        Image(systemName: "cat")
                    } else {
                        Image(systemName: "dog")
                    }
                }
                .padding(.bottom, 130)
                .font(.system(size: 180))
                
            }
        }
    }
    
    var repeatButton: some View {
        Button {
            onFinish?()
            dismiss()
        } label: {
            HStack {
                Image(systemName: "arrow.trianglehead.clockwise")
                Text("Repeat")
            }
            .font(.system(size: 20, weight: .semibold))
            .foregroundStyle(.black)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(Color.indigo.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
    
    //mock for returning text from pet
    func returnRandomText() -> String {
        
        let dogPhrases = [
            "Woof! Time for a walk!",
            "Bark bark, I need treats!",
            "I'm your loyal companion!",
            "Fetch the ball, human!",
            "Can we go outside? Please!",
            "I smell something tasty!",
            "You’re my best friend!",
            "I love belly rubs!",
            "Where's my favorite toy?",
            "I'm just here for the snacks!"
        ]
        let catPhrases = [
            "Feed me, human.",
            "I'm not ignoring you, just contemplating life.",
            "Pet me, but only when I demand it.",
            "Can you hear that? A nap is calling.",
            "I’m not a lap cat, but I will be if I feel like it.",
            "Feed me now, or face the consequences!",
            "Why does this box fit so perfectly?",
            "You’re just a servant, I am royalty.",
            "Scratch me, but only on my terms.",
            "I’m here, but I’m also nowhere."
        ]
        
        switch image {
        case .cat:
            return catPhrases.randomElement() ?? "ERROR"
        case .dog:
            return dogPhrases.randomElement() ?? "ERROR"
        }

    }
}


struct SpeechBubble: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let bubbleHeight = rect.height * 0.7

        // 1. Draw the rounded rectangle
        path.addRoundedRect(in: CGRect(x: 0, y: 0, width: rect.width, height: bubbleHeight),
                            cornerSize: CGSize(width: 30, height: 20))

        // 2. Draw the tail on bottom left
        path.move(to: CGPoint(x: rect.width * 0.90, y: bubbleHeight))    // starting point (near bottom left)
        path.addLine(to: CGPoint(x: rect.width * 0.70, y: rect.height))   // point downward
        path.addLine(to: CGPoint(x: rect.width * 0.95, y: bubbleHeight))  // back toward center
        path.closeSubpath()

        return path
    }
}

#Preview {
    ResultView(recordingTime: 2, image: .cat)
}
