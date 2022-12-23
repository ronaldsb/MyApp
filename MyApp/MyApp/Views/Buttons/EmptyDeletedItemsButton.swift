//
//  EmptyDeletedItemsButton.swift
//
//
// 
//

// MARK: - IMPORTS

import SwiftUI

// MARK: - STRUCT FOR DELETING ALL THE ITEMS IN THE ARRAY OF THE MODEL - ITS A BUTTON

struct EmptyDeletedItemsButton: View {
    
    // MARK: - VARS
    
    @EnvironmentObject var viewmodel: ViewModel
    
    // MARK: - VARS "ONLY FOR COREDATA SECTION"
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: - BODY
    
    var body: some View {
        
        // MARK: - ACTION BUTTON FOR DELETING ALL THE ITEMS IN THE ARRAY OF THE MODEL
        
        Button {
            
            viewmodel.deletedItemsArrayInModel.removeAll()
            
        } label: { Text("Empty Deleted Items") }.tint(.blue).buttonStyle(.borderedProminent).fixedSize().padding()
        
        // MARK: - END OF ACTION BUTTON FOR DELETING ALL THE ITEMS IN THE ARRAY OF THE MODEL
        
    }
    
    // MARK: - END OF STRUCT FOR DELETING ALL THE ITEMS IN THE ARRAY OF THE MODEL - ITS A BUTTON
}
