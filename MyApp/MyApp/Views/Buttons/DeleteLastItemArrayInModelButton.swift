//
//  DeleteLastItemArrayInModelButton.swift
//
//
// 
//

// MARK: - IMPORTS

import SwiftUI

// MARK: - STRUCT FOR DELETING THE LAST ITEM IN THE ARRAY OF THE MODEL - ITS A BUTTON

struct DeleteLastItemArrayInModelButton: View {
    
    // MARK: - VARS
    
    @EnvironmentObject var viewmodel: ViewModel
    
    // MARK: - VARS "ONLY FOR COREDATA SECTION"
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CoreDataItems.projectName, ascending: false)])
    var coreDataItemsFetchedResults: FetchedResults<CoreDataItems>
    
    // MARK: - BODY
    
    var body: some View {
        
        // MARK: - ACTION BUTTON FOR DELETING THE LAST ITEM IN THE ARRAY OF THE MODEL
        
        Button {
            
            if viewmodel.itemsArrayInModel.indices.min() != nil {
                
                viewmodel.deletedItemsArrayInModel.append(viewmodel.itemsArrayInModel.last!)
                viewmodel.itemsArrayInModel.removeLast()
                
            }
            
            if viewmodel.itemsArrayInModel.indices.min() != nil {
                
                if viewmodel.maxIndex <= viewmodel.itemsArrayInModel.indices.max()! { viewmodel.maxIndex = viewmodel.itemsArrayInModel.indices.max()! }
                
            }
            
            // MARK: - ONLY FOR COREDATA SECTION - // DELETES ALL COREDATA ITEMS THAT MATCHES AN SPECIFIC PREDICATE
            
            if coreDataItemsFetchedResults.first != nil {
                
                viewmodel.deletedItemsArrayInModel.append(contentsOf:
                                                            [Model(
                                                                id: UUID(),
                                                                projectName: coreDataItemsFetchedResults.last?.projectName ?? "",
                                                                isselected: coreDataItemsFetchedResults.last?.isselected ?? false,
                                                                inputText1: coreDataItemsFetchedResults.last?.inputText1 ?? "",
                                                                inputNumber1: coreDataItemsFetchedResults.last?.inputNumber1 ?? 0
                                                            )])
                
                viewContext.delete(coreDataItemsFetchedResults.last!)
                
                do { try viewContext.save() }catch { print("Error! Could not complete to save the context into CoreData") }
                
            }
            
            // MARK: - ONLY FOR COREDATA
            
            if viewmodel.deletedItemsArrayInModel.count != 0 {
                
                for i in 0...viewmodel.deletedItemsArrayInModel.count - 1 { viewmodel.deletedItemsArrayInModel[i].isselected = false }
                
            }
            
        } label: { Text("Delete Last Item") }.tint(.blue).buttonStyle(.borderedProminent).fixedSize().padding()
        
        // MARK: - END OF ACTION BUTTON FOR DELETING THE LAST ITEM IN THE ARRAY OF THE MODEL
        
    }
    
    // MARK: - STRUCT FOR DELETING THE LAST ITEM IN THE ARRAY OF THE MODEL - ITS A BUTTON
    
}
