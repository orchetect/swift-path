//
//  StringToStringArrayParseStrategy Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

/// This suite tests:
/// - `StringToStringArrayParseStrategy` static constructors
/// - String parsing results
@Suite
struct StringToStringArrayParseStrategy_Tests {
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func baseline() {
        let param = AnyPathMethodParameter<[String]>(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == [String].self)
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func staticConstructor_defaultSeparator() throws {
        let param = AnyPathMethodParameter<[String]>(label: "test")

        #expect(try param.parse("", strategy: .stringArray()) == [])
        #expect(try param.parse(" ", strategy: .stringArray()) == [" "])
        #expect(try param.parse(",", strategy: .stringArray()) == ["", ""])
        #expect(try param.parse("foo", strategy: .stringArray()) == ["foo"])
        #expect(try param.parse("foo,bar", strategy: .stringArray()) == ["foo", "bar"])
        #expect(try param.parse(",foo,bar,", strategy: .stringArray()) == ["", "foo", "bar", ""])
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func staticConstructor_customSeparator() throws {
        let param = AnyPathMethodParameter<[String]>(label: "test")

        #expect(try param.parse("", strategy: .stringArray(separator: "|")) == [])
        #expect(try param.parse(" ", strategy: .stringArray(separator: "|")) == [" "])
        #expect(try param.parse("|", strategy: .stringArray(separator: "|")) == ["", ""])
        #expect(try param.parse("foo", strategy: .stringArray(separator: "|")) == ["foo"])
        #expect(try param.parse("foo|bar", strategy: .stringArray(separator: "|")) == ["foo", "bar"])
        #expect(try param.parse("|foo|bar|", strategy: .stringArray(separator: "|")) == ["", "foo", "bar", ""])
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func separatorComposition_defaultSeparator() throws {
        let param = AnyPathMethodParameter<[String]>(label: "test")

        #expect(try param.parse("", strategy: .stringArray) == [])
        #expect(try param.parse(" ", strategy: .stringArray) == [" "])
        #expect(try param.parse(",", strategy: .stringArray) == ["", ""])
        #expect(try param.parse("foo", strategy: .stringArray) == ["foo"])
        #expect(try param.parse("foo,bar", strategy: .stringArray) == ["foo", "bar"])
        #expect(try param.parse(",foo,bar,", strategy: .stringArray) == ["", "foo", "bar", ""])
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func separatorComposition_customSeparator() throws {
        let param = AnyPathMethodParameter<[String]>(label: "test")

        #expect(try param.parse("", strategy: .stringArray.separator("|")) == [])
        #expect(try param.parse(" ", strategy: .stringArray.separator("|")) == [" "])
        #expect(try param.parse("|", strategy: .stringArray.separator("|")) == ["", ""])
        #expect(try param.parse("foo", strategy: .stringArray.separator("|")) == ["foo"])
        #expect(try param.parse("foo|bar", strategy: .stringArray.separator("|")) == ["foo", "bar"])
        #expect(try param.parse("|foo|bar|", strategy: .stringArray.separator("|")) == ["", "foo", "bar", ""])
    }
}
