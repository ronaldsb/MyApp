//
//  AddSelectedItemsArrayToBackUpInModelButton.swift
//
//
// 
//

// MARK: - IMPORTS

import SwiftUI

// MARK: - IMPORTS

struct AddSelectedItemsArrayToBackUpInModelButton: View {
    
    // MARK: - VARS
    
    @EnvironmentObject var viewmodel: ViewModel
    
    // MARK: - VARS "ONLY FOR COREDATA SECTION"
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: - BODY
    
    var body: some View {
        
        // MARK: - ACTION FOR ADDING ALL THE SELECTED ITEMS TO THE BACKUP ARRAY IN THE MODEL
        
        Button {
            
            viewmodel.backupItemsInModel.append(contentsOf: viewmodel.itemsArrayInModel.filter { textsInSermon in textsInSermon.isselected == true } )
            viewmodel.backupItemsInModel.append(contentsOf: viewmodel.deletedItemsArrayInModel.filter { textsInSermon in textsInSermon.isselected == true } )
            
            if viewmodel.backupItemsInModel.count != 0 {  // TO CHANGE DE ID & UNMARK THE ISSELECTED OPTION AFTER COPYING TO BACKUP ARRAY
                
                for i in 0...viewmodel.backupItemsInModel.count - 1 {
                    
                    viewmodel.backupItemsInModel[i].isselected = false
                    viewmodel.backupItemsInModel[i].id = UUID()
                    
                }
                
            }
            
            // MARK: - ONLY FOR COREDATA SECTION - // DELETES ALL COREDATA ITEMS THAT MATCHES AN SPECIFIC PREDICATE
            
            do {
                
                let fetchRequest: NSFetchRequest<CoreDataItems>
                
                fetchRequest = CoreDataItems.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "isselected == 1")
                fetchRequest.includesPropertyValues = false
                
                let objects = try viewContext.fetch(fetchRequest)
                
                for object in objects {
                    
                    viewmodel.backupItemsInModel.append(contentsOf:
                                                            [Model(
                                                                id: UUID(),
                                                                projectName: object.projectName ?? "",
                                                                isselected: object.isselected,
                                                                inputText1: object.inputText1 ?? "",
                                                                inputNumber1: object.inputNumber1
                                                            )])
                    
                    viewContext.delete(object)
                    
                }
                
            }catch { print("Error! Could not Fetch any Data from CoreData") }
            
            do { try viewContext.save() }catch { print("Error! Could not complete to save the context into CoreData") }
            
            if viewmodel.backupItemsInModel.count != 0 {
                
                for i in 0...viewmodel.backupItemsInModel.count - 1 { viewmodel.backupItemsInModel[i].isselected = false }
                
            }
            
            if viewmodel.deletedItemsArrayInModel.count != 0 {
                
                for i in 0...viewmodel.deletedItemsArrayInModel.count - 1 { viewmodel.deletedItemsArrayInModel[i].isselected = false }
                
            }
            
        } label: { Text("Add All Selected Items to Backup") }.tint(.blue).buttonStyle(.borderedProminent).fixedSize().padding()
        
        // MARK: - END OF ACTION FOR ADDING ALL THE SELECTED ITEMS TO THE BACKUP ARRAY IN THE MODEL
        
    }
    
    // MARK: - END OF STRUCT FOR ADDING THE SELECTED ITEMS TO THE BACKUP ARRAY IN THE MODEL - ITS A BUTTON
}
