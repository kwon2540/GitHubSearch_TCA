//
//  App.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/08/13.
//

import SwiftUI

public protocol App: SwiftUI.App {
}

extension App {
    public var body: some Scene {
        WindowGroup {
            EmptyView()
        }
    }
}
