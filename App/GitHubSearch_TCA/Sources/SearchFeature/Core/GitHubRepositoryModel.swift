//
//  GitHubRepositoryModel.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/01.
//

import Foundation

public struct GitHubRepositoryModel: Decodable, Identifiable {

    public let id: String
    let name: String
    let fullName: String
    let owner: GitHubRepositoryOwnerModel
    let htmlUrl: URL
    let description: String?
    let language: String?
    let stargazersCount: String

    public init(id: String, name: String, fullName: String, owner: GitHubRepositoryOwnerModel, htmlUrl: URL, description: String?, language: String?, stargazersCount: String) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.owner = owner
        self.htmlUrl = htmlUrl
        self.description = description
        self.language = language
        self.stargazersCount = stargazersCount
    }

    static let dummy = [
        GitHubRepositoryModel(id: "1",
                              name: "Swift",
                              fullName: "maharjan binish",
                              owner: GitHubRepositoryOwnerModel(id: "1", login: "maharjan binish", avatarUrl: URL(string: "https://picsum.photos/80/80")!),
                              htmlUrl: URL(string: "https:www.google.com")!,
                              description: "description",
                              language: "swift",
                              stargazersCount: "1000"),
        GitHubRepositoryModel(id: "2",
                              name: "Java",
                              fullName: "kwon junhyeok",
                              owner: GitHubRepositoryOwnerModel(id: "2", login: "kwon junhyeok", avatarUrl: URL(string: "https://picsum.photos/80/80")!),
                              htmlUrl: URL(string: "https:www.google.com")!,
                              description: "description",
                              language: "Java",
                              stargazersCount: "1000"),
        GitHubRepositoryModel(id: "3",
                              name: "kotlin",
                              fullName: "maharjan binish",
                              owner: GitHubRepositoryOwnerModel(id: "3", login: "maharjan binish", avatarUrl: URL(string: "https://picsum.photos/80/80")!),
                              htmlUrl: URL(string: "https:www.google.com")!,
                              description: "description",
                              language: "kotlin",
                              stargazersCount: "1000"),

    ]
}

extension GitHubRepositoryModel: Equatable {
    public static func == (lhs: GitHubRepositoryModel, rhs: GitHubRepositoryModel) -> Bool {
        lhs.id == rhs.id
    }
}

public struct GitHubRepositoryOwnerModel: Decodable {

    let id: String
    let login: String
    let avatarUrl: URL
    
    public init(id: String, login: String, avatarUrl: URL) {
        self.id = id
        self.login = login
        self.avatarUrl = avatarUrl
    }
}
