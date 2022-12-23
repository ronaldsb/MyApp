//
//  CoreDataItems+CoreDataProperties.swift
//
//
// 
//
//

import Foundation
import CoreData

extension CoreDataItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataItems> {
        return NSFetchRequest<CoreDataItems>(entityName: "CoreDataItems") }

    @NSManaged public var id: UUID?
    @NSManaged public var projectName: String?
    @NSManaged public var isselected: Bool
    
    @NSManaged public var inputText1: String?
    @NSManaged public var inputNumber1: Int16

}

extension CoreDataItems: Identifiable { }
