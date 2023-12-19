//
//  Workout.swift
//  WRKOUT
//
//  Created by Alexander Voigt on 18.12.23.
//
//

import Foundation
import SwiftData


@Model
class Workout {
    var created: Date
    var id: UUID
    var name: String
    @Relationship(deleteRule: .cascade)
    var exercises: [Exercise]?
    
    public init(created: Date, id: UUID, name: String) {
        self.created = created
        self.id = id
        self.name = name
    }
}
