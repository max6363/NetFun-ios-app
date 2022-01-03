//
//  HomeView.swift
//  NetFun-ios-app
//
//  Created by Minhaz on 30/12/21.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var modelData = ProfilesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(modelData.homeContent.collection) { colItem in
                        Section(colItem.title) {
                            ForEach(colItem.items) { item in
                                Text(item.title)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Home")
        }
        .onAppear(perform: {
            modelData.fetchHomeContent()
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
