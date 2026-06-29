//
//  Title.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 16.06.26.
//

import Foundation

struct TMDBAPIObject : Decodable {
    var results: [Title] = []
}
struct Title : Decodable, Identifiable, Hashable{
    var id: Int?
    var title: String?
    var name: String?
    var overview: String?
    var posterPath: String?
    
    static var previewTitles = [
        Title(id: 1,title: "The Shawshank Redemption", name: "The Shawshank Redemption",overview: "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.", posterPath: Constants.testTitleUrl),
        
        Title(id: 2, title: "The Batman", name: "The Batman",overview: "Two imprisoned men bond over a number of years, fnding solace and eventual redemption through acts of common decency.", posterPath: Constants.testTitleUrl2),
        
        Title(id: 3, title: "Revenant", name: "Revenant",overview: "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.", posterPath: Constants.testTitleUrl3),
    ]
}
