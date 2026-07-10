//
//  VerticalListView.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 29.06.26.
//

import SwiftUI
import SwiftData

struct VerticalListView: View {
    var titles : [Title]
    var canDelete : Bool
    @Environment(\.modelContext) var modelContext
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            GeometryReader {
                geometry in
                List(titles) { title in
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
                    .onTapGesture {
                        navigationPath.append(title)
                    }
                    .swipeActions(edge: .trailing) {
                        Button{
                            if(canDelete) {
                                modelContext.delete(title)
                                try? modelContext.save()
                            }
                        } label: {
                            Image(systemName: "trash")
                                .tint(.red)
                        }
                    }
                    
                }
            }
        }
        .navigationDestination(for: Title.self) {
            title in
            TitleDetailView(title: title)
        }
    }
}

#Preview {
    VerticalListView(titles: Title.previewTitles, canDelete: false)
}
