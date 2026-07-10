//
//  SearchView.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 09.07.26.
//

import SwiftUI

struct SearchView: View {
    @State private var searchByMovie = true
    @State private var searchText = ""
    private let searchViewModel = SearchViewModel()
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath)  {
            ScrollView{
                if let error = searchViewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                }
                
                LazyVGrid(
                    columns: [GridItem(),GridItem(),GridItem()])
                {
                    ForEach(searchViewModel.searchResults){ title in
                        AsyncImage(url: URL(string: title.posterPath ?? "")){
                            image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius: 10))
                                .frame(
                                    width: 120,
                                    height: 200
                                )
                                .onTapGesture {
                                    navigationPath.append(title)
                                }
                        } placeholder: {
                            ProgressView()
                        }
                        
                    }
                }
            }
            .navigationTitle(searchByMovie ? Constants.searchByMoviesString : Constants.searchByTVsString)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        searchByMovie.toggle()
                        
                        Task{
                            await searchViewModel.fetchSearchResults(by: searchByMovie ? "movie" : "tv", for: searchText)
                        }
                    } label: {
                        Image(systemName: searchByMovie ?
                              Constants.MovieIconString : Constants.TVIconString)
                    }
                }
            }
            .searchable(
                text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: searchByMovie ? Constants.searchByMoviesString : Constants.searchByTVsString)
            .task(id: searchText) {
                try? await Task.sleep(for: .milliseconds(500))
                
                if(Task.isCancelled) {
                    return
                }
                
                await searchViewModel.fetchSearchResults(by: searchByMovie ? "movie" : "tv", for: searchText)
            }
            .navigationDestination(for: Title.self) { title in
                TitleDetailView(title: title)
            }
        }
    }
}

#Preview {
    SearchView()
}
