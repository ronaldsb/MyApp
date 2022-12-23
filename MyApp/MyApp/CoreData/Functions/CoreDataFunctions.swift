//
//  CoreDataFunctions.swift
//
//
// 
//

// MARK: - IMPORTS

import SwiftUI
import CoreData

// MARK: - FUNC ADD NEW ITEMS TO COREDATA

func addNewItemsToCoreData(viewmodel: ViewModel, viewContext: NSManagedObjectContext) {
    
    withAnimation {
        
        let newItems = CoreDataItems(context: viewContext)
        
        newItems.id = UUID()
        newItems.projectName = viewmodel.projectName
        newItems.isselected = viewmodel.isselected
        
        newItems.inputText1 = viewmodel.inputText1
        newItems.inputNumber1 = viewmodel.inputNumber1
        
        do { try viewContext.save() } catch { let error = error as NSError
            fatalError("Unresolved error \(error), \(error.userInfo)") }
        
    }
    
}

// MARK: - FUNC TO FECTH ALL COREDATA INFORMATION AND COPY IT TO AN ARRAY

func fetchAllDataInCoreData(viewmodel: ViewModel, viewContext: NSManagedObjectContext) {
    
    var AllDataInCoreData = [CoreDataItems]()
    
    do {
        
        AllDataInCoreData =
        try viewContext.fetch(CoreDataItems.fetchRequest())
        
    }
    
    catch { print("couldnt fetch") }
    
    print("AQUI \(AllDataInCoreData) AQUI")
    print("AQUI \(AllDataInCoreData[0]) AQUI")
    
}

// MARK: - END FUNC ADD NEW ITEMS TO COREDATA
