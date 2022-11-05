//
//  DevelopmentApp.swift
//  Development
//
//  Created by クォン ジュンヒョク on 2022/08/13.
//

import AppKit
import SwiftUI

@main
struct DevelopmentApp: AppKit.App {
    var primitiveEnvironment = PrimitiveEnvironment(apiBaseURL: URL(string: "https://api.github.com")!)
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
}
