//
//  Model.swift
//  
//
// 
//

// MARK: - IMPORTS

import Foundation

// MARK: - STRUCT MODEL

struct Model: Identifiable, Equatable, Hashable {
    
    // MARK: - VARS TO IDENTIFY THE PROJECT OR THE ARRAY
    
    var id = UUID()
    var projectName: String
    var isselected = false
    
    // MARK: - OTHER VARS NEEDED FOR THE PROJECT
    
    var inputText1: String
    var inputNumber1: Int16
    
}
