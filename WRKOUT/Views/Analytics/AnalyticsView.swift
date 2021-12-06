//
//  AnalyticsView.swift
//  WRKOUT
//
//  Created by Alex Voigt on 30.10.20.
//

import SwiftUI

struct AnalyticsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Exercise.entity(), sortDescriptors: [], predicate: nil)
    var exercises: FetchedResults<Exercise>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(exercises) { exercise in
                    NavigationLink(destination: ExerciseAnalyticsView(exercise: exercise)) {
                        AnalyticsRow(title: exercise.name!)
                    }
                }
            }.navigationBarTitle(Text("Analytics"), displayMode: .large)
        }
    }
}
