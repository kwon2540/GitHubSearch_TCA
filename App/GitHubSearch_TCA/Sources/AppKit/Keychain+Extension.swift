//
//  Keychain+Extension.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/29.
//

import Foundation

import Foundation
import KeychainAccess

extension Keychain {
    enum Key: String {
        case keyword
    }

    subscript(key: Key) -> String? {
        get { self[key.rawValue] }
        set { self[key.rawValue] = newValue }
    }
}
