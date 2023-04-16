//
//  Repository.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/16.
//

import Foundation

struct Repository: Equatable, Identifiable{
    var id = UUID()
    var name: String
    var description: String
    var starCount: Int
    
}
