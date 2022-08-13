//
//  RootView.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/08/13.
//

import SwiftUI

public struct RootView: View {
    public init() {
    }

    public var body: some View {
        Label("Hello, world!", systemImage: "swift")
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
