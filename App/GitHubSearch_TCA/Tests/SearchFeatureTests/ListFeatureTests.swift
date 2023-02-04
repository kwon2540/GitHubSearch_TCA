import ComposableArchitecture
import Core
import DataSource
import XCTest
@testable import SearchFeature

@MainActor
final class ListFeatureTests: XCTestCase {

    var state = ListReducer.State()
    var environment = SearchEnvironment.unimplemented

    override func setUp() {
        super.setUp()
        state = ListReducer.State()
        environment = SearchEnvironment.unimplemented
    }

    func testOnAppear() async {
        state.detail = .init(url: URL(string: "www.google.com")!, title: "")

        let store = TestStore(
            initialState: state,
            reducer: ListReducer(environment: .unimplemented)
        )

        await store.send(.onAppear) {
            $0.detail = nil
        }
    }

    func testFetchRepositoryList_Failure() async {
        let error = ResponseError.api(.init(code: "-1", errorDescription: "error"))

        environment.repositoryList = { keyword in
            throw error
        }

        let store = TestStore(
            initialState: state,
            reducer: ListReducer(environment: environment)
        )

        await store.send(.fetchRepositoryList) {
            $0.isLoading = true
        }

        await store.receive(.repositoryListResponse(.failure(error))) {
            $0.isLoading = false
            $0.alertState = AlertState(title: TextState(error.localizedDescription))
        }
    }

    func testFetchRepositoryList_Success() async {
        state.keyword = "swift"

        let repositoryListResponse = ResponseValues.GitHubRepositoryResponse(items: [])
        environment.repositoryList = { [stateKeyword = state.keyword] keyword in
            XCTAssertEqual(stateKeyword, keyword)
            return repositoryListResponse
        }

        let store = TestStore(
            initialState: state,
            reducer: ListReducer(environment: environment)
        )

        await store.send(.fetchRepositoryList) {
            $0.isLoading = true
        }

        await store.receive(.repositoryListResponse(.success(repositoryListResponse))) {
            $0.isLoading = false
        }
    }

    func testRepositoryItemTapped() async {
        let store = TestStore(
            initialState: state,
            reducer: ListReducer(environment: environment)
        )

        let url = URL(string: "www.google.com")!
        let title = "Google"
        await store.send(.repositoryItemTapped(url: url, title: title)) {
            $0.detail = Detail(url: url, title: title)
        }
    }

    func testAlertOnDismissed() async {
        state.alertState = AlertState(title: TextState("error.localizedDescription"))

        let store = TestStore(
            initialState: state,
            reducer: ListReducer(environment: environment)
        )

        await store.send(.alertAction(.onDismiss)) {
            $0.alertState = nil
        }
    }

    func testSearchBinding() async {
        let aState = ListReducer.State()
        let error = ResponseError.api(.init(code: "-1", errorDescription: "error"))

        environment.repositoryList = { keyword in
            XCTAssertEqual(aState.keyword, keyword) // TODO: Why state.keyword is empty ???
            throw error
        }

        // below v16.0
//        let mainQueue = DispatchQueue.test
//        await mainQueue.advance(by: .seconds(1))
        let clock = TestClock()
        let store = TestStore(
            initialState: aState,
            reducer: ListReducer(environment: environment)
        ) {
            $0.continuousClock = clock
        }

        let keyword = "swift"
        await store.send(.binding(.set(\.$keyword, keyword))) {
            $0.keyword = keyword
        }

        await clock.advance(by: .seconds(1))
        await store.receive(.fetchRepositoryList) {
            $0.isLoading = true
        }

        await store.receive(.repositoryListResponse(.failure(error))) {
            $0.isLoading = false
            $0.alertState = AlertState(title: TextState(error.localizedDescription))
        }
    }
}
