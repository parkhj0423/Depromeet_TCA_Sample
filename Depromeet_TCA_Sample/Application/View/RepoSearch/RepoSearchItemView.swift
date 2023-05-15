//
//  RepoSearchItemView.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/21.
//

import SwiftUI
import ComposableArchitecture

struct RepoSearchItemView: View {
    let store : StoreOf<RepoSearchItemStore>
    
    var body: some View {
        WithViewStore(store) { store in
            NavigationLink {
                RepoSearchDetailView(repo: store.repo)
            } label: {
                VStack(alignment : .leading, spacing: 20) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(store.repo.name)
                                .foregroundColor(.blue)
                                .font(.title.bold())
                            Text(store.repo.description)
                                .foregroundColor(.black)
                                
                        }
                        
                        Spacer()
                        
                        Text("★ \(store.repo.starCount) ★")
                    }
                    .multilineTextAlignment(.leading)
                }
            }
        
            Divider()
        }
    }
}
