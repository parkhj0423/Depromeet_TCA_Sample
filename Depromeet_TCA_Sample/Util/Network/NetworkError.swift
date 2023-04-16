//
//  NetworkError.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/16.
//

import Foundation

public enum NetworkError: Error, Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        return lhs.errorMessage == rhs.errorMessage
    }
    
    case decodingError
    case invalidURLError
    case noResponseError
    case serverError
    case badRequestError
    case internetConnectionError
    case unknownError
    
    var errorMessage: String {
        switch self {
        case .decodingError :
            return "Decoding Error"
        case .invalidURLError :
            return "Invalid URL"
        case .noResponseError :
            return "No Response"
        case .serverError :
            return "Server Error"
        case .badRequestError :
            return "Bad Request From Client"
        case .internetConnectionError :
            return "Internet Connection is unstable"
        case .unknownError :
            return "Unknown Error"
        }
    }
}
