//
//  Exercise+CoreDataProperties.swift
//  WRKOUT
//
//  Created by Alex Voigt on 01.11.20.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?

}

extension Exercise : Identifiable {

}
