//
//  ContentView.swift
//  Depromeet_TCA_Sample
//
//  Created by 박현우 on 2023/04/15.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
