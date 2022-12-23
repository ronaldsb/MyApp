//
//  FirstViewStacks.swift
//
//
//
//

// MARK: - IMPORTS

import SwiftUI

// MARK: - STRUCT FOR ADDING A NEW ITEM ARRAY IN THE MODEL - ITS A BUTTON

struct FirstViewStacks: View {
    
    // MARK: - BODY
    
    var body: some View {
        
        HStack {
            
            // MARK: - GROUPS ARE NEEDED BECAUSE I HAVE MORE THAN 7 VSTACKS VIEWS
            
            Group {
                
                Spacer()
                
                AddNewItemArrayInModelButton()
                
                Spacer()
                
                DeleteFirstItemArrayInModelButton()
                
                Spacer()
                
            }
            
            // MARK: - GROUPS ARE NEEDED BECAUSE I HAVE MORE THAN 7 VSTACKS VIEWS
            
            Group {
                
                DeleteLastItemArrayInModelButton()
                
                Spacer()
                
                DeleteAllItemsArrayInModelButton()
                
                Spacer()
                
                DeleteSelectedItemsArrayInModelButton()
                
                Spacer()
                
                AddSelectedItemsArrayToBackUpInModelButton()
                
                Spacer()
                
                EmptyDeletedItemsButton()
                
                Spacer()
            }
            
        }  // END HSTACK
        
        Group {
            
            ProjectsListView()
            
            Spacer()
            
            DeletedItemsListView()
            
            Spacer()
            
            BackeupItemsListView()
            
            Spacer()
            
        }
        
        // MARK: - END OF THE BUTTON VIEW
        
    }
    
    // MARK: - END OF STRUCT FOR ADDING A NEW ITEM ARRAY IN THE MODEL - ITS A BUTTON
    
}
