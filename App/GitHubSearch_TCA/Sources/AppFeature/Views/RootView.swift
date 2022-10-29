//
//  RootView.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/08/13.
//

import ComposableArchitecture
import DataSource
import SwiftUI
import SearchFeature

public struct RootView: View {

    public init() {
    }

    public var body: some View {
        ListView(store: Store(
            initialState: .init(),
            reducer: listReducer,
            environment: SearchEnvironment(repositoryList: { _ in
                try await Task.sleep(nanoseconds: NSEC_PER_SEC)
                return [
                    GitHubRepositoryResponse(id: "1",
                                             name: "Swift",
                                             fullName: "maharjan binish",
                                             owner: .init(id: "1", login: "maharjan binish", avatarUrl: URL(string: "https://picsum.photos/80/80")!),
                                             htmlUrl: URL(string: "https:www.google.com")!,
                                             description: "description",
                                             language: "swift",
                                             stargazersCount: "1000"),
                    GitHubRepositoryResponse(id: "2",
                                             name: "Java",
                                             fullName: "kwon junhyeok",
                                             owner: .init(id: "2", login: "kwon junhyeok", avatarUrl: URL(string: "https://picsum.photos/80/80")!),
                                             htmlUrl: URL(string: "https:www.google.com")!,
                                             description: "description",
                                             language: "Java",
                                             stargazersCount: "1000"),
                    GitHubRepositoryResponse(id: "3",
                                             name: "kotlin",
                                             fullName: "maharjan binish",
                                             owner: .init(id: "3", login: "maharjan binish", avatarUrl: URL(string: "https://picsum.photos/80/80")!),
                                             htmlUrl: URL(string: "https:www.google.com")!,
                                             description: "description",
                                             language: "kotlin",
                                             stargazersCount: "1000"),
                ]
            }))
        )
    }
}
