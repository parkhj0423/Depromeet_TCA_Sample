//
//  RepoSearchView.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/15.
//

import SwiftUI
import ComposableArchitecture

struct RepoSearchListView: View {
    
    let store : StoreOf<RepoSearchListStore>
    
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
    private func searchView(_ viewStore : ViewStoreOf<RepoSearchListStore>) -> some View {
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
    private func repoListView(_ viewStore : ViewStoreOf<RepoSearchListStore>) -> some View {
        if viewStore.isLoading {
            ProgressView()
        } else {
            ForEachStore(store.scope(state: \.repoList, action: RepoSearchListStore.Action.forEachRepos(id: action:))) { itemStore in
                RepoSearchItemView(store : itemStore)                
            }
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        RepoSearchListView(store: Store(initialState: RepoSearchListStore.State(), reducer: RepoSearchListStore()))
    }
}
