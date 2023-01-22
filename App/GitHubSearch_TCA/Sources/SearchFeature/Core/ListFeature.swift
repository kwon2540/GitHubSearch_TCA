//
//  ListFeature.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/10/01.
//

import Core
import ComposableArchitecture
import DataSource
import Foundation

public struct ListReducer: ReducerProtocol {
    public struct State: Equatable {
        public init() {}
        @BindableState var keyword = ""
        var repositoryList: [ResponseValues.GitHubRepositoryResponse.GitHubRepository] = []
        var isLoading = false
        
        var detail: Detail?
        
        var alertState: AlertState<Action.AlertAction>?
    }
    
    public enum Action: Equatable, BindableAction {
        case onAppear
//        case keywordChanged(String)
        case fetchRepositoryList
        case repositoryListResponse(TaskResult<ResponseValues.GitHubRepositoryResponse>)
        
        case repositoryItemTapped(url: URL, title: String)
        
        case alertAction(AlertAction)
        case binding(BindingAction<State>)
        
        public enum AlertAction: Equatable {
            case onDismiss
        }
    }
    
    var environment: SearchEnvironment
    
    public init(environment: SearchEnvironment) {
        self.environment = environment
    }
    
    enum FetchId {}
    public var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.detail = nil
                
            case .fetchRepositoryList:
                state.isLoading = true
                return .task { [state] in
                    await .repositoryListResponse(
                        TaskResult {
                            try await environment.repositoryList(state.keyword)
                        }
                    )
                }
                
            case .repositoryListResponse(.success(let response)):
                state.isLoading = false
                state.repositoryList = response.items
                
            case .repositoryListResponse(.failure(let error)):
                state.isLoading = false
                state.alertState = AlertState(title: TextState(error.localizedDescription))
                
            case .repositoryItemTapped(let url, let title):
                state.detail = Detail(url: url, title: title)
                
            case .alertAction(.onDismiss):
                state.alertState = nil

            case .binding(\.$keyword):
                print("keyword: \(state.keyword)")
                if state.keyword.isEmpty {
                    state.repositoryList = []
                    break
                }

                return .init(value: .fetchRepositoryList)
                    .delay(for: 1, scheduler: DispatchQueue.main)
                    .eraseToEffect()
                    .cancellable(id: FetchId.self, cancelInFlight: true)

            case .binding:
                break
            }
            
            return .none
        }
    }
}

// Sample Code
//            case .keywordChanged(let keyword):
//                state.keyword = keyword
//
//                return .init(value: .fetchRepositoryList)
//                    .delay(for: 1, scheduler: DispatchQueue.main)
//                    .eraseToEffect()
//                    .cancellable(id: FetchId.self, cancelInFlight: true)
