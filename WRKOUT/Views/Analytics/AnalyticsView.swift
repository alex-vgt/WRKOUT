//
//  AnalyticsView.swift
//  WRKOUT
//
//  Created by Alex Voigt on 30.10.20.
//

import SwiftUI
import SwiftData

struct AnalyticsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Query()
    var exercises: [Exercise]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(exercises) { exercise in
                    NavigationLink(destination: ExerciseAnalyticsView(exercise: exercise)) {
                        AnalyticsRow(title: exercise.name)
                    }
                }
            }.navigationBarTitle(Text("Analytics"), displayMode: .large)
        }
    }
}
