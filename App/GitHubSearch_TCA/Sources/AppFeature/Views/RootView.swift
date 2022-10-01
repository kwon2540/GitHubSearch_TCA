//
//  RootView.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/08/13.
//

import ComposableArchitecture
import SwiftUI
import SearchFeature

public struct RootView: View {

    public init() {
    }

    public var body: some View {
        ListView(store: Store(initialState: .init(), reducer: listReducer, environment: SearchEnvironment()))
    }
}

struct RootView_Previews: PreviewProvider {

    static var previews: some View {
        ListView(store: Store(initialState: .init(), reducer: listReducer, environment: SearchEnvironment()))
    }
}
