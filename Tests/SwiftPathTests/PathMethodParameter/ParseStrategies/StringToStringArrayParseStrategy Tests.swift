//
//  StringToStringArrayParseStrategy Tests.swift
//  SwiftPath
//

import Testing
import SwiftPath

/// This suite tests:
/// - `StringToStringArrayParseStrategy` static constructors
/// - String parsing results
@Suite
struct StringToStringArrayParseStrategy_Tests {
    @Test
    func baseline() throws {
        let param = AnyPathMethodParameter<[String]>(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == [String].self)
    }

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
