//
//  ExerciseRow.swift
//  WRKOUT
//
//  Created by Alexander Voigt on 10.09.21.
//

import SwiftUI

struct ExerciseRow: View {
    var title: String
    var body: some View {
        Text(title)
    }
}

struct ExerciseRow_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseRow(title: "Set")
    }
}
