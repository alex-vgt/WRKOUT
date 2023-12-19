//
//  Exercise.swift
//  WRKOUT
//
//  Created by Alexander Voigt on 18.12.23.
//
//

import Foundation
import SwiftData


@Model
class Exercise {
    var created: Date
    var id: UUID
    var name: String
    @Relationship(deleteRule: .cascade, inverse: \ExerciseSet.exercise)
    var sets: [ExerciseSet]?
    var workout: Workout
    
    public init(created: Date, id: UUID, name: String, workout: Workout) {
        self.created = created
        self.id = id
        self.name = name
        self.workout = workout
    }
}
