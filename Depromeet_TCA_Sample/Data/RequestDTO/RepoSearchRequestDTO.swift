//
//  RepoSearchRequestDTO.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/16.
//

import Foundation

struct RepoSearchRequestDTO: Encodable, Decodable {
  let searchText: String

  enum CodingKeys: String, CodingKey {
    case searchText = "q"
  }
}
