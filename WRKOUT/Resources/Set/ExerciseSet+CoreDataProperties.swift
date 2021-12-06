//
//  ExerciseSet+CoreDataProperties.swift
//  WRKOUT
//
//  Created by Alex Privado on 04.12.21.
//
//

import Foundation
import CoreData


extension ExerciseSet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseSet> {
        return NSFetchRequest<ExerciseSet>(entityName: "ExerciseSet")
    }

    @NSManaged public var created: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var reps: Int64
    @NSManaged public var weight: Double
    @NSManaged public var exercise: Exercise?

}

extension ExerciseSet : Identifiable {

}
