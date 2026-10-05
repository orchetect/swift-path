//
//  StringToStringParseStrategy Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

/// This suite tests:
/// - `AnyPathMethodParameter` static constructor for `Bool` type:
///   - Compiles successfully
///   - Has correct associated generic type
///   - Label property is correctly stored
/// - `StringToStringParseStrategy`:
///   - Static constructors
///   - All `ParseOption` cases and combinations
/// - String parsing results
@Suite
struct StringToStringParseStrategy_Tests {
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func string() throws {
        let param = AnyPathMethodParameter.string(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == String.self)
        #expect(try param.parse("", strategy: .string) == "")
        #expect(try param.parse("foo", strategy: .string) == "foo")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func init_options() {
        #expect(StringToStringParseStrategy(options: []).options == [])
        #expect(StringToStringParseStrategy(options: [.rejectEmpty]).options == [.rejectEmpty])
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func staticConstructors() {
        #expect(StringToStringParseStrategy.string(options: []).options == [])
        #expect(StringToStringParseStrategy.string(options: [.rejectEmpty]).options == [.rejectEmpty])
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func optionsComposition() {
        #expect(StringToStringParseStrategy.string.options([]).options == [])
        #expect(StringToStringParseStrategy.string.options([.rejectEmpty]).options == [.rejectEmpty])
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func string_noOptions() throws {
        let param = AnyPathMethodParameter.string(label: "test")
        let options: Set<StringToStringParseStrategy.ParseOption> = []

        #expect(try param.parse("", strategy: .string(options: options)) == "")
        #expect(try param.parse(" ", strategy: .string(options: options)) == " ")
        #expect(try param.parse(" \t ", strategy: .string(options: options)) == " \t ")
        #expect(try param.parse(" \t\n ", strategy: .string(options: options)) == " \t\n ")
        #expect(try param.parse(" abc 123 !@#$%^&*() ", strategy: .string(options: options)) == " abc 123 !@#$%^&*() ")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func string_rejectEmpty() throws {
        let param = AnyPathMethodParameter.string(label: "test")
        let options: Set<StringToStringParseStrategy.ParseOption> = [.rejectEmpty]

        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .string(options: options))
        }
        #expect(try param.parse(" ", strategy: .string(options: options)) == " ")
        #expect(try param.parse(" \t ", strategy: .string(options: options)) == " \t ")
        #expect(try param.parse(" \t\n ", strategy: .string(options: options)) == " \t\n ")
        #expect(try param.parse(" abc 123 !@#$%^&*() ", strategy: .string(options: options)) == " abc 123 !@#$%^&*() ")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func string_rejectWhitespaceOnly() throws {
        let param = AnyPathMethodParameter.string(label: "test")
        let options: Set<StringToStringParseStrategy.ParseOption> = [.rejectWhitespaceOnly]

        #expect(throws: (any Error).self) {
            _ = try param.parse("", strategy: .string(options: options))
        }
        #expect(throws: (any Error).self) {
            try param.parse(" ", strategy: .string(options: options))
        }
        #expect(throws: (any Error).self) {
            try param.parse(" \t ", strategy: .string(options: options))
        }
        #expect(throws: (any Error).self) {
            try param.parse(" \t\n ", strategy: .string(options: options))
        }
        #expect(try param.parse(" abc 123 !@#$%^&*() ", strategy: .string(options: options)) == " abc 123 !@#$%^&*() ")
    }
}
