//
//  ProjectsListView.swift
//
//
// 
//

// MARK: - IMPORTS

import SwiftUI

// MARK: - STRUCT OF THE PROJECTS LIST VIEW OF THE APP

struct ProjectsListView: View {
    
    // MARK: - VARS FOR ACCESING THE VIEWMODEL
    
    @EnvironmentObject var viewmodel: ViewModel
    
    // MARK: - BODY
    
    var body: some View {
        
        // MARK: - TITLE OF THE FIRST PART OF THE VIEW
        
        HStack {
            
            Spacer()
            
            Text("Items of the Project")
            
            Spacer()
        }
        
        // MARK: - LIST VIEW OF ARRAYS OF PROJECTS OF THE APP - NOT IN COREDATA
        
        List {
            
            ForEach(viewmodel.itemsArrayInModel) { datainResults in
                
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
                                    //print(viewmodel.itemsArrayInModel[viewmodel.itemsArrayInModel.firstIndex(of: datainResults.self) ?? 0] ) // Print The immediately Selected Item Array's Results
                                    
                                    viewmodel.itemsArrayInModel[viewmodel.itemsArrayInModel.firstIndex(of: datainResults.self) ?? 0].isselected.toggle()
                                    
                                }
                            
                            // MARK: - END OF THE ONTAP GESTURE OVER THE LIST PROJECTS
                            
                            Text(datainResults.projectName).font(.headline).multilineTextAlignment(.leading).frame(width: 200, height: 50, alignment: .leading).padding(.trailing)
                            
                        }
                        
                    }
                    
                }
                
                .swipeActions (edge: .trailing, allowsFullSwipe: false) {
                    
                    Button("Delete") {
                        
                        viewmodel.deletedItemsArrayInModel.append(viewmodel.itemsArrayInModel[viewmodel.itemsArrayInModel.firstIndex(of: datainResults.self) ?? 0])
                        viewmodel.itemsArrayInModel.remove(at: viewmodel.itemsArrayInModel.firstIndex(of: datainResults.self) ?? 0)
                        
                    }.tint(.red)
                    
                    Button("Recover to Project List") {
                        
                        // FALTA
                        
                    }.tint(.blue)
                    
                    Button("Send to the Backup File") {
                        
                        viewmodel.backupItemsInModel.append(Model(
                            
                            id: UUID(),
                            projectName: datainResults.projectName,
                            isselected: datainResults.isselected,
                            inputText1: datainResults.inputText1,
                            inputNumber1: datainResults.inputNumber1
                            
                        ))
                        
                    }.tint(.green)
                    
                }
                
            }
            
        }  // END OF LIST VIEW OF ARRAYS OF PROJECTS OF THE APP - NOT IN COREDATA
        
        
        // MARK: - END OF THE BODY OF WHOLE VIEW
        
    }
    
    // MARK: - END OF THE STRUCT OF THE PROJECTS LIST VIEW OF THE APP
    
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsListView()
    }
}
