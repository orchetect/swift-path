//
//  FloatToStringFormatStyle Tests.swift
//  SwiftPath
//

import Testing
import SwiftPath

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
    func double() throws {
        let param = AnyPathMethodParameter.double(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Double.self)
        #expect(param.format(123.5 as Double, format: .string) == "123.5")
    }

    @Test
    func float() throws {
        let param = AnyPathMethodParameter.float(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Float.self)
        #expect(param.format(123.5 as Float, format: .string) == "123.5")
    }
}
