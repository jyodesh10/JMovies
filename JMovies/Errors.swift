//
//  Errors.swift
//  JMovies
//
//  Created by Jyodesh Shakya on 16.06.26.
//

import Foundation


enum APIConfigError: Error, LocalizedError {
    case fileNotFound
    case dataLoadinfFailed(underlyingError: Error)
    case decodingFailed(underlyingError: Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "API configuration file not loaded"
        case .dataLoadinfFailed(underlyingError: let error):
            return "Failed to load API configuration data: \(error.localizedDescription)"
        case .decodingFailed(underlyingError: let error):
            return "Failed to decode API configuration: \(error.localizedDescription)"
        }
    }
}

enum NetworkError: Error, LocalizedError {
    case badUrlResponse(underlyingError: Error)
    case missingConfig
    case urlBuildFailed
    
    var errorDescription: String? {
        switch self {
        case .badUrlResponse(underlyingError: let error):
            return "Failed to get URL response: \(error.localizedDescription)"
        case .missingConfig:
            return "API configuration is missing"
        case .urlBuildFailed:
            return "Failed to build url."
        }
    }
}
