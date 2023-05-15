//
//  RepoSearchAPIEndPoint.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/16.
//

import Foundation

struct EmptyData : Decodable {
    
    
}

struct RepoSearchAPIEndPoint {
    static func repoSearch(_ requestDTO: RepoSearchRequestDTO) -> Endpoint<RepoSearchResponseDTO> {
        return Endpoint(path: "search/repositories", httpMethod: .get, queryParameters: requestDTO)
    }
}
