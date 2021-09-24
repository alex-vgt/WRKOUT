//
//  TrainingView.swift
//  WRKOUT
//
//  Created by Alex Voigt on 30.10.20.
//

import SwiftUI

struct WorkoutView: View {
    var workout: Workout
    @State private var showNewExercisePopup = false
    @State private var alertInput = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Exercise.entity(), sortDescriptors: [], predicate: nil)
    var exercises: FetchedResults<Exercise>
    
    var body: some View {
        VStack {
                
                List {
                    ForEach(exercises.filter {
                        $0.workout == workout
                    }) { exercise in
                        NavigationLink(
                            destination: ExerciseView(
                                exercise: exercise,
                                title: ("\(String(describing: exercise.name!))"))) {
                            WorkoutRow(
                                title: ("\(String(describing: exercise.name!))"))
                                .font(.body)
                        }
                    }.onDelete(perform: deleteExercise)
                }
                .navigationBarTitle(Text(workout.name!), displayMode: .inline)
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

            if self.showNewExercisePopup {
                NewExercisePopup(textString: $alertInput,
                                 showAlert: $showNewExercisePopup,
                                 title: "New Exercise",
                                 message: "Save new exercise",
                                 overview: self)
            }
    }
    }
    
    func saveNewExercise(exerciseName: String) {
        let newExercise = Exercise(context: viewContext)
        newExercise.id = UUID()
        newExercise.name = exerciseName
        newExercise.workout = workout
        do {
            try viewContext.save()
            print("exercise saved")
        } catch {
            print(error)
        }
    }
    
    func deleteExercise(at offsets: IndexSet) {
        for index in offsets {
            let exercise = exercises[index]
            viewContext.delete(exercise)
        }
        do {
            try viewContext.save()
            print("exercise deleted")
        } catch {
            print(error)
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(workout: Workout())
    }
}
