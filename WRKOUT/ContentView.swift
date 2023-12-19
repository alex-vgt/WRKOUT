//
//  ContentView.swift
//  WRKOUT
//
//  Created by Alexander Voigt on 19.12.23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        HomeView()
    }
}
