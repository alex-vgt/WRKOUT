//
//  ExerciseView.swift
//  WRKOUT
//
//  Created by Alex Voigt on 06.11.20.
//

import SwiftUI

struct ExerciseView: View {
    var title: String
    var body: some View {
        Text(title)
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(title: "ExerciseView")
    }
}
