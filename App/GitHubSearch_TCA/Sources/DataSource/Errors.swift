import Foundation
import Core

extension APIClient {
    public enum Error: Swift.Error {
        case request(RequestError)
        case urlSession(URLError)
        case unknown(Swift.Error)
    }
}

// MARK: -

public enum RequestError: Error {
    case invalidBaseURL(URL)
    case requestBodyEncodingFailed(Error)
}

// MARK: -

/// - remark: ``Response``はジェネリックパラメータを持っているため、エラーをinner enumにすると利用側で取り回しが悪くなってしまう。
public enum ResponseError: Error {
    case api(APIError)
    case decoding(Error)
}

extension ResponseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .api(let apiError):
            return apiError.errorDescription
        case .decoding(let error as DecodingError):
            return error.errorDescription
        case .decoding(let error):
            return error.localizedDescription
        }
    }
}

