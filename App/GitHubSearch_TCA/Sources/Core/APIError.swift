//
//  APIError.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/22.
//

import Foundation

public struct APIError: Hashable, Codable {

    public var code: String
    public var errorDescription: String

    public init(code: String, errorDescription: String) {
        self.code = code
        self.errorDescription = errorDescription
    }
}
