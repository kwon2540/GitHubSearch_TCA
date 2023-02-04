import Foundation

public enum HTTPMethod: String {
    case get, post, put, delete
}

// MARK: -

public protocol Request<Success> {
    associatedtype Success

    var method: HTTPMethod { get }
    var path: String { get }
    var headerFields: [String: String] { get }
    var queries: [String: String] { get }
    var body: RequestBody? { get }

    func response(from data: Data, urlResponse: HTTPURLResponse) -> Response<Success>
}

extension Request {
    public var headerFields: [String: String] { [:] }
    public var queries: [String: String] { [:] }
    public var body: RequestBody? { nil }
}

extension Request {
    public func response(from data: Data, urlResponse: HTTPURLResponse) -> Response<Success> where Success: Decodable {
        Response.parse(data, with: .default, urlResponse: urlResponse)
    }

    public func response(from data: Data, urlResponse: HTTPURLResponse) -> Response<Success> where Success == Void {
        Response.parse(data, with: .default, urlResponse: urlResponse)
    }
}

// MARK: - URL Request Factory

extension Request {
    /// - throws: `RequestError`.
    @usableFromInline
    func makeURLRequest(baseURL: URL) throws -> URLRequest {
        try _makeURLRequest(baseURL: baseURL)
    }

    fileprivate func _makeURLRequest(baseURL: URL) throws -> URLRequest {
        // 後からURLComponents.pathに割り当てると、baseURLに含まれるパスが上書きされてしまうため、代わりにあらかじめpathも結合しておく。
        let url = path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw RequestError.invalidBaseURL(baseURL)
        }

        if !queries.isEmpty {
            // `percentEncodedQueryItems`に空配列を設定するとURLの末尾に"?"のみ挿入されてしまうため、`queries.isEmpty == true`の場合は`nil`の状態をキープさせる。
            urlComponents.percentEncodedQueryItems = queries.map { key, value in
                URLQueryItem(
                    name: key.addingPercentEncoding(withAllowedCharacters: .rfc3986URLQueryAllowed) ?? key,
                    value: value.addingPercentEncoding(withAllowedCharacters: .rfc3986URLQueryAllowed) ?? value
                )
            }
        }

        assert(urlComponents.url != nil)

        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = method.rawValue.uppercased()
        headerFields.forEach {
            urlRequest.setValue($1, forHTTPHeaderField: $0)
        }

        guard let body else {
            return urlRequest
        }

        do {
            urlRequest.httpBody = try body.encode()
            urlRequest.setValue(body.contentType, forHTTPHeaderField: "Content-Type")
        } catch {
            throw RequestError.requestBodyEncodingFailed(error as NSError)
        }

        return urlRequest
    }
}

// MARK: - CharacterSet Conformed to RFC 3986

extension CharacterSet {
    static let rfc3986URLQueryAllowed: CharacterSet = {
        // https://github.com/Alamofire/Alamofire/blob/f82c23a8a7ef8dc1a49a8bfc6a96883e79121864/Source/URLEncodedFormEncoder.swift#L964-L982
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        let encodableDelimiters = CharacterSet(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return .urlQueryAllowed.subtracting(encodableDelimiters)
    }()
}
