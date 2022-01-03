//
//  ContentView.swift
//  NetFun-ios-app
//
//  Created by Minhaz on 28/12/21.
//

import SwiftUI
import NetFunCore

struct ContentView: View {

    @StateObject var modelData = ProfilesViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(modelData.profiles) { profile in
                    Text(profile.name)
                }
            }
        }
        .onAppear {
            modelData.fetchProfiles()
        }
        .navigationTitle("Profiles")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
