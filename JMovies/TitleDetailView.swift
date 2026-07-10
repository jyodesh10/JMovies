//
//  TitleDetailView.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 22.06.26.
//

import SwiftUI
import SwiftData
struct TitleDetailView: View {
    @Environment(\.dismiss) var dismiss
    let title: Title
    var titlename: String {
        return (title.name ?? title.title) ?? ""}
    let viewModel = ViewModel()
    @Environment(\.modelContext) var modelContext

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
                        HStack{
                            Spacer()
                            Button{
                                let savetitle = title
                                savetitle.title = titlename
                                
                                modelContext.insert(savetitle)
                                try? modelContext.save()
                                dismiss()
                            } label: {
                                Text(Constants.downloadString)
                                    .ghostButton()
                            }
                            Spacer()
                        }
                        
                    }
                }
            case .failed(let underlyingError):
                Text(underlyingError.localizedDescription)
                    .errorMessage()
                    .frame(width : geometry.size.width, height: geometry.size.height)
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
