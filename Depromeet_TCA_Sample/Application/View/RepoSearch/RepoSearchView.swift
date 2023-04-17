//
//  RepoSearchView.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/15.
//

import SwiftUI
import ComposableArchitecture

struct RepoSearchView: View {
    
    let store : StoreOf<RepoSearchStore>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                ScrollView(showsIndicators: false){
                    VStack {
                        searchView(viewStore)
                        
                        repoListView(viewStore)
                        
                        Spacer()
                    }
                }
                .padding()
                .navigationTitle("Repo Search")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    //MARK: Searchable 안쓰고 SearchBar 직접 구현했을때
    private func searchView(_ viewStore : ViewStoreOf<RepoSearchStore>) -> some View {
        HStack {
            TextField(text: viewStore.binding(\.$keyword)) {
                Text("Type Keyword to find repos!!")
                    .font(.caption)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button {
                viewStore.send(.searchByKeyword)
            } label: {
                Text("Search")
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    @ViewBuilder
    private func repoListView(_ viewStore : ViewStoreOf<RepoSearchStore>) -> some View {
        if viewStore.isLoading {
            ProgressView()
        } else {
            ForEach(viewStore.repoList) { repo in
                VStack(alignment : .leading, spacing: 20) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(repo.name)
                                .foregroundColor(.blue)
                                .font(.title.bold())
                            Text(repo.description)
                        }
                        
                        Spacer()
                        
                        Text("★ \(repo.starCount) ★")
                    }
                }
                .foregroundColor(.white)
            
                Divider()
            }
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        RepoSearchView(store: Store(initialState: RepoSearchStore.State(), reducer: RepoSearchStore()))
    }
}
