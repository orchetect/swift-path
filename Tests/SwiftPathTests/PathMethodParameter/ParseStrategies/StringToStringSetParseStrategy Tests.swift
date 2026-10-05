//
//  StringToStringSetParseStrategy Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

/// This suite tests:
/// - `StringToStringSetParseStrategy` static constructors
/// - String parsing results
@Suite
struct StringToStringSetParseStrategy_Tests {
    @Test
    func baseline() {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Set<String>.self)
    }

    @Test
    func staticConstructor_defaultSeparator() throws {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        #expect(try param.parse("", strategy: .stringSet()) == [])
        #expect(try param.parse(" ", strategy: .stringSet()) == [" "])
        #expect(try param.parse(",", strategy: .stringSet()) == [""]) // "" is de-duped
        #expect(try param.parse("foo", strategy: .stringSet()) == ["foo"])
        #expect(try param.parse("foo,bar", strategy: .stringSet()) == ["foo", "bar"])
        #expect(try param.parse("foo,foo,bar", strategy: .stringSet()) == ["foo", "bar"]) // "foo" is de-duped
        #expect(try param.parse(",foo,bar,", strategy: .stringSet()) == ["", "foo", "bar"]) // "" is de-duped
    }

    @Test
    func staticConstructor_customSeparator() throws {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        #expect(try param.parse("", strategy: .stringSet(separator: "|")) == [])
        #expect(try param.parse(" ", strategy: .stringSet(separator: "|")) == [" "])
        #expect(try param.parse("|", strategy: .stringSet(separator: "|")) == [""]) // "" is de-duped
        #expect(try param.parse("foo", strategy: .stringSet(separator: "|")) == ["foo"])
        #expect(try param.parse("foo|bar", strategy: .stringSet(separator: "|")) == ["foo", "bar"])
        #expect(try param.parse("foo|foo|bar", strategy: .stringSet(separator: "|")) == ["foo", "bar"]) // "foo" is de-duped
        #expect(try param.parse("|foo|bar|", strategy: .stringSet(separator: "|")) == ["", "foo", "bar"]) // "" is de-duped
    }

    @Test
    func composition_separator_defaultSeparator() throws {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        #expect(try param.parse("", strategy: .stringSet) == [])
        #expect(try param.parse(" ", strategy: .stringSet) == [" "])
        #expect(try param.parse(",", strategy: .stringSet) == [""]) // "" is de-duped
        #expect(try param.parse("foo", strategy: .stringSet) == ["foo"])
        #expect(try param.parse("foo,bar", strategy: .stringSet) == ["foo", "bar"])
        #expect(try param.parse("foo,foo,bar", strategy: .stringSet) == ["foo", "bar"]) // "foo" is de-duped
        #expect(try param.parse(",foo,bar,", strategy: .stringSet) == ["", "foo", "bar"]) // "" is de-duped
    }

    @Test
    func composition_separator_customSeparator() throws {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        #expect(try param.parse("", strategy: .stringSet.separator("|")) == [])
        #expect(try param.parse(" ", strategy: .stringSet.separator("|")) == [" "])
        #expect(try param.parse("|", strategy: .stringSet.separator("|")) == [""]) // "" is de-duped
        #expect(try param.parse("foo", strategy: .stringSet.separator("|")) == ["foo"])
        #expect(try param.parse("foo|bar", strategy: .stringSet.separator("|")) == ["foo", "bar"])
        #expect(try param.parse("foo|foo|bar", strategy: .stringSet.separator("|")) == ["foo", "bar"]) // "foo" is de-duped
        #expect(try param.parse("|foo|bar|", strategy: .stringSet.separator("|")) == ["", "foo", "bar"]) // "" is de-duped
    }
}
