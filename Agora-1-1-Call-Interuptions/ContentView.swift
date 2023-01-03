//
//  ContentView.swift
//  Agora-1-1-Call-Interuptions
//
//  Created by shaun on 1/3/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Call Interuption Handling Sample")
                    .font(.title2)
                    .padding()
                
                NavigationLink("No Handling") {
                    UnhandledCallInteruptionsView()
                }.padding()
                
                NavigationLink("Audio Session Approach") {
                    AudioSessionApproachView()
                }.padding()
                
                NavigationLink("Call Kit Approach") {
                    CallKitApproachView()
                }.padding()
            }.padding()
        }        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
