//
//  APIClient.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/01.
//

import Foundation
import Core

public final class APIClient {
    public init(baseURL: URL, urlSessionConfiguration: URLSessionConfiguration = .default) {
        self.baseURL = baseURL
        self.urlSession = URLSession(configuration: urlSessionConfiguration)
    }

    public let baseURL: URL
    let urlSession: URLSession

    /// - throws: `APIClient.Error`.
    @usableFromInline
    func send(_ urlRequest: URLRequest) async throws -> (Data, HTTPURLResponse) {
        do {
            let (data, urlResponse) = try await urlSession.data(for: urlRequest)
            return (data, urlResponse as! HTTPURLResponse)
        } catch let error as URLError {
            throw Error.urlSession(error)
        } catch {
            throw Error.unknown(error as NSError)
        }
    }

    /// - throws: `APIClient.Error`.
    @inlinable
    public func send<S>(_ request: some Request<S>) async throws -> Response<S> {
        do {
            let urlRequest = try request.makeURLRequest(baseURL: baseURL)
            let (data, urlResponse) = try await send(urlRequest)
            return request.response(from: data, urlResponse: urlResponse)
        } catch let error as RequestError {
            throw Error.request(error)
        }
    }
}
