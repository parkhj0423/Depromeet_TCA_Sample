//
//  RepoSearchClient.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/16.
//

import Foundation
import ComposableArchitecture

struct RepoSearchClient  {
    var getSearchedRepos: @Sendable (String) async throws -> [Repository]
}

extension RepoSearchClient: DependencyKey {
    static let liveValue = Self(
        getSearchedRepos: { searchText in
            let repoSearchRequestDTO = RepoSearchRequestDTO(searchText: searchText)
            let apiEndPoint = RepoSearchAPIEndPoint.repoSearch(repoSearchRequestDTO)
            
            let response = try await NetworkProvider.shared.sendRequest(apiEndPoint).toDomain()
            
            return response
        }
    )
    
    static let testValue = Self(
        getSearchedRepos: unimplemented("\(Self.self) testValue of search")
    )
}

extension DependencyValues {
    var repoSearchClient: RepoSearchClient {
        get { self[RepoSearchClient.self] }
        set { self[RepoSearchClient.self] = newValue }
    }
}
