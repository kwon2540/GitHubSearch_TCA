//
//  Store+PrimitiveEnvironment.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/29.
//

import AppFeature
import ComposableArchitecture
import Core
import DataSource
import Foundation
import KeychainAccess

extension Store<AppState, AppAction> {
    convenience init(primitiveEnvironment: PrimitiveEnvironment) {
        let keychain = Keychain()
        let userDefaults = UserDefaults.standard
        let apiClient = APIClient(baseURL: primitiveEnvironment.apiBaseURL)

        self.init(
            initialState: .init(),
            reducer: appReducer,
            environment: .init(
                searchEnvironment: .live(apiClient: apiClient, keychain: keychain, userDefaults: userDefaults)
            )
        )
    }
}
