//
//  ExerciseRow.swift
//  WRKOUT
//
//  Created by Alexander Voigt on 10.09.21.
//

import SwiftUI

struct ExerciseRow: View {
    var reps: Int
    var weight: Double
    var body: some View {
        Text("\(reps.description) x \(weight.description)kg").font(.body)
    }
}
