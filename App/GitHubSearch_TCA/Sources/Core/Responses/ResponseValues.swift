import Foundation

/// ``Response``の`Value`ジェネリックパラメータに割り当てられる構造体のネームスペース。
///
/// プロパティ名は、コードを書く際の手数を減らすため、[Swift API Design Guideline](https://www.swift.org/documentation/api-design-guidelines/#follow-case-conventions)を逸脱する場合がある。
/// ```swift
/// struct ExampleValue1: Decodable {
///     var appId: String
///     var lifeUuid: String
/// }
/// ```
/// `appId`と`lifeUuid`は、Swift API Design Guidelineに照らし合わせると、`appID`と`lifeUUID`と最後までUpperCaseで表記するのが正しい。
/// しかし、[`JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase`](https://developer.apple.com/documentation/foundation/jsondecoder/keydecodingstrategy/convertfromsnakecase)では`ExampleValue1`のプロパティ名のような形式でないと正しくパースできない。
/// Swift API Design Guidelineに沿ったプロパティ名にするには、`CodingKeys` enumを明示する必要がある。
/// ```swift
/// struct ExampleValue2: Decodable {
///     var appID: String
///     var lifeUUID: String
///     private enum CodingKeys: String, CodingKey {
///         case appID = "appId"
///         case lifeUUID = "lifeUuid"
///     }
/// }
/// ```
/// ResponseValueは、DTO的な役割でプロパティの値を取り出すだけか、ドメインオブジェクトなど別のオブジェクトに詰め替えられるだけなので寿命は比較的短くなる傾向にある。
/// したがって、コードの統一感を少し妥協しResponseValueを定義する際の手数削減を優先する。
///
/// 補足: [`JSONEncoder.KeyEncodingStrategy.convertToSnakeCase`](https://developer.apple.com/documentation/foundation/jsonencoder/keyencodingstrategy/converttosnakecase)では、
/// `appID`や`lifeUUID`は`app_id`と`life_uuid`に変換される。
///
/// - note: ``Request`` protocolに準拠した構造体の場合は、"Request"を接尾辞としたほうが自然な型名になるため、ネームスペースとしての`Requests` enumは作らない。
/// 例: `Requests.A01Activation` → `A01ActivationRequest`
public enum ResponseValues {
}
