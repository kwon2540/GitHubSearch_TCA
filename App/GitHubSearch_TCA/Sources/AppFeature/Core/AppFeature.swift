//
//  AppFeature.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/29.
//

import ComposableArchitecture
import Foundation
import SearchFeature

public struct AppReducer: ReducerProtocol {
    public struct State {
        var listState = ListReducer.State()
        
        public init() {}
    }
    
    public enum Action {
        case listAction(ListReducer.Action)
    }
    
    var appEnvironment: AppEnvironment
    
    public init(appEnvironment: AppEnvironment) {
        self.appEnvironment = appEnvironment
    }
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .listAction:
                return .none
            }
        }
        
        Scope(state: \.listState, action: /Action.listAction) {
            ListReducer(environment: appEnvironment.searchEnvironment)
        }
    }
}
