//
//  ContextFreeApp.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/3/21.
//

import SwiftUI
//import JumpLinguaHelpers

@main
struct ContextFreeApp: App {
    var body: some Scene {
        WindowGroup {
            
            let cfModelView = CFModelView(language: .Agnostic)
        
            //this initializes the view model in ViperView
            
            ContentView()
                .environmentObject(cfModelView)
        }
    }
}
