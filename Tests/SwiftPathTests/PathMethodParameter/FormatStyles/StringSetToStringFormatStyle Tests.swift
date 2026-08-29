//
//  StringSetToStringFormatStyle Tests.swift
//  SwiftPath
//

import Foundation
import Testing
import SwiftPath

/// This suite tests:
/// - `StringSetToStringFormatStyle` static constructor
/// - Basic string formatting results
@Suite
struct StringSetToStringFormatStyle_Tests {
    @Test
    func baseline() throws {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Set<String>.self)
    }

    @Test
    func concreteType_defaultSeparator() throws {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        let format = StringSetToStringFormatStyle()

        let a = param.format(Set(["b"]), format: format)
        let b = param.format(Set(["b", "b"]), format: format)
        let c = param.format(Set(["b", "a"]), format: format)
        #expect(a == "b")
        #expect(b == "b")
        #expect(c == "a,b" || c == "b,a")
    }

    @Test
    func concreteType_customSeparator() throws {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        let format = StringSetToStringFormatStyle(separator: "|")

        let a = param.format(Set(["b"]), format: format)
        let b = param.format(Set(["b", "b"]), format: format)
        let c = param.format(Set(["b", "a"]), format: format)
        #expect(a == "b")
        #expect(b == "b")
        #expect(c == "a|b" || c == "b|a")
    }

    @Test
    func staticConstructor_defaultSeparator() throws {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        let a = param.format(Set(["b"]), format: .string)
        let b = param.format(Set(["b", "b"]), format: .string)
        let c = param.format(Set(["b", "a"]), format: .string)
        #expect(a == "b")
        #expect(b == "b")
        #expect(c == "a,b" || c == "b,a")
    }

    @Test
    func staticConstructor_customSeparator() throws {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        let a = param.format(Set(["b"]), format: .string(separator: "|"))
        let b = param.format(Set(["b", "b"]), format: .string(separator: "|"))
        let c = param.format(Set(["b", "a"]), format: .string(separator: "|"))
        #expect(a == "b")
        #expect(b == "b")
        #expect(c == "a|b" || c == "b|a")
    }

    @Test // TODO: might need to enable test only if locale language is English
    func staticConstructor_customSortComparator() throws {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        let a = param.format(Set(["b"]), format: .string(sortComparator: .localized))
        let b = param.format(Set(["b", "b"]), format: .string(sortComparator: .localized))
        let c = param.format(Set(["c", "a", "b"]), format: .string(sortComparator: .localized))
        #expect(a == "b")
        #expect(b == "b")
        #expect(c == "a,b,c")
    }

    @Test // TODO: might need to enable test only if locale language is English
    func staticConstructor_customSeparator_customSortComparator() throws {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        let a = param.format(Set(["b"]), format: .string(separator: "|", sortComparator: .localized))
        let b = param.format(Set(["b", "b"]), format: .string(separator: "|", sortComparator: .localized))
        let c = param.format(Set(["c", "a", "b"]), format: .string(separator: "|", sortComparator: .localized))
        #expect(a == "b")
        #expect(b == "b")
        #expect(c == "a|b|c")
    }

    @Test
    func composition_separator() throws {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        let a = param.format(Set(["b"]), format: .string.separator("|"))
        let b = param.format(Set(["b", "b"]), format: .string.separator("|"))
        let c = param.format(Set(["b", "a"]), format: .string.separator("|"))
        #expect(a == "b")
        #expect(b == "b")
        #expect(c == "a|b" || c == "b|a")
    }

    @Test // TODO: might need to enable test only if locale language is English
    func composition_separator_sortComparator() throws {
        let param = AnyPathMethodParameter<Set<String>>(label: "test")

        let string = param.format(Set(["c", "a", "b"]), format: .string.separator("|").sortComparator(.localized))
        #expect(string == "a|b|c")
    }
}
