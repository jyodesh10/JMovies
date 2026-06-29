//
//  HorizontalListView.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 31.03.26.
//

import SwiftUI

struct HorizontalListView: View {
    
    let header : String
    
    var titles : [Title]
    var onSelect : (Title) -> Void
    var body: some View {
        VStack(alignment: .leading) {
            Text(header)
                .font(.title)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: -40, trailing: 0))
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(titles) { title in
                        AsyncImage(url: URL(string: title.posterPath ?? "")){ image in image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(
                            width: 150, height: 200
                        )
                        .onTapGesture {
                            onSelect(title)
                        }
                        
                    }
                }
            }
        }
        .frame(height: 300)
            
    }
}

#Preview {
    HorizontalListView(header: Constants.trendingMoviesString, titles: Title.previewTitles) {
        title in
    }
}
