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

    public init(store: StoreOf<AppReducer>) {
        self.store = store
    }

    let store: StoreOf<AppReducer>

    public var body: some View {
        ListView(store: store.scope(state: \.listState, action: AppReducer.Action.listAction))
    }
}
