//
//  SettingsView.swift
//  WRKOUT
//
//  Created by Alex Voigt on 30.10.20.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            NavigationView {
                List {
                    NavigationLink(
                        destination: GeneralSettingsView(),
                        label: {
                            Text("General").font(.body)
                        })
                    
                    NavigationLink(
                        destination: ProfileSettingsView(),
                        label: {
                            Text("Profile").font(.body)
                        })
                }.navigationBarTitle(Text("Settings"), displayMode: .large)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
