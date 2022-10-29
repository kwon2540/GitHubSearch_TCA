import Foundation

public protocol RequestBody {
    var contentType: String { get }

    /// - throws: `Error`.
    func encode() throws -> Data
}

struct JSONRequestBody: RequestBody {
    @_disfavoredOverload
    init(json: Any) {
        self.json = json
    }

    init(dictionary: () -> [String: Any]) {
        self.init(json: dictionary())
    }

    init(array: () -> [[String: Any]]) {
        self.init(json: array())
    }

    let json: Any

    public let contentType = "application/json"

    public func encode() throws -> Data {
        try JSONSerialization.data(withJSONObject: json)
    }
}

struct EncodableRequestBody<Value: Encodable>: RequestBody {
    var value: Value
    var jsonEncoder: JSONEncoder

    public let contentType = "application/json"

    public func encode() throws -> Data {
        try jsonEncoder.encode(value)
    }
}
