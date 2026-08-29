//
//  IntToStringFormatStyle Tests.swift
//  SwiftPath
//

import Testing
import SwiftPath

/// This suite tests:
/// - `AnyPathMethodParameter` static constructors for integer types:
///   - All compile successfully
///   - Have correct associated generic types
///   - Label property is correctly stored
/// - `IntToStringFormatStyle` static constructors
/// - Basic string formatting results
@Suite
struct IntToStringFormatStyle_Tests {
    @Test
    func int() throws {
        let param = AnyPathMethodParameter.int(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Int.self)
        #expect(param.format(123 as Int, format: .string) == "123")
    }

    @Test
    func int8() throws {
        let param = AnyPathMethodParameter.int8(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Int8.self)
        #expect(param.format(123 as Int8, format: .string) == "123")
    }

    @Test
    func int16() throws {
        let param = AnyPathMethodParameter.int16(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Int16.self)
        #expect(param.format(123 as Int16, format: .string) == "123")
    }

    @Test
    func int32() throws {
        let param = AnyPathMethodParameter.int32(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Int32.self)
        #expect(param.format(123 as Int32, format: .string) == "123")
    }

    @Test
    func int64() throws {
        let param = AnyPathMethodParameter.int64(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Int64.self)
        #expect(param.format(123 as Int64, format: .string) == "123")
    }

    @Test
    func uInt() throws {
        let param = AnyPathMethodParameter.uInt(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == UInt.self)
        #expect(param.format(123 as UInt, format: .string) == "123")
    }

    @Test
    func uInt8() throws {
        let param = AnyPathMethodParameter.uInt8(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == UInt8.self)
        #expect(param.format(123 as UInt8, format: .string) == "123")
    }

    @Test
    func uInt16() throws {
        let param = AnyPathMethodParameter.uInt16(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == UInt16.self)
        #expect(param.format(123 as UInt16, format: .string) == "123")
    }

    @Test
    func uInt32() throws {
        let param = AnyPathMethodParameter.uInt32(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == UInt32.self)
        #expect(param.format(123 as UInt32, format: .string) == "123")
    }

    @Test
    func uInt64() throws {
        let param = AnyPathMethodParameter.uInt64(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == UInt64.self)
        #expect(param.format(123 as UInt64, format: .string) == "123")
    }
}
