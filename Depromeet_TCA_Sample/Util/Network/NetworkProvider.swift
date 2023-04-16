//
//  NetworkProvider.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/16.
//

import Foundation

protocol NetworkProviderInterface {
    func sendRequest<N: Networkable, T: Decodable>(_ endpoint: N) async throws -> T where N.Response == T
}

final class NetworkProvider : NetworkProviderInterface {
    static let shared = NetworkProvider()
    
    public func sendRequest<N: Networkable, T: Decodable>(_ endpoint: N) async throws -> T where N.Response == T {
        do {
            let urlRequest: URLRequest = try endpoint.makeURLRequest()
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest, delegate: nil)
            
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.noResponseError
            }
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                    throw NetworkError.decodingError
                }
                return decodedResponse
            case 400...499:
                throw NetworkError.badRequestError
            case 500...599 :
                throw NetworkError.serverError
            default:
                throw NetworkError.unknownError
            }
            
        } catch URLError.Code.notConnectedToInternet {
            throw NetworkError.internetConnectionError
        } 
    }
    
}
