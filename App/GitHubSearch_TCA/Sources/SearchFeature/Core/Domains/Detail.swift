//
//  Detail.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/12/03.
//

import Foundation

public struct Detail: Hashable {
    init(url: URL, title: String) {
        self.url = url
        self.title = title
    }
    
    var url: URL
    var title: String
}
