//
//  DeleteSelectedItemsArrayInModelButton.swift
//
//
// 
//

// MARK: - IMPORTS

import SwiftUI

// MARK: - STRUCT FOR DELETING ALL THE SELECTED ITEMS IN THE ARRAY OF THE MODEL - ITS A BUTTON

struct DeleteSelectedItemsArrayInModelButton: View {
    
    // MARK: - VARS
    
    @EnvironmentObject var viewmodel: ViewModel
    
    // MARK: - VARS "ONLY FOR COREDATA SECTION"
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: - BODY
    
    var body: some View {
        
        // MARK: - ACTION BUTTON FOR DELETING ALL THE SELECTED ITEMS ARRAY IN THE MODEL
        
        Button {
            
            viewmodel.deletedItemsArrayInModel.append(contentsOf: viewmodel.itemsArrayInModel.filter { dataInTheArray in dataInTheArray.isselected == true })
            viewmodel.deletedItemsArrayInModel.append(contentsOf: viewmodel.backupItemsInModel.filter { dataInTheArray in dataInTheArray.isselected == true })
            
            if viewmodel.deletedItemsArrayInModel.count != 0 {
                
                for i in 0...viewmodel.deletedItemsArrayInModel.count - 1 { viewmodel.deletedItemsArrayInModel[i].isselected = false }
                
            }
            
            viewmodel.itemsArrayInModel.removeAll { dataInTheArray in dataInTheArray.isselected == true }
            viewmodel.backupItemsInModel.removeAll { dataInTheArray in dataInTheArray.isselected == true }
            viewmodel.deletedItemsArrayInModel.removeAll { dataInTheArray in dataInTheArray.isselected == true }
            
            // MARK: - ONLY FOR COREDATA SECTION - // DELETES ALL COREDATA ITEMS THAT MATCHES AN SPECIFIC PREDICATE
            
            do {
                
                let fetchRequest: NSFetchRequest<CoreDataItems>
                
                fetchRequest = CoreDataItems.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "isselected == 1")
                fetchRequest.includesPropertyValues = false
                
                let objects = try viewContext.fetch(fetchRequest)
                
                for object in objects {
                    
                    viewmodel.deletedItemsArrayInModel.append(contentsOf:
                                                                [Model(
                                                                    id: UUID(),
                                                                    projectName: object.projectName ?? "",
                                                                    isselected: object.isselected,
                                                                    inputText1: object.inputText1 ?? "",
                                                                    inputNumber1: object.inputNumber1
                                                                )])
                    
                    viewContext.delete(object) }
                
            }catch { print("Error! Could not Fetch any Data from CoreData") }
            
            do { try viewContext.save() }catch { print("Error! Could not complete to save the context into CoreData") }
            
            if viewmodel.deletedItemsArrayInModel.count != 0 {
                
                for i in 0...viewmodel.deletedItemsArrayInModel.count - 1 { viewmodel.deletedItemsArrayInModel[i].isselected = false }
                
            }
            
            // MARK: - ONLY FOR COREDATA
            
        } label: { Text("Delete Selected Items") }.tint(.blue).buttonStyle(.borderedProminent).fixedSize().padding()
        
        // MARK: - END OF ACTION BUTTON FOR DELETING ALL THE SELECTED ITEMS IN THE ARRAY OF THE MODEL
        
    }
    
    // MARK: - END OF STRUCT FOR DELETING ALL THE SELECTED ITEMS IN THE ARRAY OF THE MODEL - ITS A BUTTON
    
}
