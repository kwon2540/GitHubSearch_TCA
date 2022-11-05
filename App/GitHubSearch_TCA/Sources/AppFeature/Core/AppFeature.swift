//
//  AppFeature.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/29.
//

import ComposableArchitecture
import Foundation
import SearchFeature

public struct AppState: Equatable {

    public init() {}

    var listState = ListState()
}

public enum AppAction: Equatable {
    case listAction(ListAction)
}

public let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    listReducer
        .pullback(state: \.listState, action: /AppAction.listAction, environment: \.searchEnvironment),
    Reducer { state, action, environment in
        switch action {
        case .listAction:
            break
        }

        return .none
    }
)
