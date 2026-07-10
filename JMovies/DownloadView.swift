//
//  DownloadView.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 10.07.26.
//

import SwiftUI
import SwiftData

struct DownloadView: View {
    @Query(sort: \Title.title) var savedTitles: [Title]

    var body: some View {
        NavigationStack{
            if(savedTitles.isEmpty) {
                Text("No Downloads yet")
                    .font(.title3)
                    .padding()
                    .bold()
            } else {
                VerticalListView(titles: savedTitles, canDelete: true)
            }
        }
    }
}

#Preview {
    DownloadView()
}
