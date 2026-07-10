//
//  Constants.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 31.03.26.
//

import Foundation
import SwiftUI


    struct Constants {
        static let homeString = "Home"
        static let upcomingString = "Upcoming"
        static let searchString = "Search"
        static let downloadString = "Download"
        static let playString = "Play"
        static let trendingMoviesString = "Trending Movies"
        static let topRatedMoviesString = "Top-Rated Movies"
        static let trendingTVsString = "Trending TVs"
        static let topRatedTVsString = "Top-Rated TVs"
        static let searchByMoviesString = "Search by Movies"
        static let searchByTVsString = "Search by TVs"
        static let moviePlaceholderString = "Search for a movie"
        static let TVPlaceholderString = "Search for a TV"
        
        
        static let homeIconString = "house"
        static let upcomingIconString = "play.circle"
        static let searchIconString = "magnifyingglass"
        static let downloadIconString = "arrow.down.to.line"
        static let TVIconString = "tv"
        static let MovieIconString = "movieclapper"
        
        
        static let testTitleUrl = "https://mediaproxy.tvtropes.org/width/1200/https://static.tvtropes.org/pmwiki/pub/images/6fa79a3251cbf9c1c929aaec71ebb1309c57566a61d490045de285525914f285_ur12002c1600_ri__waifu2x_art_noise1.png"
        static let testTitleUrl2 = "https://dn721606.ca.archive.org/0/items/mbid-400a3878-4f2d-4904-b4d6-29c0d9c1a552/mbid-400a3878-4f2d-4904-b4d6-29c0d9c1a552-32222690832.jpg"
        static let testTitleUrl3 = "https://dn721902.ca.archive.org/0/items/mbid-e7dab71c-f2fe-4a2c-9ffd-0b01dcc09152/mbid-e7dab71c-f2fe-4a2c-9ffd-0b01dcc09152-37829218434.jpg"
        
        static let posterURLStart = "https://image.tmdb.org/t/p/w500"
        
        static func addPosterPath(to titles: inout[Title]) {
            for index in titles.indices {
                if let path = titles[index].posterPath {
                    titles[index].posterPath = Constants.posterURLStart + path
                }
            }
        }
    }

enum YoutubeUrlStrings: String {
    case trailer = "trailer"
    case query = "q"
    case space = " "
    case key = "key"
}

extension Text {
    func ghostButton() -> some View {
        self
            .foregroundStyle(.buttonText)
            .frame(width: 100, height: 50)
            .bold()
            .background {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.buttonBorder, lineWidth: 2.5)
            }
    }
    
    func errorMessage() -> some View {
        self
            .foregroundColor(.red)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 10))
    }
}

