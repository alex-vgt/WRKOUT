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
    var reps: Int? = 0
    var weight: Double? = 0
    var exercise: Exercise
    
    public init(id: UUID, exercise: Exercise) {
        self.id = id
        self.exercise = exercise
    }
}
