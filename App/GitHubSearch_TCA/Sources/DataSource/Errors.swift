import Foundation
import Core

extension APIClient {
    public enum Error: Swift.Error, Equatable {
        case request(RequestError)
        case urlSession(URLError)
        case unknown(NSError)
    }
}

// MARK: -

public enum RequestError: Error, Equatable {
    case invalidBaseURL(URL)
    case requestBodyEncodingFailed(NSError)
}

// MARK: -

/// - remark: ``Response``はジェネリックパラメータを持っているため、エラーをinner enumにすると利用側で取り回しが悪くなってしまう。
public enum ResponseError: Error, Equatable  {
    case api(APIError)
    case decoding(NSError)
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

