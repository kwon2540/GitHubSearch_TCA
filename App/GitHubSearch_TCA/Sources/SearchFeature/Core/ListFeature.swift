//
//  ListFeature.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/01.
//

import Core
import ComposableArchitecture
import DataSource
import Foundation

public struct ListState: Equatable {
    public init() {}
    var keyword = ""
    var repositoryList: [ResponseValues.GitHubRepositoryResponse.GitHubRepository] = []
    var isLoading = false

    var alertState: AlertState<ListAction.AlertAction>?
}

public enum ListAction: Equatable {
    case keywordChanged(String)
    case fetchRepositoryList
    case repositoryListResponse(TaskResult<ResponseValues.GitHubRepositoryResponse>)

    case alertAction(AlertAction)

    public enum AlertAction: Equatable {
        case onDismiss
    }
}

public let listReducer = Reducer<ListState, ListAction, SearchEnvironment> { state, action, environment in
    enum FetchId {}
    switch action {
    case .keywordChanged(let keyword):
        state.keyword = keyword

        return .init(value: .fetchRepositoryList)
            .delay(for: 1, scheduler: DispatchQueue.main)
            .eraseToEffect()
            .cancellable(id: FetchId.self, cancelInFlight: true)

    case .fetchRepositoryList:
        return .task { [state] in
            await .repositoryListResponse(
                TaskResult {
                    try await environment.repositoryList(state.keyword)
                }
            )
        }

    case .repositoryListResponse(.success(let response)):
        state.repositoryList = response.items

    case .repositoryListResponse(.failure(let error)):
        state.alertState = AlertState(title: TextState(error.localizedDescription))

    case .alertAction(.onDismiss):
        state.alertState = nil
    }
    return .none
}
