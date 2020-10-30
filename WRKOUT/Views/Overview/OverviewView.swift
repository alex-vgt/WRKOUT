//
//  OverviewView.swift
//  WRKOUT
//
//  Created by Alex Voigt on 30.10.20.
//

import SwiftUI

struct OverviewView: View {
    var body: some View {
        VStack {
            NavigationView {
                List {
                    NavigationLink(
                        destination: TrainingView(title: "Chest")) {
                        OverviewRow(title: "Chest").font(.body)
                    }
                }.navigationBarTitle(Text("WRKOUT"), displayMode: .large)
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("+") {
                            print("add")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Edit") {
                            print("edit")
                        }
                    }
                 }
            }
        }
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView()
    }
}
