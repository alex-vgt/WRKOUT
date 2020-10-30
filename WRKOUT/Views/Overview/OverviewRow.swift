//
//  OverviewRow.swift
//  WRKOUT
//
//  Created by Alex Voigt on 30.10.20.
//

import SwiftUI

struct OverviewRow: View {
    var title: String
    var body: some View {
        Text(title)
    }
}

struct OverviewRow_Previews: PreviewProvider {
    static var previews: some View {
        OverviewRow(title: "Chest")
    }
}
