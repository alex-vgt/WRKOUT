//
//  ExerciseAnalyticsView.swift
//  WRKOUT
//
//  Created by Alex Privado on 06.12.21.
//

import SwiftUI
import SwiftUICharts

struct ExerciseAnalyticsView: View {
    
    var exerciseSetRequest: FetchRequest<ExerciseSet>
    
    @Environment(\.managedObjectContext) private var viewContext
    var sets: FetchedResults<ExerciseSet>{exerciseSetRequest.wrappedValue}
    
    var exercise: Exercise
    
    init(exercise: Exercise) {
        self.exercise = exercise
        exerciseSetRequest = FetchRequest(entity: ExerciseSet.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExerciseSet.created, ascending: false)], predicate: NSPredicate(format: "exercise == %@", exercise))
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
