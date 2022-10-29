//
//  GitHubRepositoryModel.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/01.
//

import Foundation

extension ResponseValues {
    
    public struct GitHubRepositoryResponse: Codable, Identifiable {

        public let id: String
        public let name: String
        public let fullName: String
        public let owner: Owner
        public let htmlUrl: URL
        public let description: String?
        public let language: String?
        public let stargazersCount: String

        public init(id: String, name: String, fullName: String, owner: Owner, htmlUrl: URL, description: String?, language: String?, stargazersCount: String) {
            self.id = id
            self.name = name
            self.fullName = fullName
            self.owner = owner
            self.htmlUrl = htmlUrl
            self.description = description
            self.language = language
            self.stargazersCount = stargazersCount
        }

        public struct Owner: Codable {

            public let id: String
            public let login: String
            public let avatarUrl: URL

            public init(id: String, login: String, avatarUrl: URL) {
                self.id = id
                self.login = login
                self.avatarUrl = avatarUrl
            }
        }
    }
}

extension ResponseValues.GitHubRepositoryResponse: Equatable {

    public static func == (lhs: ResponseValues.GitHubRepositoryResponse, rhs: ResponseValues.GitHubRepositoryResponse) -> Bool {
        lhs.id == rhs.id
    }
}
