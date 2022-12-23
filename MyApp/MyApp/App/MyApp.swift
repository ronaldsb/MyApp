//
//  MyApp.swift
//
//
// 
//

// MARK: - IMPORTS

import SwiftUI

// MARK: - MAIN

@main

// MARK: - STRUCT FOR THE MAIN APP

struct MyApp: App {
    
    // MARK: - BODY - SOME SCENE
    
    var body: some Scene {
        
        // MARK: - WINDOW GROUP
        
        WindowGroup {
            
            // MARK: - FIRST VIEW - SCREEN OF ALL - AFTER RUNNING THE STARTUP ICON SCREEN OF THE APP
            
            FirstView()
            
            // MARK: - ENVIRONMENT VARS NEEDED IN ALL THE APP
            
                .environmentObject(ViewModel())
                .environment(\.managedObjectContext, PersitenceController.shared.viewContext)
            
            // MARK: - END OF INYECTING ALL THE ENVIRONMENT VARS NEEDED IN ALL THE APP
            
        }
        
        // MARK: - END OF WINDOW GROUP
        
    }
    
    // MARK: - END OF THE BODY - SOME SCENE
    
}

// MARK: - END OF STRUCT FOR THE MAIN APP
