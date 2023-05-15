//
//  Depromeet_TCA_SampleApp.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/15.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators
@main
struct Depromeet_TCA_SampleApp: App {
    var body: some Scene {
        WindowGroup {
            RepoSearchListView(store: Store(
                initialState: RepoSearchListStore.State(),
                reducer: RepoSearchListStore())
            )
        }
    }
}
