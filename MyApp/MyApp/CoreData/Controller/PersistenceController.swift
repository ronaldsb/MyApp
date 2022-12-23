//
//  PersitenceController.swift
//
//
//
//

// MARK: - IMPORTS

import SwiftUI
import CoreData
import CloudKit

// MARK: - STRUCT PERSISTENCE CONTROLLER

struct PersitenceController {
    
    // MARK: - VARIABLES
    
    let persistentContainer: NSPersistentCloudKitContainer
    
    static let shared = PersitenceController()
    
    var viewContext: NSManagedObjectContext { return persistentContainer.viewContext }
    
    // MARK: - INIT
    
    private init() {
        
        // MARK: - END  TRANSFORMER
        
        persistentContainer = NSPersistentCloudKitContainer(name: "MyApp")
        persistentContainer.persistentStoreDescriptions.first!.setOption(true as NSObject, forKey: NSPersistentHistoryTrackingKey)
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? { fatalError("Unresolved error: \(error), \(error.userInfo)") }
        })
        
    }
    
    // MARK: - END OF STRUCT PERSISTENCE CONTROLLER
    
}
