//
//  Color.swift
//  
//
//  Created by クォン ジュンヒョク on 2022/08/13.
//

import SwiftUI

/// アプリ内で使用される色定義。色空間は`sRGB`。
///
/// SwiftUIでの使用例:
/// ```swift
/// ZStack {
///     // `AppColor`を直接使用する
///     AppColor.primary
///     Text("Hello, World!")
///         // `SwiftUI.Color`が要求される場面では、
///         // 拡張された`app()`メソッドを経由して`AppColor`を使用する
///         .foregroundColor(.app(.secondary))
///         .background {
///             RoundedRectangle(cornerRadius: 10)
///                 // `Color(.primary1)`とも書けるが、下記の書き方は`AppColor`であることをより強調できる
///                 .fill(Color.app(.primary))
///         }
/// }
/// ```
///
/// UIKitでの使用例:
/// ```swift
/// let view = UIView()
/// view.backgroundColor = .app(.primary)
/// view.layer.shadowColor = UIColor(.secondary).cgColor
/// ```
public enum AppColor: String, CaseIterable, View {
    /// \#000000
    case primary

    /// \#ffffff
    case secondary

    public var body: Color {
        Color(self)
    }
}

extension Color {
    public init(_ appColor: AppColor) {
        self.init(appColor.rawValue, bundle: .module)
    }

    public static func app(_ appColor: AppColor) -> Self {
        Color(appColor)
    }
}

extension UIColor {
    public convenience init(_ appColor: AppColor) {
        self.init(named: appColor.rawValue, in: .module, compatibleWith: nil)!
    }

    public static func app(_ appColor: AppColor) -> UIColor {
        UIColor(appColor)
    }
}

struct AppColor_Previews: PreviewProvider {
    static var previews: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(AppColor.allCases, id: \.self) { color in
                color
                    .border(Color.purple)
                    .frame(height: 80)

            }
        }
        .padding()
    }
}
