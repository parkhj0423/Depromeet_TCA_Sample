//
//  RepoSearchItemStore.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/21.
//

import Foundation
import ComposableArchitecture

struct RepoSearchItemStore : ReducerProtocol {
    
    struct State : Equatable, Identifiable {
        let id : UUID = UUID()
        var repo : Repository
        var isStar : Bool = false
    }
    
    enum Action : Equatable {
        case tapStarButton
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .tapStarButton:
            state.isStar.toggle()
            return .none
        }
    }
    
}
