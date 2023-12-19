//
//  OverviewView.swift
//  WRKOUT
//
//  Created by Alex Voigt on 30.10.20.
//

import SwiftUI
import SwiftData

struct OverviewView: View {
    
    @State private var showNewTrainingSheet = false
    @State private var alertInput = ""
    
    @Environment(\.modelContext)
    private var context
    
    @Query
    var workouts: [Workout]
    
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
                                            title: ("\(String(describing: workout.name))"))
                                        .font(.body)
                                    }
                    }.onDelete(perform: deleteWorkout)
                }
                .navigationBarTitle(Text("WRKOUT"), displayMode: .large)
                .toolbar {
                    Menu {
                        Button("Add Workout") {
                            showNewTrainingSheet = true
                        }
                        EditButton()
                    }
                label: {
                    Label("Edit", systemImage: "ellipsis.circle").font(.body)
                }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .alert("Enter the name of the workout", isPresented: $showNewTrainingSheet) {
                TextField("Workout name", text: $alertInput).font(.body)
                Button("Save", action: saveNewWorkout)
                // TODO: Fix
                // .disabled(alertInput == "")
                Button("Cancel", role: .cancel) {alertInput = ""}
            }
        }
    }
    
    func saveNewWorkout() {
        print("save new workout")
        let newWorkout = Workout(created: Date.now, id: UUID(), name: alertInput)
        context.insert(newWorkout)
        do {
            try context.save()
            print("workout saved")
            alertInput = ""
        } catch {
            print(error)
        }
    }
    
    private func deleteWorkout(at offsets: IndexSet) {
        for index in offsets {
            let workout = workouts[index]
            context.delete(workout)
        }
        do {
            try context.save()
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
