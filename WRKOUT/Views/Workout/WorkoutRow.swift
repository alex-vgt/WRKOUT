//
//  WorkoutRow.swift
//  WRKOUT
//
//  Created by Alex Voigt on 06.11.20.
//

import SwiftUI

struct WorkoutRow: View {
    var title: String
    var body: some View {
        Text(title)
    }
}

struct WorkoutRow_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutRow(title: "WorkoutRow")
    }
}
