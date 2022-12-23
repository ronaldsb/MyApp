//
//  ViewModel.swift
//
//
// 
//

// MARK: - IMPORTS

import Foundation

// MARK: - CLASS MODEL

class ViewModel: ObservableObject {
    
    // MARK: - VARS TO CONTROL DE ARRAY INDEX AND POSITIONS
    
    @Published var maxIndex: Int = 0
    @Published var selectedItemsArray: [Int] = []
    
    // MARK: - ALL THE ARRAYS NEEDED IN THE APP TO SAVE ALL THE VARIABLES OF THE PROJECT IN DIFFERENT PLACES
    
    @Published var itemsArrayInModel: [Model] = []
    @Published var deletedItemsArrayInModel: [Model] = []
    @Published var backupItemsInModel: [Model] = []
    
    // MARK: - ALL VARS NEEDED IN THE PROJECT
    
    @Published var id = UUID()
    @Published var projectName: String = ""
    @Published var isselected = false
    
    @Published var inputText1: String = ""
    @Published var inputNumber1: Int16 = 0
}
