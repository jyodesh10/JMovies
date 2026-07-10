//
//  ContentView.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 31.03.26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab(Constants.homeString, systemImage: Constants.homeIconString) {
                HomeView()
            }
            Tab(Constants.upcomingString, systemImage: Constants.upcomingIconString) {
                UpcomingView()
            }
            Tab(Constants.searchString, systemImage: Constants.searchIconString) {
                SearchView()
            }
            Tab(Constants.downloadString, systemImage: Constants.downloadIconString) {
                DownloadView()
            }
        }.onAppear {
            if let config = APIConfig.shared{
                print(config.baseUrl)
                print(config.apiKey)
            }
        }
    }
}

#Preview {
    ContentView()
}
