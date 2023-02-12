import Foundation
import Core

public struct Response<Value> {
    public var result: Result<Value, ResponseError>
    public var urlResponse: HTTPURLResponse

    public var value: Value? {
        try? result.get()
    }
}

extension Response {
    static func parse(
        _ data: Data,
        with jsonDecoder: JSONDecoder,
        urlResponse: HTTPURLResponse
    ) -> Self where Value: Decodable {
        do {
            if 200..<300 ~= urlResponse.statusCode {
                let decodedValue = try jsonDecoder.decode(Value.self, from: data)
                return Self.init(result: .success(decodedValue), urlResponse: urlResponse)
            }

            let apiError = try jsonDecoder.decode(APIError.self, from: data)
            return Self.init(result: .failure(.api(apiError)), urlResponse: urlResponse)
        } catch {
            return Self.init(result: .failure(.decoding(error as NSError)), urlResponse: urlResponse)
        }
    }

    static func parse(
        _ data: Data,
        with jsonDecoder: JSONDecoder,
        urlResponse: HTTPURLResponse
    ) -> Self where Value == Void {
        do {
            if 200..<300 ~= urlResponse.statusCode {
                return Self.init(result: .success(()), urlResponse: urlResponse)
            }

            let apiError = try jsonDecoder.decode(APIError.self, from: data)
            return Self.init(result: .failure(.api(apiError)), urlResponse: urlResponse)
        } catch {
            return Self.init(result: .failure(.decoding(error as NSError)), urlResponse: urlResponse)
        }
    }
}
