//
//  StringToIntParseStrategy Tests.swift
//  SwiftPath
//

import Testing
import SwiftPath

/// This suite tests:
/// - `AnyPathMethodParameter` static constructor for integer types:
///   - All compile successfully
///   - Have correct associated generic types
///   - Label property is correctly stored
/// - `StringToIntParseStrategy` static constructors
/// - String parsing results
@Suite
struct StringToIntParseStrategy_Tests {
    @Test
    func int() throws {
        let param = AnyPathMethodParameter.int(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Int.self)
        #expect(try param.parse("123", strategy: .int) == 123 as Int)

        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .int)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("abc", strategy: .int)
        }
    }

    // (Since this initializer is shared for all associated integer types, we don't need to repeat this
    // test for every integer type in this test suite.)
    @Test
    func int_init_encoding() throws {
        #expect(StringToIntParseStrategy<Int>(options: []).options == [])
        #expect(StringToIntParseStrategy<Int>(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func int_staticConstructors() throws {
        #expect(StringToIntParseStrategy.int(options: []).options == [])
        #expect(StringToIntParseStrategy.int(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func int_encodingComposition() throws {
        #expect(StringToIntParseStrategy.int.options([]).options == [])
        #expect(StringToIntParseStrategy.int.options([.allowBool]).options == [.allowBool])
    }

    @Test
    func int8() throws {
        let param = AnyPathMethodParameter.int8(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Int8.self)
        #expect(try param.parse("123", strategy: .int8) == 123 as Int8)

        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .int8)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("abc", strategy: .int8)
        }
    }

    @Test
    func int8_staticConstructors() throws {
        #expect(StringToIntParseStrategy.int8(options: []).options == [])
        #expect(StringToIntParseStrategy.int8(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func int8_encodingComposition() throws {
        #expect(StringToIntParseStrategy.int8.options([]).options == [])
        #expect(StringToIntParseStrategy.int8.options([.allowBool]).options == [.allowBool])
    }

    @Test
    func int16() throws {
        let param = AnyPathMethodParameter.int16(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Int16.self)
        #expect(try param.parse("123", strategy: .int16) == 123 as Int16)

        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .int16)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("abc", strategy: .int16)
        }
    }

    @Test
    func int16_staticConstructors() throws {
        #expect(StringToIntParseStrategy.int16(options: []).options == [])
        #expect(StringToIntParseStrategy.int16(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func int16_encodingComposition() throws {
        #expect(StringToIntParseStrategy.int16.options([]).options == [])
        #expect(StringToIntParseStrategy.int16.options([.allowBool]).options == [.allowBool])
    }

    @Test
    func int32() throws {
        let param = AnyPathMethodParameter.int32(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Int32.self)
        #expect(try param.parse("123", strategy: .int32) == 123 as Int32)

        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .int32)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("abc", strategy: .int32)
        }
    }

    @Test
    func int32_staticConstructors() throws {
        #expect(StringToIntParseStrategy.int32(options: []).options == [])
        #expect(StringToIntParseStrategy.int32(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func int32_encodingComposition() throws {
        #expect(StringToIntParseStrategy.int32.options([]).options == [])
        #expect(StringToIntParseStrategy.int32.options([.allowBool]).options == [.allowBool])
    }

    @Test
    func int64() throws {
        let param = AnyPathMethodParameter.int64(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Int64.self)
        #expect(try param.parse("123", strategy: .int64) == 123 as Int64)

        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .int64)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("abc", strategy: .int64)
        }
    }

    @Test
    func int64_staticConstructors() throws {
        #expect(StringToIntParseStrategy.int64(options: []).options == [])
        #expect(StringToIntParseStrategy.int64(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func int64_encodingComposition() throws {
        #expect(StringToIntParseStrategy.int64.options([]).options == [])
        #expect(StringToIntParseStrategy.int64.options([.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt() throws {
        let param = AnyPathMethodParameter.uInt(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == UInt.self)
        #expect(try param.parse("123", strategy: .uInt) == 123 as UInt)

        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .uInt)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("abc", strategy: .uInt)
        }
    }

    @Test
    func uInt_staticConstructors() throws {
        #expect(StringToIntParseStrategy.uInt(options: []).options == [])
        #expect(StringToIntParseStrategy.uInt(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt_encodingComposition() throws {
        #expect(StringToIntParseStrategy.uInt.options([]).options == [])
        #expect(StringToIntParseStrategy.uInt.options([.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt8() throws {
        let param = AnyPathMethodParameter.uInt8(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == UInt8.self)
        #expect(try param.parse("123", strategy: .uInt8) == 123 as UInt8)

        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .uInt8)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("abc", strategy: .uInt8)
        }
    }

    @Test
    func uInt8_staticConstructors() throws {
        #expect(StringToIntParseStrategy.uInt8(options: []).options == [])
        #expect(StringToIntParseStrategy.uInt8(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt8_encodingComposition() throws {
        #expect(StringToIntParseStrategy.uInt8.options([]).options == [])
        #expect(StringToIntParseStrategy.uInt8.options([.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt16() throws {
        let param = AnyPathMethodParameter.uInt16(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == UInt16.self)
        #expect(try param.parse("123", strategy: .uInt16) == 123 as UInt16)

        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .uInt16)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("abc", strategy: .uInt16)
        }
    }

    @Test
    func uInt16_staticConstructors() throws {
        #expect(StringToIntParseStrategy.uInt16(options: []).options == [])
        #expect(StringToIntParseStrategy.uInt16(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt16_encodingComposition() throws {
        #expect(StringToIntParseStrategy.uInt16.options([]).options == [])
        #expect(StringToIntParseStrategy.uInt16.options([.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt32() throws {
        let param = AnyPathMethodParameter.uInt32(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == UInt32.self)
        #expect(try param.parse("123", strategy: .uInt32) == 123 as UInt32)

        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .uInt32)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("abc", strategy: .uInt32)
        }
    }

    @Test
    func uInt32_staticConstructors() throws {
        #expect(StringToIntParseStrategy.uInt32(options: []).options == [])
        #expect(StringToIntParseStrategy.uInt32(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt32_encodingComposition() throws {
        #expect(StringToIntParseStrategy.uInt32.options([]).options == [])
        #expect(StringToIntParseStrategy.uInt32.options([.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt64() throws {
        let param = AnyPathMethodParameter.uInt64(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == UInt64.self)
        #expect(try param.parse("123", strategy: .uInt64) == 123 as UInt64)

        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .uInt64)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("abc", strategy: .uInt64)
        }
    }

    @Test
    func uInt64_staticConstructors() throws {
        #expect(StringToIntParseStrategy.uInt64(options: []).options == [])
        #expect(StringToIntParseStrategy.uInt64(options: [.allowBool]).options == [.allowBool])
    }

    @Test
    func uInt64_encodingComposition() throws {
        #expect(StringToIntParseStrategy.uInt64.options([]).options == [])
        #expect(StringToIntParseStrategy.uInt64.options([.allowBool]).options == [.allowBool])
    }

    // MARK: - `ParseOption`

    @Test
    func int_noOptions() throws {
        let param = AnyPathMethodParameter.int(label: "test")
        let options: Set<StringToIntParseStrategy<Int>.ParseOption> = []

        // positive numbers
        #expect(try param.parse("123", strategy: .int(options: options)) == 123)
        #expect(try param.parse("123.0", strategy: .int(options: options)) == 123)
        #expect(throws: (any Error).self) {
            try param.parse("123.1", strategy: .int(options: options))
        }
        #expect(throws: (any Error).self) {
            try param.parse("123.9", strategy: .int(options: options))
        }

        // negative numbers
        #expect(try param.parse("-123", strategy: .int(options: options)) == -123)
        #expect(try param.parse("-123.0", strategy: .int(options: options)) == -123)
        #expect(throws: (any Error).self) {
            try param.parse("-123.1", strategy: .int(options: options))
        }
        #expect(throws: (any Error).self) {
            try param.parse("-123.9", strategy: .int(options: options))
        }

        // bool strings
        #expect(throws: (any Error).self) { try param.parse("true", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("false", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("TRUE", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("FALSE", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("t", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("f", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("T", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("F", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("yes", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("no", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("YES", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("NO", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("y", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("n", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("Y", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("N", strategy: .int(options: options)) }

        // non-numbers
        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .int(options: options))
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("abc", strategy: .int(options: options))
        }
    }

    @Test
    func int_allowNonWholeFloats() throws {
        let param = AnyPathMethodParameter.int(label: "test")
        let options: Set<StringToIntParseStrategy<Int>.ParseOption> = [.allowNonWholeFloats]

        // positive numbers
        #expect(try param.parse("123", strategy: .int(options: options)) == 123)
        #expect(try param.parse("123.0", strategy: .int(options: options)) == 123)
        #expect(try param.parse("123.1", strategy: .int(options: options)) == 123)
        #expect(try param.parse("123.9", strategy: .int(options: options)) == 123)

        // negative numbers
        #expect(try param.parse("-123", strategy: .int(options: options)) == -123)
        #expect(try param.parse("-123.0", strategy: .int(options: options)) == -123)
        #expect(try param.parse("-123.1", strategy: .int(options: options)) == -123)
        #expect(try param.parse("-123.9", strategy: .int(options: options)) == -123)

        // bool strings
        #expect(throws: (any Error).self) { try param.parse("true", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("false", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("TRUE", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("FALSE", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("t", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("f", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("T", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("F", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("yes", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("no", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("YES", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("NO", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("y", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("n", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("Y", strategy: .int(options: options)) }
        #expect(throws: (any Error).self) { try param.parse("N", strategy: .int(options: options)) }

        // non-numbers
        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .int(options: options))
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("abc", strategy: .int(options: options))
        }
    }

    @Test
    func int_allowBool() throws {
        let param = AnyPathMethodParameter.int(label: "test")
        let options: Set<StringToIntParseStrategy<Int>.ParseOption> = [.allowBool]

        // positive numbers
        #expect(try param.parse("123", strategy: .int(options: options)) == 123)
        #expect(try param.parse("123.0", strategy: .int(options: options)) == 123)
        #expect(throws: (any Error).self) {
            try param.parse("123.1", strategy: .int(options: options))
        }
        #expect(throws: (any Error).self) {
            try param.parse("123.9", strategy: .int(options: options))
        }

        // negative numbers
        #expect(try param.parse("-123", strategy: .int(options: options)) == -123)
        #expect(try param.parse("-123.0", strategy: .int(options: options)) == -123)
        #expect(throws: (any Error).self) {
            try param.parse("-123.1", strategy: .int(options: options))
        }
        #expect(throws: (any Error).self) {
            try param.parse("-123.9", strategy: .int(options: options))
        }

        // bool strings
        #expect(try param.parse("true", strategy: .int(options: options)) == 1)
        #expect(try param.parse("false", strategy: .int(options: options)) == 0)
        #expect(try param.parse("TRUE", strategy: .int(options: options)) == 1)
        #expect(try param.parse("FALSE", strategy: .int(options: options)) == 0)
        #expect(try param.parse("t", strategy: .int(options: options)) == 1)
        #expect(try param.parse("f", strategy: .int(options: options)) == 0)
        #expect(try param.parse("T", strategy: .int(options: options)) == 1)
        #expect(try param.parse("F", strategy: .int(options: options)) == 0)
        #expect(try param.parse("yes", strategy: .int(options: options)) == 1)
        #expect(try param.parse("no", strategy: .int(options: options)) == 0)
        #expect(try param.parse("YES", strategy: .int(options: options)) == 1)
        #expect(try param.parse("NO", strategy: .int(options: options)) == 0)
        #expect(try param.parse("y", strategy: .int(options: options)) == 1)
        #expect(try param.parse("n", strategy: .int(options: options)) == 0)
        #expect(try param.parse("Y", strategy: .int(options: options)) == 1)
        #expect(try param.parse("N", strategy: .int(options: options)) == 0)

        // non-numbers
        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .int(options: options))
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("abc", strategy: .int(options: options))
        }
    }

    @Test
    func int_allowNonWholeFloats_allowBool() throws {
        let param = AnyPathMethodParameter.int(label: "test")
        let options: Set<StringToIntParseStrategy<Int>.ParseOption> = [.allowNonWholeFloats, .allowBool]

        // positive numbers
        #expect(try param.parse("123", strategy: .int(options: options)) == 123)
        #expect(try param.parse("123.0", strategy: .int(options: options)) == 123)
        #expect(try param.parse("123.1", strategy: .int(options: options)) == 123)
        #expect(try param.parse("123.9", strategy: .int(options: options)) == 123)

        // negative numbers
        #expect(try param.parse("-123", strategy: .int(options: options)) == -123)
        #expect(try param.parse("-123.0", strategy: .int(options: options)) == -123)
        #expect(try param.parse("-123.1", strategy: .int(options: options)) == -123)
        #expect(try param.parse("-123.9", strategy: .int(options: options)) == -123)

        // bool strings
        #expect(try param.parse("true", strategy: .int(options: options)) == 1)
        #expect(try param.parse("false", strategy: .int(options: options)) == 0)
        #expect(try param.parse("TRUE", strategy: .int(options: options)) == 1)
        #expect(try param.parse("FALSE", strategy: .int(options: options)) == 0)
        #expect(try param.parse("t", strategy: .int(options: options)) == 1)
        #expect(try param.parse("f", strategy: .int(options: options)) == 0)
        #expect(try param.parse("T", strategy: .int(options: options)) == 1)
        #expect(try param.parse("F", strategy: .int(options: options)) == 0)
        #expect(try param.parse("yes", strategy: .int(options: options)) == 1)
        #expect(try param.parse("no", strategy: .int(options: options)) == 0)
        #expect(try param.parse("YES", strategy: .int(options: options)) == 1)
        #expect(try param.parse("NO", strategy: .int(options: options)) == 0)
        #expect(try param.parse("y", strategy: .int(options: options)) == 1)
        #expect(try param.parse("n", strategy: .int(options: options)) == 0)
        #expect(try param.parse("Y", strategy: .int(options: options)) == 1)
        #expect(try param.parse("N", strategy: .int(options: options)) == 0)

        // non-numbers
        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .int(options: options))
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("abc", strategy: .int(options: options))
        }
    }
}
