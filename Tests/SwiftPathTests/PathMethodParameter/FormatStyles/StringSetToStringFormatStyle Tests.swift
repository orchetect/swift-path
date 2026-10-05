//
//  StringSetToStringFormatStyle Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftPath
import Testing

/// This suite tests:
/// - `StringSetToStringFormatStyle` static constructor
/// - Basic string formatting results
@Suite
struct StringSetToStringFormatStyle_Tests {
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func baseline() {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Set<String>.self)
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func concreteType_defaultSeparator() {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        let format = StringSetToStringFormatStyle()

        let a = param.format(Set(["b"]), format: format)
        let b = param.format(Set(["b", "b"]), format: format)
        let c = param.format(Set(["b", "a"]), format: format)
        #expect(a == "b")
        #expect(b == "b")
        #expect(c == "a,b" || c == "b,a")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func concreteType_customSeparator() {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        let format = StringSetToStringFormatStyle(separator: "|")

        let a = param.format(Set(["b"]), format: format)
        let b = param.format(Set(["b", "b"]), format: format)
        let c = param.format(Set(["b", "a"]), format: format)
        #expect(a == "b")
        #expect(b == "b")
        #expect(c == "a|b" || c == "b|a")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func staticConstructor_defaultSeparator() {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        let a = param.format(Set(["b"]), format: .string)
        let b = param.format(Set(["b", "b"]), format: .string)
        let c = param.format(Set(["b", "a"]), format: .string)
        #expect(a == "b")
        #expect(b == "b")
        #expect(c == "a,b" || c == "b,a")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func staticConstructor_customSeparator() {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        let a = param.format(Set(["b"]), format: .string(separator: "|"))
        let b = param.format(Set(["b", "b"]), format: .string(separator: "|"))
        let c = param.format(Set(["b", "a"]), format: .string(separator: "|"))
        #expect(a == "b")
        #expect(b == "b")
        #expect(c == "a|b" || c == "b|a")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test // TODO: might need to enable test only if locale language is English
    func staticConstructor_customSortComparator() {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        let a = param.format(Set(["b"]), format: .string(sortComparator: .unitTestComparator))
        let b = param.format(Set(["b", "b"]), format: .string(sortComparator: .unitTestComparator))
        let c = param.format(Set(["c", "a", "b"]), format: .string(sortComparator: .unitTestComparator))
        #expect(a == "b")
        #expect(b == "b")
        #expect(c == "a,b,c")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test // TODO: might need to enable test only if locale language is English
    func staticConstructor_customSeparator_customSortComparator() {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        let a = param.format(Set(["b"]), format: .string(separator: "|", sortComparator: .unitTestComparator))
        let b = param.format(Set(["b", "b"]), format: .string(separator: "|", sortComparator: .unitTestComparator))
        let c = param.format(Set(["c", "a", "b"]), format: .string(separator: "|", sortComparator: .unitTestComparator))
        #expect(a == "b")
        #expect(b == "b")
        #expect(c == "a|b|c")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func composition_separator() {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        let a = param.format(Set(["b"]), format: .string.separator("|"))
        let b = param.format(Set(["b", "b"]), format: .string.separator("|"))
        let c = param.format(Set(["b", "a"]), format: .string.separator("|"))
        #expect(a == "b")
        #expect(b == "b")
        #expect(c == "a|b" || c == "b|a")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test // TODO: might need to enable test only if locale language is English
    func composition_separator_sortComparator() {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        let string = param.format(Set(["c", "a", "b"]), format: .string.separator("|").sortComparator(.unitTestComparator))
        #expect(string == "a|b|c")
    }
}
