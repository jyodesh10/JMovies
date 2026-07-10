//
//  Title.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 16.06.26.
//

import SwiftData

struct TMDBAPIObject : Decodable {
    var results: [Title] = []
}

@Model
class Title : Decodable, Identifiable, Hashable{
    @Attribute(.unique) var id: Int?
    var title: String?
    var name: String?
    var overview: String?
    var posterPath: String?
    
    init(id: Int? = nil, title: String? = nil, name: String? = nil, overview: String? = nil, posterPath: String? = nil) {
        self.id = id
        self.title = title
        self.name = name
        self.overview = overview
        self.posterPath = posterPath
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, name, overview, posterPath
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try? container.decodeIfPresent(String.self, forKey: .title)
        name = try? container.decodeIfPresent(String.self, forKey: .name)
        overview = try? container.decodeIfPresent(String.self, forKey: .overview)
        posterPath = try? container.decodeIfPresent(String.self, forKey: .posterPath)
    }
    
    static var previewTitles = [
        Title(id: 1,title: "The Shawshank Redemption", name: "The Shawshank Redemption",overview: "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.", posterPath: Constants.testTitleUrl),
        
        Title(id: 2, title: "The Batman", name: "The Batman",overview: "Two imprisoned men bond over a number of years, fnding solace and eventual redemption through acts of common decency.", posterPath: Constants.testTitleUrl2),
        
        Title(id: 3, title: "Revenant", name: "Revenant",overview: "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.", posterPath: Constants.testTitleUrl3),
    ]
}
