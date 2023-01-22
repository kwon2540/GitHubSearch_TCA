//
//  SearchEnvironment.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/01.
//

import ComposableArchitecture
import Core
import DataSource
import Foundation
import KeychainAccess

public struct SearchEnvironment {

    public init(repositoryList: @escaping (String) async throws -> ResponseValues.GitHubRepositoryResponse) {
        self.repositoryList = repositoryList
    }

    var repositoryList: (_ keyword: String) async throws -> ResponseValues.GitHubRepositoryResponse
}

#if DEBUG
import XCTestDynamicOverlay

public extension SearchEnvironment {
    static let unimplemented = Self(
        repositoryList: XCTUnimplemented()
    )
}
#endif
