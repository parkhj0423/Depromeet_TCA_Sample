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
    var queryParameter: Encodable
    
    init(path: String, httpMethod: HTTPMethod, queryParameter: Encodable) {
        self.path = path
        self.httpMethod = httpMethod
        self.queryParameter = queryParameter
    }
}
