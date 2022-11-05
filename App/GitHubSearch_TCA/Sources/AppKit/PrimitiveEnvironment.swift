//
//  File.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/29.
//

import Foundation

public struct PrimitiveEnvironment {
    public init(apiBaseURL: URL) {
        self.apiBaseURL = apiBaseURL
    }

    public let apiBaseURL: URL
}
