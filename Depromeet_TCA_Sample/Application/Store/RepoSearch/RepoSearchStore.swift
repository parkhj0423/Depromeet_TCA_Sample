//
//  RepoSearchStore.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/15.
//

import Foundation
import ComposableArchitecture

struct RepoSearchStore : ReducerProtocol {
    @Dependency(\.repoSearchClient) var repoSearchClient
    
    struct State : Equatable {
        @BindingState var keyword = ""
        var repoList : [Repository] = []
        var isLoading : Bool = false
    }
    
    enum Action : BindableAction, Equatable {
        case binding(BindingAction<State>)
        case keywordChanged(String)
        case searchByKeyword
        case searchByKeywordResponse(TaskResult<[Repository]>)
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
                
            case let .searchByKeywordResponse(.failure(error)):
                print(error.localizedDescription)
                state.isLoading = false
                return .none
            }
        }
    }
    
    
}
