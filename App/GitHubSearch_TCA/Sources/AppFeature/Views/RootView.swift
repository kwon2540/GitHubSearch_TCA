//
//  RootView.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/08/13.
//

import ComposableArchitecture
import Core
import DataSource
import SwiftUI
import SearchFeature

public struct RootView: View {

    public init(store: Store<AppState, AppAction>) {
        self.store = store
    }

    let store: Store<AppState, AppAction>

    public var body: some View {
        ListView(store: store.scope(state: \.listState, action: AppAction.listAction))
    }
}
