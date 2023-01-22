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
    public init(store: StoreOf<ListReducer>) {
        self.store = store
    }

    let store: StoreOf<ListReducer>

    public func makeUIViewController(context: Context) -> UIViewController {
        ListViewController(store: store)
    }

    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

private final class ListViewController: UINavigationController {
    init(store: StoreOf<ListReducer>) {
        self.store = store
        let contentView = ListContentView(store: store)
        super.init(rootViewController: UIHostingController(rootView: contentView))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let store: StoreOf<ListReducer>
    private lazy var viewStore = ViewStore(store)

    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

//        store.scope(state: \.detailState, action: ListAction.detailAction)
//            .ifLet { [weak self] store in
//                self?.pushViewController(UIHostingController(rootView: DetailView(store: store)), animated: true)
//            }
//            .store(in: &cancellable)

        viewStore
            .publisher
            .detail
            .sink { [weak self] detail in
                if let detail {
                    self?.pushViewController(UIHostingController(rootView: DetailView(url: detail.url, title: detail.title)), animated: true)
                }
            }
            .store(in: &cancellable)
    }
}
