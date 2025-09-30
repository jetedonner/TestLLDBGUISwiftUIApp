//
//  LLDBUISwiftUIFW.swift
//  LLDBUISwiftUIFW
//
//  Created by Kim-David Hauser on 30.09.2025.
//

import Foundation

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

public final class LLDBUISwiftUIFWClass {
    
    // Retain a temporary alert window if we need to present without a presenter (UIKit)
    #if canImport(UIKit)
    private static var alertWindow: UIWindow?
    #endif
    
    @MainActor
    public static func showHelloWorldAlert() {
        #if canImport(AppKit) && !targetEnvironment(macCatalyst)
        // macOS (AppKit)
        let alert = NSAlert()
        alert.alertStyle = NSAlert.Style.warning
        alert.icon = NSImage(named: NSImage.computerName) // Image(systemName: "0.circle") // NSImage(systemSymbolName: .exclamationmarkCircleFill, accessibilityDescription: nil)
        alert.messageText = "Hello World"
        alert.addButton(withTitle: "OK")
        
        if let window = NSApp.keyWindow ?? NSApp.mainWindow {
            alert.beginSheetModal(for: window, completionHandler: nil)
        } else {
            alert.runModal()
        }
        #elseif canImport(UIKit)
        // iOS/iPadOS/tvOS/visionOS (UIKit)
        let alert = UIAlertController(title: "Hello World", message: nil, preferredStyle: .alert)
        
        if let presenter = topViewController() {
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            presenter.present(alert, animated: true, completion: nil)
        } else {
            // Fallback: present from a temporary window if no presenter is found
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                Self.alertWindow?.isHidden = true
                Self.alertWindow = nil
            }))
            
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.windowLevel = .alert + 1
            let root = UIViewController()
            window.rootViewController = root
            window.makeKeyAndVisible()
            Self.alertWindow = window
            root.present(alert, animated: true, completion: nil)
        }
        #else
        // Unsupported platform — fall back to console
        print("Hello World")
        #endif
    }
    
    // Optional: keep a compatibility alias if you’ve already referenced showMSG() elsewhere
    @MainActor
    public static func showMSG() {
        showHelloWorldAlert()
    }
    
    #if canImport(UIKit)
    @MainActor
    private static func topViewController(base: UIViewController? = nil) -> UIViewController? {
        if let base = base { return traverse(base) }
        
        if #available(iOS 13.0, tvOS 13.0, *) {
            let scenes = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .filter { $0.activationState == .foregroundActive }
            
            for scene in scenes {
                if let vc = scene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                    return traverse(vc)
                }
                if let vc = scene.windows.first?.rootViewController {
                    return traverse(vc)
                }
            }
        } else {
            return traverse(UIApplication.shared.keyWindow?.rootViewController)
        }
        
        return nil
    }
    
    @MainActor
    private static func traverse(_ vc: UIViewController?) -> UIViewController? {
        guard var top = vc else { return nil }
        while let presented = top.presentedViewController {
            top = presented
        }
        if let nav = top as? UINavigationController {
            top = nav.topViewController ?? nav
        }
        if let tab = top as? UITabBarController {
            top = tab.selectedViewController ?? tab
        }
        return top
    }
    #endif
}

