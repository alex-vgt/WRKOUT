//
//  ExerciseView.swift
//  WRKOUT
//
//  Created by Alex Voigt on 06.11.20.
//

import SwiftUI

struct ExerciseView: View {
    @State private var showSheet: Bool = false
    @State private var repCount: Int = 0
    @State private var weightCount: Double = 0.0
    
    var exercise: Exercise
    var title: String
    
    var exerciseSetRequest: FetchRequest<ExerciseSet>
    
    @Environment(\.managedObjectContext) private var viewContext
    var sets: FetchedResults<ExerciseSet>{exerciseSetRequest.wrappedValue}
    
    init(exercise: Exercise, title: String) {
        self.exercise = exercise
        self.title = title
        exerciseSetRequest = FetchRequest(entity: ExerciseSet.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExerciseSet.created, ascending: false)], predicate: NSPredicate(format: "exercise == %@", exercise))
    }
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        List {
            ForEach(groupSets()) { (day: Day) in
                Section(header: Text(day.title)) {
                    ForEach(day.sets) { row in
                        ExerciseRow(reps: Int(row.reps), weight: row.weight).font(.body)
                    }.onDelete(perform: deleteExerciseSet)
                }
            }
        }
        
        // New set sheet
        .sheet(isPresented: $showSheet) {
            NavigationView {
                VStack {
                    Divider()
                    
                    Text("Reps").font(Font.body.weight(.bold))
                    Stepper("\(repCount)",
                            value: $repCount,
                            in: 0...100)
                    Divider()
                    
                    Text("Weight").font(Font.body.weight(.bold))
                    TextField("Weight", value: $weightCount, formatter: formatter)
                        .font(Font.body.weight(.medium))
                        .padding(5)
                        .keyboardType(.decimalPad)
                    Button(action: {
                        saveNewSet(reps: $repCount.wrappedValue, weight: $weightCount.wrappedValue)
                        self.showSheet = false
                    }) {
                        Text("Add")
                    }.disabled(weightCount == 0.0 || repCount == 0)
                        .buttonStyle(CustomButtonStyle())
                }
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            self.showSheet = false
                            cleanFields()
                        }) {
                            Text("Done").fontWeight(.semibold)
                        }
                    }
                }
            }
        }
        
        .navigationBarTitle(Text(exercise.name!), displayMode: .inline)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.showSheet = true
                }) {
                    Image(systemName: "plus").font(.system(size: 20))
                }
            }
        }
    }
    
    struct Day: Identifiable {
        let id = UUID()
        let title: String
        let sets: [ExerciseSet]
        let date: Date
    }
    
    private func groupSets() -> [Day] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        let grouped = Dictionary(grouping: sets) { (exSet: ExerciseSet) -> String in
            dateFormatter.string(from: exSet.created!)
        }
        
        let sections = grouped.map {date -> Day in
            Day(title: date.key, sets: date.value, date: date.value[0].created!)
        }.sorted { $0.date > $1.date }
        
        return sections
    }
    
    func saveNewSet(reps: Int, weight: Double) {
        print(reps, weight)
        let newSet = ExerciseSet(context: viewContext)
        newSet.weight = weight
        newSet.reps = Int64(reps)
        newSet.exercise = exercise
        newSet.id = UUID()
        if #available(iOS 15, *) {
            newSet.created = Calendar.current.startOfDay(for: Date.now)
        } else {
            newSet.created = Date()
        }
        do {
            try viewContext.save()
            print("Set saved")
            cleanFields()
        } catch {
            print(error)
        }
    }
    
    func deleteExerciseSet(at offsets: IndexSet) {
        for index in offsets {
            let set = sets[index]
            viewContext.delete(set)
        }
        do {
            try viewContext.save()
            print("set deleted")
        } catch {
            print(error)
        }
    }
    
    private func cleanFields() {
        repCount = 0
        weightCount = 0.0
    }
    
    /**
     Formats a given date to a useful format
     */
    private func formatDate(date: Date) -> String {
        print("format date", date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: date)
    }
}


public struct CustomButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.body.weight(.medium))
            .padding(.vertical, 12)
            .foregroundColor(Color.white)
            .frame(maxWidth: 200)
            .background(
                RoundedRectangle(cornerRadius: 14.0, style: .continuous)
                    .fill(Color.accentColor)
            )
            .opacity(configuration.isPressed ? 0.4 : 1.0)
    }
}
