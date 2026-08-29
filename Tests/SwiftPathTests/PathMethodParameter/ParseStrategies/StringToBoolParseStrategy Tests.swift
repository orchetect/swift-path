//
//  StringToBoolParseStrategy Tests.swift
//  SwiftPath
//

import Testing
import SwiftPath

/// This suite tests:
/// - `AnyPathMethodParameter` static constructor for `Bool` type:
///   - Compiles successfully
///   - Has correct associated generic type
///   - Label property is correctly stored
/// - `StringToBoolParseStrategy`:
///   - Static constructors
///   - All `ParseOption` cases and combinations
/// - String parsing results
@Suite
struct StringToBoolParseStrategy_Tests {
    @Test
    func bool() throws {
        let param = AnyPathMethodParameter.bool(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Bool.self)
        #expect(try param.parse("true", strategy: .bool) == true)
        #expect(try param.parse("false", strategy: .bool) == false)
    }

    @Test
    func init_options() throws {
        #expect(StringToBoolParseStrategy(options: []).options == [])
        #expect(StringToBoolParseStrategy(options: [.allowOutOfBoundsNumbers]).options == [.allowOutOfBoundsNumbers])
    }

    @Test
    func staticConstructors() throws {
        #expect(StringToBoolParseStrategy.bool(options: []).options == [])
        #expect(StringToBoolParseStrategy.bool(options: [.allowOutOfBoundsNumbers]).options == [.allowOutOfBoundsNumbers])
    }

    @Test
    func optionsComposition() throws {
        #expect(StringToBoolParseStrategy.bool.options([]).options == [])
        #expect(StringToBoolParseStrategy.bool.options([.allowOutOfBoundsNumbers]).options == [.allowOutOfBoundsNumbers])
    }

    @Test
    func bool_noOptions() throws {
        let param = AnyPathMethodParameter.bool(label: "test")
        let options: Set<StringToBoolParseStrategy.ParseOption> = []

        #expect(try param.parse("true", strategy: .bool(options: options)) == true)
        #expect(try param.parse("false", strategy: .bool(options: options)) == false)
        #expect(try param.parse("TRUE", strategy: .bool(options: options)) == true)
        #expect(try param.parse("FALSE", strategy: .bool(options: options)) == false)
        #expect(try param.parse("t", strategy: .bool(options: options)) == true)
        #expect(try param.parse("f", strategy: .bool(options: options)) == false)
        #expect(try param.parse("T", strategy: .bool(options: options)) == true)
        #expect(try param.parse("F", strategy: .bool(options: options)) == false)
        #expect(try param.parse("yes", strategy: .bool(options: options)) == true)
        #expect(try param.parse("no", strategy: .bool(options: options)) == false)
        #expect(try param.parse("YES", strategy: .bool(options: options)) == true)
        #expect(try param.parse("NO", strategy: .bool(options: options)) == false)
        #expect(try param.parse("y", strategy: .bool(options: options)) == true)
        #expect(try param.parse("n", strategy: .bool(options: options)) == false)
        #expect(try param.parse("Y", strategy: .bool(options: options)) == true)
        #expect(try param.parse("N", strategy: .bool(options: options)) == false)
        #expect(try param.parse("1", strategy: .bool(options: options)) == true)
        #expect(try param.parse("0", strategy: .bool(options: options)) == false)
        #expect(try param.parse("1.0", strategy: .bool(options: options)) == true)
        #expect(try param.parse("0.0", strategy: .bool(options: options)) == false)
        #expect(try param.parse("1.00", strategy: .bool(options: options)) == true)
        #expect(try param.parse("0.00", strategy: .bool(options: options)) == false)

        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .bool(options: options))
        }

        // case mismatch
        #expect(throws: (any Error).self) {
            _ = try param.parse("True", strategy: .bool(options: options))
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("False", strategy: .bool(options: options))
        }

        // out of bounds numbers
        #expect(throws: (any Error).self) {
            _ = try param.parse("2.5", strategy: .bool(options: options))
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("2", strategy: .bool(options: options))
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("-1", strategy: .bool(options: options))
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("-1.5", strategy: .bool(options: options))
        }
    }

    @Test
    func bool_caseInsensitive() throws {
        let param = AnyPathMethodParameter.bool(label: "test")
        let options: Set<StringToBoolParseStrategy.ParseOption> = [.caseInsensitive]

        #expect(try param.parse("true", strategy: .bool(options: options)) == true)
        #expect(try param.parse("false", strategy: .bool(options: options)) == false)
        #expect(try param.parse("TRUE", strategy: .bool(options: options)) == true)
        #expect(try param.parse("FALSE", strategy: .bool(options: options)) == false)
        #expect(try param.parse("t", strategy: .bool(options: options)) == true)
        #expect(try param.parse("f", strategy: .bool(options: options)) == false)
        #expect(try param.parse("T", strategy: .bool(options: options)) == true)
        #expect(try param.parse("F", strategy: .bool(options: options)) == false)
        #expect(try param.parse("yes", strategy: .bool(options: options)) == true)
        #expect(try param.parse("no", strategy: .bool(options: options)) == false)
        #expect(try param.parse("YES", strategy: .bool(options: options)) == true)
        #expect(try param.parse("NO", strategy: .bool(options: options)) == false)
        #expect(try param.parse("y", strategy: .bool(options: options)) == true)
        #expect(try param.parse("n", strategy: .bool(options: options)) == false)
        #expect(try param.parse("Y", strategy: .bool(options: options)) == true)
        #expect(try param.parse("N", strategy: .bool(options: options)) == false)
        #expect(try param.parse("1", strategy: .bool(options: options)) == true)
        #expect(try param.parse("0", strategy: .bool(options: options)) == false)
        #expect(try param.parse("1.0", strategy: .bool(options: options)) == true)
        #expect(try param.parse("0.0", strategy: .bool(options: options)) == false)
        #expect(try param.parse("1.00", strategy: .bool(options: options)) == true)
        #expect(try param.parse("0.00", strategy: .bool(options: options)) == false)

        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .bool(options: options))
        }

        // case mismatch
        #expect(try param.parse("True", strategy: .bool(options: options)) == true)
        #expect(try param.parse("False", strategy: .bool(options: options)) == false)

        // out of bounds numbers
        #expect(throws: (any Error).self) {
            _ = try param.parse("2.5", strategy: .bool(options: options))
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("2", strategy: .bool(options: options))
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("-1", strategy: .bool(options: options))
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("-1.5", strategy: .bool(options: options))
        }
    }

    @Test
    func bool_allowOutOfBoundsNumbers() throws {
        let param = AnyPathMethodParameter.bool(label: "test")
        let options: Set<StringToBoolParseStrategy.ParseOption> = [.allowOutOfBoundsNumbers]

        #expect(try param.parse("true", strategy: .bool(options: options)) == true)
        #expect(try param.parse("false", strategy: .bool(options: options)) == false)
        #expect(try param.parse("TRUE", strategy: .bool(options: options)) == true)
        #expect(try param.parse("FALSE", strategy: .bool(options: options)) == false)
        #expect(try param.parse("t", strategy: .bool(options: options)) == true)
        #expect(try param.parse("f", strategy: .bool(options: options)) == false)
        #expect(try param.parse("T", strategy: .bool(options: options)) == true)
        #expect(try param.parse("F", strategy: .bool(options: options)) == false)
        #expect(try param.parse("yes", strategy: .bool(options: options)) == true)
        #expect(try param.parse("no", strategy: .bool(options: options)) == false)
        #expect(try param.parse("YES", strategy: .bool(options: options)) == true)
        #expect(try param.parse("NO", strategy: .bool(options: options)) == false)
        #expect(try param.parse("y", strategy: .bool(options: options)) == true)
        #expect(try param.parse("n", strategy: .bool(options: options)) == false)
        #expect(try param.parse("Y", strategy: .bool(options: options)) == true)
        #expect(try param.parse("N", strategy: .bool(options: options)) == false)
        #expect(try param.parse("1", strategy: .bool(options: options)) == true)
        #expect(try param.parse("0", strategy: .bool(options: options)) == false)
        #expect(try param.parse("1.0", strategy: .bool(options: options)) == true)
        #expect(try param.parse("0.0", strategy: .bool(options: options)) == false)
        #expect(try param.parse("1.00", strategy: .bool(options: options)) == true)
        #expect(try param.parse("0.00", strategy: .bool(options: options)) == false)

        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .bool(options: options))
        }

        // case mismatch
        #expect(throws: (any Error).self) {
            _ = try param.parse("True", strategy: .bool(options: options))
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("False", strategy: .bool(options: options))
        }

        // out of bounds numbers
        #expect(try param.parse("2.5", strategy: .bool(options: options)) == true)
        #expect(try param.parse("2", strategy: .bool(options: options)) == true)
        #expect(try param.parse("-1", strategy: .bool(options: options)) == false)
        #expect(try param.parse("-1.5", strategy: .bool(options: options)) == false)
    }

    @Test
    func bool_caseInsensitive_allowOutOfBoundsNumbers() throws {
        let param = AnyPathMethodParameter.bool(label: "test")
        let options: Set<StringToBoolParseStrategy.ParseOption> = [.caseInsensitive, .allowOutOfBoundsNumbers]

        #expect(try param.parse("true", strategy: .bool(options: options)) == true)
        #expect(try param.parse("false", strategy: .bool(options: options)) == false)
        #expect(try param.parse("TRUE", strategy: .bool(options: options)) == true)
        #expect(try param.parse("FALSE", strategy: .bool(options: options)) == false)
        #expect(try param.parse("t", strategy: .bool(options: options)) == true)
        #expect(try param.parse("f", strategy: .bool(options: options)) == false)
        #expect(try param.parse("T", strategy: .bool(options: options)) == true)
        #expect(try param.parse("F", strategy: .bool(options: options)) == false)
        #expect(try param.parse("yes", strategy: .bool(options: options)) == true)
        #expect(try param.parse("no", strategy: .bool(options: options)) == false)
        #expect(try param.parse("YES", strategy: .bool(options: options)) == true)
        #expect(try param.parse("NO", strategy: .bool(options: options)) == false)
        #expect(try param.parse("y", strategy: .bool(options: options)) == true)
        #expect(try param.parse("n", strategy: .bool(options: options)) == false)
        #expect(try param.parse("Y", strategy: .bool(options: options)) == true)
        #expect(try param.parse("N", strategy: .bool(options: options)) == false)
        #expect(try param.parse("1", strategy: .bool(options: options)) == true)
        #expect(try param.parse("0", strategy: .bool(options: options)) == false)
        #expect(try param.parse("1.0", strategy: .bool(options: options)) == true)
        #expect(try param.parse("0.0", strategy: .bool(options: options)) == false)
        #expect(try param.parse("1.00", strategy: .bool(options: options)) == true)
        #expect(try param.parse("0.00", strategy: .bool(options: options)) == false)
        
        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .bool(options: options))
        }

        // case mismatch
        #expect(try param.parse("True", strategy: .bool(options: options)) == true)
        #expect(try param.parse("False", strategy: .bool(options: options)) == false)

        // out of bounds numbers
        #expect(try param.parse("2.5", strategy: .bool(options: options)) == true)
        #expect(try param.parse("2", strategy: .bool(options: options)) == true)
        #expect(try param.parse("-1", strategy: .bool(options: options)) == false)
        #expect(try param.parse("-1.5", strategy: .bool(options: options)) == false)
    }
}
