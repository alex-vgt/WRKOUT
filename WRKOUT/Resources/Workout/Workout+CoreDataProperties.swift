//
//  Workout+CoreDataProperties.swift
//  WRKOUT
//
//  Created by Alex Voigt on 06.11.20.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?

}

extension Workout : Identifiable {

}
