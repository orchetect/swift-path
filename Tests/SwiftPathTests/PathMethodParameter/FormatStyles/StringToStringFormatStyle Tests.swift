//
//  StringToStringFormatStyle Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

/// This suite tests:
/// - `AnyPathMethodParameter` static constructor for `String` type:
///   - Compiles successfully
///   - Has correct associated generic type
///   - Label property is correctly stored
/// - `StringToStringFormatStyle` static constructors
/// - Basic string formatting results
@Suite
struct StringToStringFormatStyle_Tests {
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func string() {
        let param = AnyPathMethodParameter.string(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == String.self)
        #expect(param.format("", format: .string) == "")
        #expect(param.format("foo", format: .string) == "foo")
    }
}
