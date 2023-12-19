//
//  TrainingView.swift
//  WRKOUT
//
//  Created by Alex Voigt on 30.10.20.
//

import SwiftUI
import SwiftData

struct WorkoutView: View {
    var workout: Workout
    @State private var showNewExercisePopup = false
    @State private var alertInput = ""
    
    @Environment(\.modelContext)
    private var context
    
    @Query
    var exercises: [Exercise]
    
    var body: some View {
        VStack {
                
                List {
                    ForEach(exercises.filter {
                        $0.workout == workout
                    }) { exercise in
                        NavigationLink(
                            destination: ExerciseView(
                                exercise: exercise,
                                title: ("\(String(describing: exercise.name))"))) {
                            WorkoutRow(
                                title: ("\(String(describing: exercise.name))"))
                                .font(.body)
                        }
                    }.onDelete(perform: deleteExercise)
                }
                .navigationBarTitle(Text(workout.name), displayMode: .inline)
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button("Add Exercise") {
                                self.showNewExercisePopup = true
                            }
                            EditButton()
                        }
                        label: {
                            Label("Edit", systemImage: "ellipsis.circle").font(.body)
                        }
                        
                    }
                }
                .alert("Enter the name of the exercise", isPresented: $showNewExercisePopup) {
                    TextField("Exercise name", text: $alertInput).font(.body)
                    Button("Save", action: saveNewExercise)
                    // TODO: Fix
                    // .disabled(alertInput == "")
                    Button("Cancel", role: .cancel) {alertInput = ""}
                }
    }
    }
    
    func saveNewExercise() {
        let newExercise = Exercise(created: Date.now, id: UUID(), name: alertInput, workout: workout)
        context.insert(newExercise)
        do {
            try context.save()
            print("exercise saved")
            alertInput = ""
        } catch {
            print(error)
        }
    }
    
    func deleteExercise(at offsets: IndexSet) {
        for index in offsets {
            let exercise = exercises[index]
            context.delete(exercise)
        }
        do {
            try context.save()
            print("exercise deleted")
        } catch {
            print(error)
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(workout: Workout(created: Date.now, id: UUID(), name: "workout"))
    }
}
