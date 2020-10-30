//
//  HomeView.swift
//  WRKOUT
//
//  Created by Alex Voigt on 30.10.20.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            
            OverviewView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("Overview")
                    }
                }
                .tag(0)
            
            AnalyticsView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "waveform.path.ecg")
                        Text("Analytics")
                    }
                }
                .tag(1)
            
            SettingsView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
                .tag(2)
        }.navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
