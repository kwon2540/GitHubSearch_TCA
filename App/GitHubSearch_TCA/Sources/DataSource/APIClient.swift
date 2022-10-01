//
//  APIClient.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/01.
//

import Foundation

public enum APIError: Error {
    case invalidURL
    case responseError
    case parseError(Error)
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol APIClientProtocol {

    func perform<T: Decodable>(method: HTTPMethod, url: String?) async throws -> T

    func perform(method: HTTPMethod, url: String?) async throws -> Data
}

extension APIClientProtocol {

    public func perform<T: Decodable>(method: HTTPMethod, url: String?) async throws -> T {
        let data = try await perform(method: method, url: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}

public class APIClient: APIClientProtocol {

    public init() {}

    public func perform(method: HTTPMethod, url: String?) async throws -> Data {
        guard let urlString = url, let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
