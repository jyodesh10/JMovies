//
//  TitleDetailView.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 22.06.26.
//

import SwiftUI

struct TitleDetailView: View {
    let title: Title
    var titlename: String {
        return (title.name ?? title.title) ?? ""}
    let viewModel = ViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            switch viewModel.videoStatus {
            case .notStarted:
                EmptyView()
            case .fetching:
                ProgressView().frame(
                    width: geometry.size.width,
                    height: geometry.size.height
                )
            case .success:
                ScrollView{
                    LazyVStack(alignment: .leading) {
                        YoutubePlayer(videoID: viewModel.videoId)
                            .aspectRatio(1.3, contentMode: .fit)
                        
                        Text(titlename)
                            .bold()
                            .font(.title2)
                            .padding(5)
                            .padding(.top, 0)
                        
                        Text(title.overview ?? "")
                            .padding(5)
                    }
                }
            case .failed(let underlyingError):
                Text(underlyingError.localizedDescription)
            }
        }
        .task {
            await viewModel.getVideoId(for: titlename)
        }
    }
}

#Preview {
    TitleDetailView(title: Title.previewTitles[0] )
}
