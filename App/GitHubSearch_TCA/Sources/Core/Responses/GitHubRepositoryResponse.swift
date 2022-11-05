//
//  GitHubRepositoryModel.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/01.
//

import Foundation

extension ResponseValues {

    public struct GitHubRepositoryResponse: Codable, Hashable {

        public let items: [GitHubRepository]
    }
}

extension ResponseValues.GitHubRepositoryResponse {

    public struct GitHubRepository: Codable, Hashable {

        public let name: String
        public let fullName: String
        public let owner: Owner
        public let htmlUrl: URL
        public let description: String?
        public let language: String?
        public let stargazersCount: Int

        public init(name: String, fullName: String, owner: Owner, htmlUrl: URL, description: String?, language: String?, stargazersCount: Int) {
            self.name = name
            self.fullName = fullName
            self.owner = owner
            self.htmlUrl = htmlUrl
            self.description = description
            self.language = language
            self.stargazersCount = stargazersCount
        }

        public struct Owner: Codable, Hashable {

            public let login: String
            public let avatarUrl: URL

            public init(login: String, avatarUrl: URL) {
                self.login = login
                self.avatarUrl = avatarUrl
            }
        }
    }
}
