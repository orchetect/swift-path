//
//  StringToFloatParseStrategy Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

/// This suite tests:
/// - `AnyPathMethodParameter` static constructor for float types:
///   - All compile successfully
///   - Have correct associated generic types
///   - Label property is correctly stored
/// - `StringToFloatParseStrategy` static constructors
/// - String parsing results
@Suite
struct StringToFloatParseStrategy_Tests {
    @Test
    func double() throws {
        let param = AnyPathMethodParameter.double(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Double.self)
        #expect(try param.parse("123", strategy: .double) == 123 as Double)
        #expect(try param.parse("123.5", strategy: .double) == 123.5 as Double)

        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .double)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("abc", strategy: .double)
        }
    }

    @Test
    func float() throws {
        let param = AnyPathMethodParameter.float(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Float.self)
        #expect(try param.parse("123", strategy: .float) == 123 as Float)
        #expect(try param.parse("123.5", strategy: .float) == 123.5 as Float)

        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .float)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("abc", strategy: .float)
        }
    }
}
