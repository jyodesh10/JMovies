//
//  ViewModel.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 17.06.26.
//

import Foundation


@Observable
class ViewModel {
    enum FetchingState {
        case notStarted
        case fetching
        case success
        case failed(underlyingError: Error)
    }
    private(set) var homeStatus: FetchingState = .notStarted
    private(set) var videoStatus: FetchingState = .notStarted
    
    var videoId: String = ""

    private let dataFetcher = DataFetcher()
    var trendingMovies: [Title] = []
    var trendingTVs: [Title] = []
    var topRatedMovies: [Title] = []
    var topRatedTVs: [Title] = []
    var heroTitle: Title = Title.previewTitles[0]
    
    func getTitles() async {
        homeStatus = .fetching
        
        if trendingMovies.isEmpty {
            
            do {
                
                async let tMovies = dataFetcher.fetchTitles(for: "movie", by: "trending")
                async let tTVs = dataFetcher.fetchTitles(for: "tv", by: "trending")
                async let tRMovies = dataFetcher.fetchTitles(for: "movie", by: "top_rated")
                async let tRTVs = dataFetcher.fetchTitles(for: "tv", by: "top_rated")
                
                trendingMovies = try await tMovies
                trendingTVs = try await tTVs
                topRatedMovies = try await tRMovies
                topRatedTVs = try await tRTVs
                
                if let title = trendingMovies.randomElement() {
                    heroTitle = title
                }
                
                homeStatus = .success
            } catch {
                print(error)
                homeStatus = .failed(underlyingError: error)
            }
        } else {
            homeStatus = .success
        }
        
    }
    
    func getVideoId (for title: String) async {
        videoStatus = .fetching
        do{
            videoId = try await dataFetcher.fetchVideoID(for: title)
            videoStatus = .success
        } catch {
            print(error)
            videoStatus = .failed(underlyingError: error)
        }
    }

}
