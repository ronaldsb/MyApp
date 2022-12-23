//
//  DeleteAllItemsArrayInModelButton.swift
//
//
// 
//

// MARK: - IMPORTS

import SwiftUI

// MARK: - STRUCT FOR DELETING ALL THE ITEMS IN THE ARRAY OF THE MODEL - ITS A BUTTON

struct DeleteAllItemsArrayInModelButton: View {
    
    // MARK: - VARS
    
    @EnvironmentObject var viewmodel: ViewModel
    
    // MARK: - VARS "ONLY FOR COREDATA SECTION"
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: - BODY
    
    var body: some View {
        
        // MARK: - ACTION BUTTON FOR DELETING ALL THE ITEMS IN THE ARRAY OF THE MODEL
        
        Button {
            
            viewmodel.deletedItemsArrayInModel.append(contentsOf:viewmodel.itemsArrayInModel.filter { textsInSermon in textsInSermon.isselected == true || textsInSermon.isselected == false})
            viewmodel.deletedItemsArrayInModel.append(contentsOf:viewmodel.backupItemsInModel.filter { textsInSermon in textsInSermon.isselected == true || textsInSermon.isselected == false})
            
            if viewmodel.deletedItemsArrayInModel.count != 0 {
                
                for i in 0...viewmodel.deletedItemsArrayInModel.count - 1 {
                    
                    viewmodel.deletedItemsArrayInModel[i].isselected = false
                    viewmodel.deletedItemsArrayInModel[i].id = UUID()
                    
                }
                
            }
            
            viewmodel.itemsArrayInModel.removeAll()
            viewmodel.selectedItemsArray.removeAll()
            
            // MARK: - ONLY FOR COREDATA SECTION - // DELETES ALL COREDATA ITEMS THAT MATCHES AN SPECIFIC PREDICATE
            
            do {
                
                let fetchRequest: NSFetchRequest<CoreDataItems>
                
                fetchRequest = CoreDataItems.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "isselected <= 1")  // This erases all itmes because result can be only "0" or "1"
                fetchRequest.includesPropertyValues = false
                
                let objects = try viewContext.fetch(fetchRequest)
                
                for object in objects { viewContext.delete(object) }
                
            }catch { print("Error! Could not Fetch any Data from CoreData") }
                
            do { try viewContext.save() }catch { print("Error! Could not complete to save the context into CoreData") }
            
            // MARK: - ONLY FOR COREDATA
            
        } label: { Text("Delete All Items in Project") }.tint(.blue).buttonStyle(.borderedProminent).fixedSize().padding()
        
        // MARK: - END OF ACTION BUTTON FOR DELETING ALL THE ITEMS IN THE ARRAY OF THE MODEL
        
    }
    
    // MARK: - END OF STRUCT FOR DELETING ALL THE ITEMS IN THE ARRAY OF THE MODEL - ITS A BUTTON
}
