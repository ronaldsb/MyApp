//
//  DeletedItemsListView.swift
//
//
// 
//

// MARK: - IMPORTS

import SwiftUI

// MARK: - STRUCT OF THE DELETED PROJECTS LIST VIEW OF THE APP

struct DeletedItemsListView: View {
    
    // MARK: - VARS FOR ACCESING THE VIEWMODEL
    
    @EnvironmentObject var viewmodel: ViewModel
    
    // MARK: - VARS FOR ACCESING COREDATA
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: - BODY
    
    var body: some View {
        
        // MARK: - STRUCT OF THE DELETED PROJECTS LIST VIEW OF THE APP
        
        HStack {
            
            Spacer()
            
            Text("Deleted Items of the Project")
            
            Spacer()
        }
        
        // MARK: - LIST VIEW OF ARRAYS OF DELETED PROJECTS OF THE APP - NOT IN COREDATA
        
        List {
            
            ForEach(viewmodel.deletedItemsArrayInModel) { datainResults in
                
                HStack {
                    
                    VStack {
                        
                        Text("\(datainResults.id)")
                            .font(.headline).multilineTextAlignment(.leading)
                            .foregroundColor(.gray)
                            .frame(height: 50)
                            .padding(.trailing)
                        
                    }
                    
                    VStack {
                        
                        HStack {
                            
                            Text("     ")
                                .multilineTextAlignment(.leading)
                                .background( RoundedRectangle(cornerRadius: 10).fill(datainResults.isselected ? Color.blue : Color.gray.opacity(0.1)) )
                            
                            // MARK: - ONTAP GESTURE OVER THE LIST PROJECTS
                            
                                .onTapGesture {
                                    
                                    //print(datainResults.id)  //Print The ID of The immediately Selected Item
                                    //print(viewmodel.deletedItemsArrayInModel[viewmodel.deletedItemsArrayInModel.firstIndex(of: datainResults.self) ?? 0] ) // Print The immediately Selected Item Array's Results
                                    
                                    viewmodel.deletedItemsArrayInModel[viewmodel.deletedItemsArrayInModel.firstIndex(of: datainResults.self) ?? 0].isselected.toggle()
                                    
                                }
                            
                            // MARK: - END OF THE ONTAP GESTURE OVER THE LIST PROJECTS
                            
                            Text(datainResults.projectName).font(.headline).multilineTextAlignment(.leading)
                                .frame(width: 200, height: 50, alignment: .leading).padding(.trailing)
                        }
                        
                    }
                    
                }
                
                .swipeActions (edge: .trailing, allowsFullSwipe: false) {
                    
                    Button("Delete") {
    
                        viewmodel.deletedItemsArrayInModel.remove(at: viewmodel.itemsArrayInModel.firstIndex(of: datainResults.self) ?? 0)
                        
                    }.tint(.red)
                    
                    Button("Recover to CoreData") {
                        
                        let newItems = CoreDataItems(context: viewContext)
                        
                        newItems.id = UUID()
                        newItems.projectName = datainResults.projectName
                        newItems.isselected = datainResults.isselected
                        
                        newItems.inputText1 = datainResults.inputText1
                        newItems.inputNumber1 = datainResults.inputNumber1
                        
                        do { try viewContext.save() } catch { let error = error as NSError
                            fatalError("Unresolved error \(error), \(error.userInfo)") }
                        
                        viewmodel.deletedItemsArrayInModel.remove(at: viewmodel.itemsArrayInModel.firstIndex(of: datainResults.self) ?? 0)
                        
                    }.tint(.blue)
                    
                    Button("Send to the Backup File") {
                        
                        viewmodel.backupItemsInModel.append(Model(
                            
                            id: UUID(),
                            projectName: datainResults.projectName,
                            isselected: datainResults.isselected,
                            inputText1: datainResults.inputText1,
                            inputNumber1: datainResults.inputNumber1
                            
                        ))
                        
                        viewmodel.deletedItemsArrayInModel.remove(at: viewmodel.itemsArrayInModel.firstIndex(of: datainResults.self) ?? 0)
                        
                    }.tint(.green)
                    
                }
                
            }
            
        }  //  END OF THE LIST VIEW OF ARRAYS OF DELETED PROJECTS OF THE APP - NOT IN COREDATA
        
        // MARK: - END OF THE BODY OF WHOLE VIEW
        
    }
    
    // MARK: - END OF THE STRUCT OF THE DELETED PROJECTS LIST VIEW OF THE APP
    
}
