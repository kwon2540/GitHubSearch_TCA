//
//  ListView.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/12/03.
//

import Combine
import ComposableArchitecture
import Foundation
import SwiftUI
import UIKit

public struct ListView: UIViewControllerRepresentable {
    public init(store: Store<ListState, ListAction>) {
        self.store = store
    }

    let store: Store<ListState, ListAction>

    public func makeUIViewController(context: Context) -> UIViewController {
        ListViewController(store: store)
    }

    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

private final class ListViewController: UINavigationController {
    init(store: Store<ListState, ListAction>) {
        self.store = store
        let contentView = ListContentView(store: store)
        super.init(rootViewController: UIHostingController(rootView: contentView))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let store: Store<ListState, ListAction>
    private lazy var viewStore = ViewStore(store)

    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
