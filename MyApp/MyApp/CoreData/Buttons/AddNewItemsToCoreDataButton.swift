//
//  AddNewItemsToCoreDataButton.swift
//
//
// 
//

// MARK: - IMPORTS

import SwiftUI

// MARK: - STRUCT TO ADD NEW ITEMS TO COREDATA - ITS A BUTTON

struct AddNewItemsToCoreDataButton: View {
    
    // MARK: - VARS
    
    @EnvironmentObject var viewmodel: ViewModel
    @Environment(\.managedObjectContext) private var viewContext

    // MARK: - BODY
    
    var body: some View {
        
        // MARK: - BUTTON ACTION TO ADD NEW ITEMS TO COREDATA
        
        Button {
            
            addNewItemsToCoreData(viewmodel: viewmodel, viewContext: viewContext)
            
        } label: { Text("Add a New Item to CoreData") }
            .tint(.blue).buttonStyle(.borderedProminent).fixedSize().padding()
        
        // MARK: - END BUTTON ACTION TO ADD NEW ITEMS TO COREDATA
        
    }
    
    // MARK: - END OF STRUCT TO ADD NEW ITEMS TO COREDATA - ITS A BUTTON
    
}
