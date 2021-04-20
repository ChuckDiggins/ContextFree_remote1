//
//  ContextFreeApp.swift
//  ContextFree
//
//  Created by Charles Diggins on 4/3/21.
//

import SwiftUI

@main
struct ContextFreeApp: App {
    var body: some Scene {
        WindowGroup {
            
 //           let cfModel = CFModel()
            
            let cfModelView = CFModelView()
        
            //this initializes the view model in ViperView
            
            ContentView()
                .environmentObject(cfModelView)
        }
    }
}
