//
//  JMoviesApp.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 31.03.26.
//

import SwiftUI
import SwiftData

@main
struct JMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Title.self)
    }
}
