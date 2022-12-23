//
//  AddNewItemArrayInModelButton.swift
//
//
// 
//

// MARK: - IMPORTS

import SwiftUI

// MARK: - STRUCT FOR ADDING A NEW ITEM ARRAY IN THE MODEL - ITS A BUTTON

struct AddNewItemArrayInModelButton: View {
    
    // MARK: - VARS
    
    @EnvironmentObject var viewmodel: ViewModel
    
    // MARK: - BODY
    
    var body: some View {
        
        // MARK: - BUTTON VIEW
        
        Button {
            
            // MARK: - CODE TO ADD A NEW ITEMS ARRAY IN THE MODEL
            
            viewmodel.itemsArrayInModel.append(Model(
                
                id: UUID(),
                projectName: viewmodel.projectName,
                isselected: viewmodel.isselected,
                inputText1: viewmodel.inputText1,
                inputNumber1: viewmodel.inputNumber1
                
            ))
            
            // MARK: - END OF CODE TO ADD A NEW ITEMS ARRAY IN THE MODEL
            
            viewmodel.maxIndex = viewmodel.maxIndex + 1
            
            if viewmodel.maxIndex <= viewmodel.itemsArrayInModel.indices.max()!
            { viewmodel.maxIndex = viewmodel.itemsArrayInModel.indices.max()! }
            
        } label: { Text("Add a New Item") }.tint(.blue).buttonStyle(.borderedProminent).fixedSize().padding()
        
        // MARK: - END OF THE BUTTON VIEW
        
    }
    
    // MARK: - END OF STRUCT FOR ADDING A NEW ITEM ARRAY IN THE MODEL - ITS A BUTTON
    
}
