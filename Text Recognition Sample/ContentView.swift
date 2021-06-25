//
//  ContentView.swift
//  Text Recognition Sample
//
//  Created by Stefan Blos on 25.05.20.
//  Copyright © 2020 Stefan Blos. All rights reserved.
//

import SwiftUI
import AVKit
import AVFoundation


struct ContentView: View {
    
    @State private var recognizedText = "Tap button below to start scanning"
    @State private var showingScanningView = false
    
  func speak(string:String){
    
    let synthesizer = AVSpeechSynthesizer()
    let utterance = AVSpeechUtterance(string: string)
    utterance.rate = 0.4
    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    synthesizer.speak(utterance)
  }
    var body: some View {
        NavigationView {
            VStack {
              Button(action: {
                speak(string: recognizedText)
              }, label: {
                Image(systemName: "mic.circle")
                  .resizable()
                  .frame(width: 32.0, height: 32.0)

              })
                ScrollView {
                    ZStack {
                        RoundedRectangle(cornerRadius: 0, style: .continuous)
                            .fill(Color.gray.opacity(0.2))
                        
                        Text(recognizedText)
                            .padding()
                         
                    }
                    .padding()
                }
                
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        self.showingScanningView = true
                    }) {
                        Text("Start Scanning")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Capsule().fill(Color.blue))
                }
                .padding()
              Spacer()
            }
            .navigationBarTitle("Scan & Speak")
            .sheet(isPresented: $showingScanningView) {
                ScanDocumentView(recognizedText: self.$recognizedText)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
