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
    @State private var showNameInput = false

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
                Button("Ask for name") {
                    showNameInput = true
                }
                NavigationLink("Go to Name Input", destination: NameInputView())
            }
            .alert("Important Message", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("This is an alert in SwiftUI.")
            }
        }
        .sheet(isPresented: $showNameInput) {
            NameInputView()
        }
        .padding()
    }
}

struct NameInputView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var showAlert = false

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter your name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .frame(width: 300)

            Button("Confirm") {
                showAlert = true
            }
            Button("Done") {
                dismiss()
            }
            .alert("Hello, \(name)!", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
