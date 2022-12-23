//
//  FirstView.swift
//
//
// 
//

// MARK: - IMPORTS

import SwiftUI

// MARK: - STRUCT OF THW FIRST VIEW OF THE APP

struct FirstView: View {
    
    // MARK: - VARS FOR ACCESING THE VIEWMODEL
    
    @EnvironmentObject var viewmodel: ViewModel
    
    // MARK: - VARS FOR ACCESING THE COREDATA FETCH REQUESTS
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CoreDataItems.projectName, ascending: false)])
    var coreDataItemsFetchedResults: FetchedResults<CoreDataItems>
    
    // MARK: - BODY
    
    var body: some View {
        
        // MARK: - VSTACK FOR ALL THE VIEW
        
        VStack {
            
            // MARK: - TEXTEDITOR INPUT
            
            TextEditor(text: $viewmodel.projectName).frame(height: 50).border(.gray).padding()
            
            // MARK: - BUTTON TO ADD NEW ITEMS TO COREDATA
            
            HStack {
                
                Spacer()
                
                Text("Items of the Project in CoreData")
                
                Spacer()
            }
            
            AddNewItemsToCoreDataButton()
            
            // MARK: - LIST OF PROJECTS IN COREDATA
            
            List {
                
                ForEach(coreDataItemsFetchedResults) { datainResults in
                    
                    HStack {
                        
                        VStack {
                            
                            Text(" \(datainResults.id ?? UUID()) ")
                                .font(.headline)
                                .multilineTextAlignment(.leading)
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
                                        
                                        //print(datainResults.id ?? UUID())  //Print The ID of The immediately Selected Item
                                        datainResults.isselected.toggle()    //Change the state of isselected of The immediately Selected Item
                                        
                                    }
                                
                                // MARK: - END OF THE ONTAP GESTURE OVER THE LIST PROJECTS
                                
                                Text(datainResults.projectName ?? "No projects found")
                                    .font(.headline).multilineTextAlignment(.leading).frame(width: 200, height: 50, alignment: .leading).padding(.trailing)
                                
                            }
                            
                        }
                        
                    }
                    
                    .swipeActions (edge: .trailing, allowsFullSwipe: false) {
                        
                        Button("Delete") {
                            
                            viewmodel.deletedItemsArrayInModel.append(Model(
                                
                                id: datainResults.id ?? UUID(),
                                projectName: datainResults.projectName ?? "",
                                isselected: datainResults.isselected,
                                inputText1: datainResults.inputText1 ?? "",
                                inputNumber1: datainResults.inputNumber1
                                
                            ))
                            
                            viewContext.delete(datainResults.self)
                            
                        }.tint(.red)
                        
                        Button("Send to the Backup File") {
                            
                            viewmodel.backupItemsInModel.append(Model(
                                
                                id: datainResults.id ?? UUID(),
                                projectName: datainResults.projectName ?? "",
                                isselected: datainResults.isselected,
                                inputText1: datainResults.inputText1 ?? "",
                                inputNumber1: datainResults.inputNumber1
                                
                            ))
                            
                        }.tint(.green)
                        
                    }
                }
                
                // MARK: - END OF ONDELETE OPTION TO BE ABLE TO ERRASE COREDATA ITEMS
                
            }  // END OF LIST OF PROJECTS IN COREDATA
            
            //  .toolbar { EditButton() }    // THE EDIT BUTTON ONLY WORKS BEING INSIDE A NAVIGATION STACK
            
            // MARK: - OTHER VIEWS AFTER THE COREDATA PROJECT LIST
            
            FirstViewStacks()
            
        }  // END OF THE VSTACK FOR ALL THE VIEW
        
        // MARK: - SOME VIEW
    }
    
    // MARK: - END STRUCT OF THE FIRST VIEW OF THE APP
}

// MARK: - PREVIEW

struct FirstView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        FirstView().environmentObject(ViewModel())
        
    }
    
}
