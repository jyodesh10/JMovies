//
//  DataFetcher.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 16.06.26.
//

import Foundation

struct DataFetcher{
    
    let baseUrl = APIConfig.shared?.baseUrl
    let apiKey = APIConfig.shared?.apiKey
    let youtubeSearchUrl = APIConfig.shared?.youtubeSearchUrl
    let youtubeApiKey = APIConfig.shared?.youtubeApiKey
    
    func fetchTitles(for media: String, by type:String) async throws -> [Title] {
        let fetchTitlesUrl = try buildURL(media: media, type: type)
        
        guard let fetchTitlesUrl = fetchTitlesUrl else {
            throw NetworkError.urlBuildFailed
        }

        print(fetchTitlesUrl)
        
        var titles = try await fetchAndDecode(url: fetchTitlesUrl, type: TMDBAPIObject.self).results
        
        Constants.addPosterPath(to: &titles )
        return titles
    }
    
    
    
    func fetchVideoID(for title:String) async throws -> String {
        guard let baseSearchUrl = youtubeSearchUrl else {
            throw NetworkError.missingConfig
        }
        guard let baseApiKey = youtubeApiKey else {
            throw NetworkError.missingConfig
        }
        
        let trailerSearch = title + YoutubeUrlStrings.space.rawValue + YoutubeUrlStrings.trailer.rawValue
        
        guard let fetchUrl = URL(string: baseSearchUrl)?
            .appending(queryItems: [
                URLQueryItem(name: YoutubeUrlStrings.query.rawValue, value: trailerSearch),
                URLQueryItem(name: YoutubeUrlStrings.key.rawValue, value: baseApiKey)
            ]) else {
            throw NetworkError.urlBuildFailed
            }
                
        print(fetchUrl)
        
        return try await fetchAndDecode(url: fetchUrl, type: YoutubeSearchResponse.self).items?.first?.id?.videoId ?? ""
        
    }
    
    func fetchAndDecode<T: Decodable>(url: URL, type: T.Type) async throws -> T {
        
        let(data, urlResponse) = try await URLSession.shared.data(from: url)
        
        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badUrlResponse(underlyingError: NSError(
                domain: "DataFetcher",
                code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP Response"]))
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(type, from: data)
    }
    
    private func buildURL (media:String, type:String) throws -> URL? {
        guard let baseUrl = baseUrl else {
            throw NetworkError.missingConfig
        }
        guard let apiKey = apiKey else {
            throw NetworkError.missingConfig
        }
        
        var path:String
        
        if type == "trending" {
            path = "3/trending/\(media)/day"
        } else if type == "top_rated" {
            path = "3/\(media)/top_rated"
        } else {
            throw NetworkError.urlBuildFailed
        }
        
        guard let url = URL(string: baseUrl)?
            .appending(path: path)
            .appending(queryItems: [
                URLQueryItem(name: "api_key", value: apiKey)
            ]) else {
            throw NetworkError.urlBuildFailed
        }
        
        return url
    }
}
