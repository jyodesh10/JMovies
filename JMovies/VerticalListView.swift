//
//  VerticalListView.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 29.06.26.
//

import SwiftUI

struct VerticalListView: View {
    var titles : [Title]

    var body: some View {
        GeometryReader {
            geometry in
            List(titles) { title in
                NavigationLink{
                    TitleDetailView(title: title)
                } label: {
                    AsyncImage(url: URL(string: title.posterPath ?? "")!){image in
                        HStack {
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius: 10))
                                .padding(5)
                            Text(((title.name ?? title.title)!))
                        }
                    } placeholder: {
                        ProgressView()
                            .frame(width: geometry.size.width)
                    }
                    .frame(height: 150)
                }
                
            }
        }
    }
}

#Preview {
    VerticalListView(titles: Title.previewTitles )
}
