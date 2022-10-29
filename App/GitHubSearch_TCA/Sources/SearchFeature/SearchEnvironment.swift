//
//  SearchEnvironment.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/01.
//

import DataSource
import Foundation

public struct SearchEnvironment {

    public init(repositoryList: @escaping (String) async throws -> [GitHubRepositoryResponse]) {
        self.repositoryList = repositoryList
    }

    var repositoryList: (_ keyword: String) async throws -> [GitHubRepositoryResponse]
}
