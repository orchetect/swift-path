//
//  FloatToStringFormatStyle Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

/// This suite tests:
/// - `AnyPathMethodParameter` static constructors for float types:
///   - All compile successfully
///   - Have correct associated generic types
///   - Label property is correctly stored
/// - `FloatToStringFormatStyle` static constructors
/// - Basic string formatting results
@Suite
struct FloatToStringFormatStyle_Tests {
    @Test
    func double() {
        let param = AnyPathMethodParameter.double(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Double.self)
        #expect(param.format(123.5 as Double, format: .string) == "123.5")
    }

    @Test
    func float() {
        let param = AnyPathMethodParameter.float(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Float.self)
        #expect(param.format(123.5 as Float, format: .string) == "123.5")
    }
}
