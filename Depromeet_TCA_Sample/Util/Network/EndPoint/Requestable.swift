//
//  Requestable.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/16.
//

import Foundation

public enum HTTPMethod : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Requestable {
    var path: String { get }
    var httpMethod : HTTPMethod { get}
    var queryParameter: Encodable { get }
}

extension Requestable {
    func makeURLRequest() throws -> URLRequest {
        
        guard let baseURL = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            throw NetworkError.invalidURLError
        }
        
        guard var urlComponent = URLComponents(string: baseURL + path) else {
            throw NetworkError.invalidURLError
        }
        
        guard let queryDictionary = try? queryParameter.toDictionary() else {
            throw NetworkError.invalidURLError
        }
        
        var queryItemList : [URLQueryItem] = []
        
        queryDictionary.forEach { (key, value) in
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            queryItemList.append(queryItem)
        }
        
        if !queryItemList.isEmpty {
            urlComponent.queryItems = queryItemList
        }
        
        guard let url = urlComponent.url else {
            throw NetworkError.invalidURLError
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpMethod = httpMethod.rawValue
        
        return urlRequest
    }
}
