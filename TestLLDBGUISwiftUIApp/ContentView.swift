//
//  ContentView.swift
//  TestLLDBGUISwiftUIApp
//
//  Created by Kim-David Hauser on 30.09.2025.
//

import SwiftUI

#if canImport(LLDBUISwiftUIFW)
import LLDBUISwiftUIFW
#endif

struct ContentView: View {
    @State private var showAlert = false
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Image("AppIconImage")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 5)
            Text("Hello, world!")
            VStack {
                Button("Show Alert") {
                    showAlert = true
                }
                Button("Show FW Hello World Alert") {
                    LLDBUISwiftUIFWClass.showHelloWorldAlert()
                }
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

