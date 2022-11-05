//
//  AppEnvironment.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/29.
//

import Foundation
import SearchFeature

public struct AppEnvironment {
    public init(searchEnvironment: SearchEnvironment) {
        self.searchEnvironment = searchEnvironment
    }

    var searchEnvironment: SearchEnvironment
}

#if DEBUG
import XCTestDynamicOverlay

public extension AppEnvironment {
    static let unimplemented = Self(searchEnvironment: .unimplemented)
}
#endif
