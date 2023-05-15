//
//  RepoSearchStore.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/15.
//

import Foundation
import ComposableArchitecture

struct RepoSearchListStore : ReducerProtocol {
    @Dependency(\.repoSearchClient) var repoSearchClient
    
    struct State : Equatable {
        @BindingState var keyword = ""
        var repoList : IdentifiedArrayOf<RepoSearchItemStore.State> = []
        var isLoading : Bool = false
    }
    
    enum Action : BindableAction, Equatable {
        case binding(BindingAction<State>)
        case keywordChanged(String)
        case searchByKeyword
        case searchByKeywordResponse(TaskResult<IdentifiedArrayOf<RepoSearchItemStore.State>>)
        case forEachRepos(id : RepoSearchItemStore.State.ID, action : RepoSearchItemStore.Action)
    }
    
    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case let .keywordChanged(keyword):
                state.keyword = keyword
                
                return .none
            case .searchByKeyword:
                state.isLoading = true
                
                return .task { [keyword = state.keyword] in
                    await .searchByKeywordResponse(
                        TaskResult {
                            try await repoSearchClient.getSearchedRepos(keyword)
                        }
                    )
                }
                
            case let .searchByKeywordResponse(.success(response)) :
                state.isLoading = false
                state.repoList = response
                return .none
                
            case .searchByKeywordResponse(.failure):
                state.isLoading = false
                return .none
            case .forEachRepos(id: let id, action: .tapStarButton) :
                guard let index = state.repoList.firstIndex(where: { $0.id == id }) else {
                    return .none
                }
                
                state.repoList[index].isStar.toggle()
                
                return .none
            }
        }
        .forEach(\.repoList, action: /Action.forEachRepos(id: action:)) {
            RepoSearchItemStore()
        }
    }
    
    
}
