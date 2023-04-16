//
//  RepoSearchResponseDTO.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/16.
//

import Foundation

struct RepoSearchResponseDTO: Decodable {
    let totalCount: Int
    let repositoryDTOList: [RepositoryDTO]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case repositoryDTOList = "items"
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.totalCount = (try? value.decode(Int.self, forKey: .totalCount)) ?? 0
        self.repositoryDTOList = (try? value.decode([RepositoryDTO].self, forKey: .repositoryDTOList)) ?? []
    }
    
    func toDomain() -> [Repository] {
        var repoList : [Repository] = []
        self.repositoryDTOList.forEach { repo in
            repoList.append(
                Repository(name: repo.name, description: repo.description, starCount: repo.starCount)
            )
        }
        return repoList
    }
}

struct RepositoryDTO: Decodable {
    let name: String
    let description: String
    let starCount: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case starCount = "stargazers_count"
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.name = (try? value.decode(String.self, forKey: .name)) ?? ""
        self.description = (try? value.decode(String.self, forKey: .description)) ?? ""
        self.starCount = (try? value.decode(Int.self, forKey: .starCount)) ?? 0
    }
}
