//
//  BackeupItemsListView.swift
//
//
// 
//

// MARK: - IMPORTS

import SwiftUI

// MARK: - STRUCT OF THE BACKEDUP PROJECTS LIST VIEW OF THE APP

struct BackeupItemsListView: View {
    
    // MARK: - VARS FOR ACCESING THE VIEWMODEL
    
    @EnvironmentObject var viewmodel: ViewModel
    
    // MARK: - VARS FOR ACCESING COREDATA
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: - BODY
    
    var body: some View {
        
        // MARK: - STRUCT OF THE BACKEDUP PROJECTS LIST VIEW OF THE APP
        
        HStack {
            
            Spacer()
            
            Text("Backedup Items of the Project")
            
            Spacer()
        }
        
        // MARK: - LIST VIEW OF ARRAYS OF BACKEDUP PROJECTS OF THE APP - NOT IN COREDATA
        
        List {
            
            ForEach(viewmodel.backupItemsInModel) { datainResults in
                
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
                            
                            // MARK: - ONTAP GESTURE
                            
                                .onTapGesture {
                                    
                                    viewmodel.backupItemsInModel[viewmodel.backupItemsInModel.firstIndex(of: datainResults.self) ?? 0].isselected.toggle()
                                    
                                }
                            
                            Text(datainResults.projectName)
                                .font(.headline).multilineTextAlignment(.leading)
                                .frame(width: 200, height: 50, alignment: .leading).padding(.trailing)
                        }
                        
                    }
                    
                }
                
                .swipeActions (edge: .trailing, allowsFullSwipe: false) {
                    
                    Button("Delete") {
                        
                        viewmodel.deletedItemsArrayInModel.append(viewmodel.backupItemsInModel[viewmodel.backupItemsInModel.firstIndex(of: datainResults.self) ?? 0])
                        viewmodel.backupItemsInModel.remove(at: viewmodel.backupItemsInModel.firstIndex(of: datainResults.self) ?? 0)
                        
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
                        
                        viewmodel.backupItemsInModel.remove(at: viewmodel.backupItemsInModel.firstIndex(of: datainResults.self) ?? 0)
                        
                    }.tint(.blue)
                    
                }
                
            }
            
        }  // END OF LIST VIEW OF ARRAYS OF BACKEDUP PROJECTS OF THE APP - NOT IN COREDATA
        
        // MARK: - END OF THE BODY OF WHOLE VIEW
        
    }
    
    // MARK: - END OF THE STRUCT OF THE BACKEDUP PROJECTS LIST VIEW OF THE APP
}
