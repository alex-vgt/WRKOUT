//
//  TrainingView.swift
//  WRKOUT
//
//  Created by Alex Voigt on 30.10.20.
//

import SwiftUI

struct TrainingView: View {
    var title: String
    var body: some View {
        Text(title)
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView(title: "Chest")
    }
}
