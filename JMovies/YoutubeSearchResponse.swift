//
//  YoutubeSearchResponse.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 28.06.26.
//

import Foundation


struct YoutubeSearchResponse: Codable {
    let items: [ItemProperties]?
}


struct ItemProperties: Codable {
    let id: IdProperties?
}

struct IdProperties: Codable {
    let videoId: String?
}
