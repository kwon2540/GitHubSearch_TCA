//
//  SearchFeature.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/01.
//

import ComposableArchitecture
import Foundation

public struct ListState: Equatable {
    public init() {}
    var keyword = ""
    var repositoryList: [GitHubRepositoryModel] = []
    var isLoading = false
}

public enum ListAction: Equatable {
    case keywordChanged(String)
    case fetchRepositoryList
    case repositoryListResponse(TaskResult<[GitHubRepositoryModel]>)
}

public let listReducer = Reducer<ListState, ListAction, SearchEnvironment> { state, action, environment in
    switch action {
    case .keywordChanged(let keyword):
        state.keyword = keyword
        return .init(value: .fetchRepositoryList)
            .delay(for: 1, scheduler: DispatchQueue.main)
            .eraseToEffect()
    case .fetchRepositoryList:
        return .task { [state] in
            await .repositoryListResponse(
                TaskResult {
                    try await environment.repositoryList(state.keyword)
                }
            )
        }
    case .repositoryListResponse(.success(let response)):
        state.repositoryList = response
    case .repositoryListResponse(.failure):
        // TODO: Error Handling
        break
    }
    return .none
}
