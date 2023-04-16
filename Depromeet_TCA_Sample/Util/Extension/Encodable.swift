//
//  Encodable.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/16.
//

import Foundation

extension Encodable {
    func toDictionary() throws -> [String : Any] {
        let data = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: data)
        return jsonObject as! [String : Any]
    }
}
