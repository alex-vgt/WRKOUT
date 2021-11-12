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
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Set.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Set.created, ascending: false)], predicate: nil)
    var sets: FetchedResults<Set>
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        List {
            ForEach(groupList(sets: sets)) { (exerciseSet: Set) in
                Section(header: Text(formatDate(date: exerciseSet.created!))) {
                    ForEach(sets) { row in
                        ExerciseRow(reps: Int(row.reps), weight: row.weight).font(.body)
                    }
                }
            }
        }
        
        //        List {
        //            ForEach(sets.filter {
        //                // get all sets for given exercise
        //                $0.exercise == exercise
        //            }) { (exerciseSet: Set) in
        //                Section(header: Text(formatDate(date: exerciseSet.created!))) {
        //                    ForEach(sets.filter {
        //                        Calendar.current.compare($0.created!, to: exerciseSet.created!, toGranularity: Calendar.Component.day) == .orderedDescending
        //                        // checkIfSameDay(date1: $0.created!, date2: exerciseSet.created!)
        //                    }) { row in
        //                        ExerciseRow(reps: Int(row.reps), weight: row.weight).font(.body)
        //                    }
        //                }
        //            }
        //        }
        
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
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func saveNewSet(reps: Int, weight: Double) {
        print(reps, weight)
        let newSet = Set(context: viewContext)
        newSet.weight = weight
        newSet.reps = Int64(reps)
        newSet.exercise = exercise
        newSet.id = UUID()
        if #available(iOS 15, *) {
            newSet.created = Date.now
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
    
    private func cleanFields() {
        repCount = 0
        weightCount = 0.0
    }
    
    private func groupList(sets: FetchedResults<Set>) -> FetchedResults<Set> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        var dates: [Date] = []
        
        sets.forEach { singleSet in
            dateFormatter.date(from: singleSet.created!.description)
            dates.append(Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: singleSet.created!))!)
        }
        print("dates", dates)
        let groupedSets = Dictionary(grouping: sets, by: { $0.created })
        
        
        return sets
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
    
    private func checkIfSameDay(date1: Date, date2: Date) -> Bool {
        let cal = Calendar.current
        return cal.isDate(date1, inSameDayAs: date2)
    }
    
    private func sortDates(date1: Date, date2: Date) -> Bool {
        let cal = Calendar.current
        let res = cal.compare(date1, to: date2, toGranularity: Calendar.Component.day)
        return true
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
