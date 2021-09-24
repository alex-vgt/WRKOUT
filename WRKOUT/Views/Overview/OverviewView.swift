//
//  OverviewView.swift
//  WRKOUT
//
//  Created by Alex Voigt on 30.10.20.
//

import SwiftUI

struct OverviewView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Workout.entity(), sortDescriptors: [], predicate: nil)
    var workouts: FetchedResults<Workout>
    
    @State private var showNewTrainingSheet = false
    @State private var alertInput = ""
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(workouts) { workout in
                        NavigationLink(
                            destination:
                                WorkoutView(
                                    workout: workout)) {
                            OverviewRow(
                                title: ("\(String(describing: workout.name!))"))
                                .font(.body)
                        }
                    }.onDelete(perform: deleteWorkout)
                    
                }
                .navigationBarTitle(Text("WRKOUT"), displayMode: .large)
                .toolbar {
                    Menu {
                        Button("Add Workout") {
                            self.showNewTrainingSheet = true
                        }
                        EditButton()
                    }
                    label: {
                        Label("Edit", systemImage: "ellipsis.circle").font(.body)
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            if self.showNewTrainingSheet {
                NewWorkoutPopup(textString: $alertInput,
                                showAlert: $showNewTrainingSheet,
                                title: "New Workout",
                                message: "Save new workout",
                                overview: self)
            }
        }
        
    }
    
    func saveNewWorkout(workoutName: String) {
        let newWorkout = Workout(context: viewContext)
        newWorkout.id = UUID()
        newWorkout.name = workoutName
        do {
            try viewContext.save()
            print("workout saved")
        } catch {
            print(error)
        }
    }
    
    private func deleteWorkout(at offsets: IndexSet) {
        for index in offsets {
            let workout = workouts[index]
            viewContext.delete(workout)
        }
        do {
            try viewContext.save()
            print("workout deleted")
        } catch {
            print(error)
        }
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView()
    }
}
