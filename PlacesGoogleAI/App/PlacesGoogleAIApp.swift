//
//  PlacesGoogleAIApp.swift
//  PlacesGoogleAI
//
//  Created by MACBOOK PRO on 24/04/24.
//

import SwiftUI
import FirebaseCore

@main
struct PlacesGoogleAIApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
