//
//  SearchEnvironment.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/01.
//

import Foundation

public struct SearchEnvironment {
    public init() {}

    var repositoryList: (_ keyword: String) async throws -> [GitHubRepositoryModel] = { _ in
        try await Task.sleep(nanoseconds: NSEC_PER_SEC)
        return GitHubRepositoryModel.dummy
    }
}
