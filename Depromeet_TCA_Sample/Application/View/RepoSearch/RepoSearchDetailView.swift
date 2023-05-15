//
//  RepoSearchDetailView.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/22.
//

import SwiftUI

struct RepoSearchDetailView: View {
    
    var repo : Repository
    
    var body: some View {
        VStack {
            Text("\(repo.id)")
            Text(repo.name)
            Text(repo.description)
            Text("\(repo.starCount)")
        }
        
    }
}
