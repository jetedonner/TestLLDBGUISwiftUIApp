//
//  ContentView.swift
//  TestLLDBGUISwiftUIApp
//
//  Created by Kim-David Hauser on 30.09.2025.
//

import SwiftUI
/*#if canImport(LLDBUISwiftUILib)
import LLDBUISwiftUILib
#endif
*/
import LLDBUISwiftUIFW

struct ContentView: View {
    @State private var showAlert = false
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            /*Button("Action", action: {
                var msgBox = Alert(title: Text("Action MSG"))
                msgBox->
            })*/
            VStack {
                Button("Show Alert") {
                    showAlert = true
                }
                Button("Show FW Hello World Alert") {
                    LLDBUISwiftUIFWClass.showHelloWorldAlert()
                }
                /*#if canImport(LLDBUISwiftUILib)
                Button("Show Framework Alert") {
                    LLDBUISwiftUILibClass.testFunct()
                }
                #endif*/
                
            }
            .alert("Important Message", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("This is an alert in SwiftUI.")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

