//
//  StringToRawRepresentableParseStrategy Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftPath
import Testing

/// This suite tests:
/// - `StringToRawRepresentableParseStrategy` static constructors
/// - String parsing results
@Suite
struct StringToRawRepresentableParseStrategy_Tests {
    @Test
    func baseline() {
        let param = AnyPathMethodParameter<MyEnum>(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == MyEnum.self)
    }

    /// Tests using the `<TYPE>.rawValueParseStrategy` static constructor
    @Test
    func rawRepresentableExtension() throws {
        let param = AnyPathMethodParameter<MyEnum>(label: "test")

        #expect(try param.parse("foo", strategy: MyEnum.rawValueParseStrategy) == .foo)
        #expect(try param.parse("bar", strategy: MyEnum.rawValueParseStrategy) == .bar)

        #expect(throws: (any Error).self) {
            _ = try param.parse("Foo", strategy: MyEnum.rawValueParseStrategy)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("FOO", strategy: MyEnum.rawValueParseStrategy)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse(" foo", strategy: MyEnum.rawValueParseStrategy)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("foo ", strategy: MyEnum.rawValueParseStrategy)
        }
    }
}

// MARK: - Test Types

private enum MyEnum: String {
    case foo
    case bar
}
