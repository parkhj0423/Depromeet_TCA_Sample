//
//  EndPoint.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/16.
//

import Foundation

protocol Networkable: Requestable, Responsable {}

struct Endpoint<R>: Networkable {
    typealias Response = R
    
    var path: String
    var httpMethod: HTTPMethod
    var queryParameters: Encodable?
    var bodyParameters : Encodable?
    
    init(path: String, httpMethod: HTTPMethod, queryParameters: Encodable? = nil, bodyParameters : Encodable? = nil) {
        self.path = path
        self.httpMethod = httpMethod
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
    }
}
