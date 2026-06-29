//
//  HomeView.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 31.03.26.
//

import SwiftUI

struct HomeView: View {
    let viewModel = ViewModel()
    @State private var titleDetailPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $titleDetailPath) {
            GeometryReader { geo in
                ScrollView(.vertical) {
                    switch viewModel.homeStatus {
                    case .notStarted:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                            .frame(width : geo.size.width, height: geo.size.height)
                    case .success:
                        LazyVStack{
                            AsyncImage(url: URL(string: viewModel.heroTitle.posterPath ?? "")) {
                                image in image.resizable().scaledToFill()
                                    .overlay{
                                        LinearGradient(
                                            stops: [Gradient.Stop(color: .clear, location: 0.5),
                                                    Gradient.Stop(color: .gradient, location: 1)
                                                   ],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    }
                            }
                            placeholder: {
                                ProgressView()
                            }
                            .frame(width: geo.size.width, height: geo.size.height * 0.55)
                            HStack
                            {
                                Button{
                                    titleDetailPath.append(viewModel.heroTitle)
                                    
                                } label: {
                                    Text(Constants.playString)
                                        .ghostButton()
                                }
                                Button{
                                    
                                } label: {
                                    Text(Constants.downloadString)
                                        .ghostButton()
                                }
                            }
                            .padding(.bottom, 10)
                            HorizontalListView(header: Constants.trendingMoviesString, titles: viewModel.trendingMovies) {
                                title in titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.topRatedMoviesString, titles: viewModel.topRatedMovies) {
                                title in titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.trendingTVsString, titles: viewModel.trendingTVs) {
                                title in titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.topRatedTVsString, titles: viewModel.topRatedTVs) {
                                title in titleDetailPath.append(title)
                            }
                            
                        }
                    case .failed(_):
                        Text("Error:")
                    }
                }
                .task {
                    await viewModel.getTitles()
                }
                .navigationDestination(for: Title.self) { title in
                    TitleDetailView(title: title)
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
}
