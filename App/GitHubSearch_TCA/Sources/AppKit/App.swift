//
//  App.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/08/13.
//

import ComposableArchitecture
import SwiftUI
import AppFeature

public final class AppDelegate: NSObject, UIApplicationDelegate {
    private var store: Store<AppState, AppAction>?
    func store(for primitiveEnvironment: PrimitiveEnvironment) -> Store<AppState, AppAction> {
        if let store = store {
            return store
        }
        let store = Store(primitiveEnvironment: primitiveEnvironment)
        self.store = store
        return store
    }
}

public protocol App: SwiftUI.App {
    var primitiveEnvironment: PrimitiveEnvironment { get }
    var appDelegate: AppDelegate { get }
}

extension App {
    public var body: some Scene {
        WindowGroup {
            RootView(store: appDelegate.store(for: primitiveEnvironment))
        }
    }
}
