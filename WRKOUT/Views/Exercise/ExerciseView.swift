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
    @FetchRequest(entity: Set.entity(), sortDescriptors: [], predicate: nil)
    var sets: FetchedResults<Set>
    
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    var body: some View {
            VStack {
                List {
                    ForEach(sets.filter {
                        $0.exercise == exercise
                    }) { set in
                            ExerciseRow(
                                title: ("\(String(describing: set.weight.description))"))
                                .font(.body)
                    }
                }

            }

            .sheet(isPresented: $showSheet) {
                NavigationView {
                    VStack {
                        Divider()
                        Text("Reps").font(Font.body.weight(.bold))
                        Stepper("\(repCount)",
                                value: $repCount,
                                in: 0...100)
                            .padding(5)
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
                        }.buttonStyle(CustomButtonStyle())
                    }
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button(action: {
                                self.showSheet = false
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
}

func saveNewSet(reps: Int, weight: Double) {
    print(reps, weight)

}

public struct CustomButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.body.weight(.medium))
            .padding(.vertical, 12)
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 14.0, style: .continuous)
                    .fill(Color.accentColor)
                )
            .opacity(configuration.isPressed ? 0.4 : 1.0)
    }
}

