//
//  ExerciseSet.swift
//  WRKOUT
//
//  Created by Alexander Voigt on 18.12.23.
//
//

import Foundation
import SwiftData

@Model
class ExerciseSet {
    var created: Date? = Date.now
    var id: UUID
    var reps: Int
    var weight: Double
    var exercise: Exercise
    
    public init(id: UUID, exercise: Exercise, reps: Int, weight: Double) {
        self.id = id
        self.exercise = exercise
        self.reps = reps
        self.weight = weight
    }
}
