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

extension StoreOf<AppReducer> {
    convenience init(primitiveEnvironment: PrimitiveEnvironment) {
        let keychain = Keychain()
        let userDefaults = UserDefaults.standard
        let apiClient = APIClient(baseURL: primitiveEnvironment.apiBaseURL)
        
        let appEnvironment = AppEnvironment(
            searchEnvironment: .live(apiClient: apiClient, keychain: keychain, userDefaults: userDefaults)
        )
        self.init(initialState: AppReducer.State(), reducer: AppReducer(appEnvironment: appEnvironment))
    }
}
