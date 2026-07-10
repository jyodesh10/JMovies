//
//  SearchViewModel.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 10.07.26.
//

import Foundation



@Observable

class SearchViewModel {
    private(set) var errorMessage: String?
    private(set) var searchResults: [Title] = []
    var dataFetcher = DataFetcher()
    
    func fetchSearchResults(by media:String, for title:String) async {
        do{
            errorMessage = nil
            if(title.isEmpty) {
                searchResults = try await dataFetcher.fetchTitles(for: media, by: "trending")
            } else{
                searchResults = try await dataFetcher.fetchTitles(for: media, by: "search", searchTerm: title)
            }
            
        } catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
}
