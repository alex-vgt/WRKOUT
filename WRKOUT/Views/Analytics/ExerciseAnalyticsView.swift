//
//  ExerciseAnalyticsView.swift
//  WRKOUT
//
//  Created by Alex Privado on 06.12.21.
//

import SwiftUI
import SwiftUICharts
import SwiftData

struct ExerciseAnalyticsView: View {
    
    @Query
    var sets: [ExerciseSet]
    
    var exercise: Exercise
    
    init(exercise: Exercise) {
        self.exercise = exercise
    }
    
    var body: some View {
        LineView(data: getWeights(), title: exercise.name)
    }
    
    private func getWeights() -> [Double] {
        var weights: [Double] = []
        sets.forEach { exSet in
            weights.append(exSet.weight)
        }
        return weights
    }
}
