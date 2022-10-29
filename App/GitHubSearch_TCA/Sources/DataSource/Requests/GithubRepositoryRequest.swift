//
//  GithubRepositoryRequest.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/01.
//

import Core
import Foundation

public struct GithubRepositoryRequest {

    public typealias Success = ResponseValues.GitHubRepositoryResponse

    public init(keyword: String) {
        self.keyword = keyword
    }

    public var keyword: String
    public var method: HTTPMethod { .get }
    public var path: String { "/search/repositories" }
    public var queries: [String : String] {
        [
            "sort": "stars",
            "order": "desc",
            "q": keyword,
        ]
        .compactMapValues { $0 }
    }
}

/// Post sample
public struct PostSample: Request, Encodable {
    public typealias Success = ResponseValues.GitHubRepositoryResponse

    public init(bodyQuery query: String) {
        self.query = query
    }

    public var query: String

    public var method: HTTPMethod { .post }
    public var path: String { "/path" }

    public var body: RequestBody? {
        EncodableRequestBody(value: self, jsonEncoder: .default)
    }
}
