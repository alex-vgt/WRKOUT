//
//  Set+CoreDataProperties.swift
//  WRKOUT
//
//  Created by Alex Voigt on 28.11.20.
//
//

import Foundation
import CoreData


extension Set {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Set> {
        return NSFetchRequest<Set>(entityName: "Set")
    }

    @NSManaged public var created: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var reps: Int64
    @NSManaged public var weight: Int64
    @NSManaged public var exercise: Exercise?

}

extension Set : Identifiable {

}
