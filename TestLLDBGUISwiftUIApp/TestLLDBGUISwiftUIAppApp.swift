//
//  TestLLDBGUISwiftUIAppApp.swift
//  TestLLDBGUISwiftUIApp
//
//  Created by Kim-David Hauser on 30.09.2025.
//

import SwiftUI

@main
struct TestLLDBGUISwiftUIAppApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
