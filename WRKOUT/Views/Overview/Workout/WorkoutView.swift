//
//  TrainingView.swift
//  WRKOUT
//
//  Created by Alex Voigt on 30.10.20.
//

import SwiftUI

struct WorkoutView: View {
    var title: String
    var body: some View {
        Text(title)
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(title: "Chest")
    }
}
