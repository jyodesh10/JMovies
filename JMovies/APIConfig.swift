//
//  APIJson.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 16.06.26.
//

import Foundation



struct APIConfig: Decodable {
    let baseUrl: String
    let apiKey: String
    let youtubeBaseUrl: String
    let youtubeApiKey: String
    let youtubeSearchUrl: String
    
    static let shared: APIConfig? = {
        do {
            return try loadConfig()
        } catch {
            print("APIConfig failed \(error.localizedDescription)")
            return nil
        }
    } ()
    
    private static func loadConfig () throws -> APIConfig {
        guard let url = Bundle.main.url(forResource: "APIConfig", withExtension: "json") else {
            throw APIConfigError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(APIConfig.self, from: data)
        } catch let error as DecodingError {
            throw APIConfigError.decodingFailed(underlyingError: error)
        } catch {
            throw APIConfigError.dataLoadinfFailed(underlyingError: error)
        }
    }
}

