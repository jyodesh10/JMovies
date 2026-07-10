//
//  UpcomingView.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 29.06.26.
//

import SwiftUI

struct UpcomingView: View {
    var viewModel = ViewModel()

    var body: some View {
        NavigationStack{
            GeometryReader { geo in
                switch viewModel.upcomingStatus {
                case .fetching:
                    ProgressView()
                        .frame(width: geo.size.width, height: geo.size.height)
                case .notStarted:
                    EmptyView()
                case .success:
                    VerticalListView(titles: viewModel.upcomingMovies, canDelete: false)
                case .failed(underlyingError: let error):
                    Text(error.localizedDescription)
                        .errorMessage()
                        .frame(width : geo.size.width, height: geo.size.height)
                }
            }
            .task {
                await viewModel.getUpcoming()
            }
        }
    }
}

#Preview {
    UpcomingView()
}
