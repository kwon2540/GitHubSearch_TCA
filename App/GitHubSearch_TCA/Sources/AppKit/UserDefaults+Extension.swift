//
//  UserDefaults+Extension.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/29.
//

import Core
import Foundation

extension UserDefaults {
    
    var keyword: String? {
        get { string(forKey: Key.keyword.rawValue) }
        set { set(newValue, forKey: Key.keyword.rawValue) }
    }
}

private enum Key: String {
    case keyword
}

