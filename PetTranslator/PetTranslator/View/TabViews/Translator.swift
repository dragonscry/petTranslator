//
//  Translator.swift
//  PetTranslator
//
//  Created by Денис Меркотун on 24.04.2025.
//

import SwiftUI
import AVFoundation

struct Translator: View {
    
    //viewModel for understanging what pet is selected
    @StateObject private var translationDirection = TranslationDirectionViewModel()
    
    //viewModel for recording (Now is Mock)
    @StateObject private var recorder = Recorder()
    
    @State private var isRecording = false
    @State private var showMicrophoneDeniedAlert = false
    @State private var processOfTranslation = false
    @State private var showResultPage = false
    
    var body: some View {
        ZStack {
            Background()
                .ignoresSafeArea()
            VStack {
                VStack(spacing: 40) {
                    Group {
                        if processOfTranslation {
                            Spacer()
                            Text("Process of translation...")
                                .font(.system(size: 25, weight: .semibold))
                        } else {
                            Text("Translator")
                                .font(.system(size: 45, weight: .semibold))
                            translatorDirection
                            translatorFunctional
                        }
                    }
                }
                .frame(height: 350)
                .fullScreenCover(isPresented: $showResultPage) {
                    ResultView(recordingTime: recorder.recordingTime, image: translationDirection.selectedPet) {
                        processOfTranslation = false
                    }
                }
                //What image we select (Now is mock)
                Group {
                    if translationDirection.selectedPet == .cat {
                        Image(systemName: "cat")
                    } else {
                        Image(systemName: "dog")
                    }
                }
                .font(.system(size: 180))
                Spacer()
            }
            
        }
    }
    
    //switcher, now is just view, no logic
    private var translatorDirection: some View {
        HStack() {
            Text(translationDirection.isSwapped ? "PET" : "HUMAN")
                .frame(maxWidth: .infinity, alignment: .leading)
            imageSwapper
            Text(translationDirection.isSwapped ? "HUMAN" : "PET")
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal, 50)
        .fontWeight(.bold)
    }
    
    //variable for clear view
    private var imageSwapper: some View {
        Image(systemName: "arrow.left.arrow.right")
            .onTapGesture {
                withAnimation {
                    translationDirection.toggleDirection()
                }
            }
    }
    
    private var translatorFunctional: some View {
        HStack(spacing: 30) {
            Button {
                if isRecording {
                    recorder.stopRecording()

                    print(recorder.recordingTime)
                    withAnimation {
                        processOfTranslation = true
                        isRecording.toggle()
                    }
                    triggerResultPage()
                } else {
                    recorder.requestPermission { result in
                        if result {
                            recorder.startRecording()
                            withAnimation {
                                isRecording.toggle()
                            }
                        } else {
                            showMicrophoneDeniedAlert = true
                        }
                    }
                }
            } label: {
                Group {
                    if isRecording {
                        VStack(spacing: 50) {
                            //mock for audio visualizer
                            HStack(spacing: 5) {
                                ForEach(0 ..< 20, id: \.self) { item in
                                    RoundedRectangle(cornerRadius: 2)
                                        .frame(width: 3, height: .random(in: 1...45))
                                        .foregroundStyle(.blue)
                                }
                            }
                            Text("Recording...")
                                .font(.system(size: 25, weight: .semibold))
                        }
                        .foregroundStyle(.black)
                        .frame(width: 200, height: 200)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .shadow(radius: 3)
                        
                    } else {
                        VStack {
                            Image(systemName: "microphone")
                                .font(.system(size: 80))
                            Text("Start Speak")
                                .font(.system(size: 25, weight: .semibold))
                        }
                        .foregroundStyle(.black)
                        .frame(width: 200, height: 200)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .shadow(radius: 3)
                    }
                }
            }
            .alert(isPresented: $showMicrophoneDeniedAlert) {
                Alert(
                    title: Text("Enable Microphone Access"),
                    message: Text("Please allow access to your microphone to use the app's features"),
                    primaryButton: .default(Text("Settings")) {
                        openAppSettings()
                    },
                    secondaryButton: .cancel(Text("Cancel"))
                )
            }
            VStack(spacing: 30) {
                Image(systemName: "cat")
                    .frame(width: 60, height: 60)
                    .background(Color.blue.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .opacity(translationDirection.selectedPet == .cat ? 1 : 0.5)
                    .onTapGesture {
                        withAnimation {
                            translationDirection.selectedPet = .cat
                        }
                    }
                Image(systemName: "dog")
                    .frame(width: 60, height: 60)
                    .background(Color.green.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .opacity(translationDirection.selectedPet == .dog ? 1 : 0.5)
                    .onTapGesture {
                        withAnimation {
                            translationDirection.selectedPet = .dog
                        }
                    }
            }
            .frame(width: 120, height: 200)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .shadow(radius: 3)
        }
    }
    
    func openAppSettings() {
        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(appSettings)
        }
    }
    
    //mock for delay processing result
    private func triggerResultPage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showResultPage = true
        }
    }
}

#Preview {
    Translator()
}

//what pet we have
enum Pet {
    case cat, dog
}

class TranslationDirectionViewModel: ObservableObject {
    @Published var isSwapped: Bool = false
    
    @Published var selectedPet: Pet = .cat
    
    //translation direction
    func toggleDirection() {
        isSwapped.toggle()
    }
}

//mock for audio recorder, now need to trigger request permission pop-up
class Recorder: ObservableObject {
    
    private var audioRecorder: AVAudioRecorder?
    private var recordingSession: AVAudioSession = AVAudioSession.sharedInstance()
    
    var recordingTime = 0
    private var timer: Timer?
    
    
    func requestPermission(completion: @escaping (Bool) -> Void) {
        // iOS 17+ uses AVAudioApplication for permission requests
        if #available(iOS 17.0, *) {
            AVAudioApplication.requestRecordPermission { allowed in
                DispatchQueue.main.async {
                    completion(allowed)
                }
            }
        } else {
            // Fall back to old method for iOS 16 and earlier
            recordingSession.requestRecordPermission { allowed in
                DispatchQueue.main.async {
                    completion(allowed)
                }
            }
        }
    }
    
    //mock for start audio recording, now starts timer
    func startRecording() {
        recordingTime = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.recordingTime += 1
        }
    }
    
    //mock for stop audio recording, now stops timer
    func stopRecording() {
        timer?.invalidate()
        timer = nil
    }
    
    
}
