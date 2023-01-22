//
//  SearchEnvironment+Live.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/29.
//

import DataSource
import Foundation
import KeychainAccess
import SearchFeature
import ComposableArchitecture

extension SearchEnvironment {
    static func live(apiClient: APIClient, keychain: Keychain, userDefaults: UserDefaults) -> Self {
        Self(
            repositoryList: { keyword in
                try await apiClient.send(GithubRepositoryRequest(keyword: keyword)).result.get()
            }
        )
    }
}
