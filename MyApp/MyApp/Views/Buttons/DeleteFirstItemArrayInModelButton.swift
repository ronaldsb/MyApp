//
//  DeleteFirstItemArrayInModelButton.swift
//
//
// 
//

import SwiftUI

// MARK: - STRUCT FOR DELETING THE FIRST ITEM IN THE ARRAY OF THE MODEL - ITS A BUTTON

struct DeleteFirstItemArrayInModelButton: View {
    
    // MARK: - VARS
    
    @EnvironmentObject var viewmodel: ViewModel
    
    // MARK: - VARS "ONLY FOR COREDATA SECTION"
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CoreDataItems.projectName, ascending: false)])
    var coreDataItemsFetchedResults: FetchedResults<CoreDataItems>
    
    // MARK: - BODY
    
    var body: some View {
        
        // MARK: - ACTION BUTTON FOR DELETING THE FIRST ITEM IN THE ARRAY OF THE MODEL
        
        Button {
            
            if viewmodel.itemsArrayInModel.indices.min() != nil {
                
                viewmodel.deletedItemsArrayInModel.append(viewmodel.itemsArrayInModel.first!)
                viewmodel.itemsArrayInModel.removeFirst()
                
            }
            
            if viewmodel.itemsArrayInModel.indices.min() != nil {
                
                if viewmodel.maxIndex <= viewmodel.itemsArrayInModel.indices.max()! { viewmodel.maxIndex = viewmodel.itemsArrayInModel.indices.max()! }
                
            }
            
            // MARK: - ONLY FOR COREDATA SECTION - // DELETES COREDATA FIRST ELEMENT AND COPY IT TO DELETED ITEMS
            
            if coreDataItemsFetchedResults.first != nil {
                
                viewmodel.deletedItemsArrayInModel.append(contentsOf:
                                                            [Model(
                                                                id: UUID(),
                                                                projectName: coreDataItemsFetchedResults.first?.projectName ?? "",
                                                                isselected: coreDataItemsFetchedResults.first?.isselected ?? false,
                                                                inputText1: coreDataItemsFetchedResults.first?.inputText1 ?? "",
                                                                inputNumber1: coreDataItemsFetchedResults.first?.inputNumber1 ?? 0
                                                            )])
                
                viewContext.delete(coreDataItemsFetchedResults.first!)
                
                do { try viewContext.save() }catch { print("Error! Could not complete to save the context into CoreData") }
                
            }
            
            // MARK: - END ONLY FOR COREDATA SECTION - // DELETES COREDATA FIRST ELEMENT
            
            if viewmodel.deletedItemsArrayInModel.count != 0 {
                
                for i in 0...viewmodel.deletedItemsArrayInModel.count - 1 { viewmodel.deletedItemsArrayInModel[i].isselected = false }
                
            }
            
        } label: { Text("Delete First Item") }.tint(.blue).buttonStyle(.borderedProminent).fixedSize().padding()
        
        // MARK: - END OF THE ACTION BUTTON FOR DELETING THE FIRST ITEM IN THE ARRAY OF THE MODEL
        
    }
    
    // MARK: - END STRUCT FOR DELETING THE FIRST ITEM IN THE ARRAY OF THE MODEL - ITS A BUTTON
    
}


