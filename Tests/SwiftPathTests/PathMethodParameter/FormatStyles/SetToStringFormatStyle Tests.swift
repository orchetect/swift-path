//
//  SetToStringFormatStyle Tests.swift
//  SwiftPath
//

import Foundation
import Testing
import SwiftPath

/// This suite tests:
/// - `Set<Type>` static constructor
/// - Basic string formatting results
///
/// Note that due to associated generics of the set's Element, there is no feasible way to offer
/// a standard static constructor extension on `FormatStyle` with an accompanying `.format()`
/// override on `PathMethodParameter`, as there is no way to express the constraints.
@Suite
struct SetToStringFormatStyle_Tests {
    @Test
    func baseline() throws {
        let param = AnyPathMethodParameter<Set<Int>>(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Set<Int>.self)
    }

    @Test
    func concreteType_defaultSeparator() throws {
        let param = AnyPathMethodParameter<Set<Int>>(label: "test")

        let format = SetToStringFormatStyle(of: Int.self, transform: .string)

        #expect(param.format([] as Set<Int>, format: format) == "")

        #expect(param.format(Set([1]), format: format) == "1")

        let a = param.format(Set([2, 1]), format: format)
        #expect(a == "1,2" || a == "2,1")
    }

    @Test
    func concreteType_customSeparator() throws {
        let param = AnyPathMethodParameter<Set<Int>>(label: "test")

        let format = SetToStringFormatStyle(of: Int.self, separator: "|", transform: .string)

        #expect(param.format([] as Set<Int>, format: format) == "")

        #expect(param.format(Set([1]), format: format) == "1")

        let a = param.format(Set([2, 1]), format: format)
        #expect(a == "1|2" || a == "2|1")
    }

    @Test
    func concreteStatic_defaultSeparator() throws {
        let param = AnyPathMethodParameter<Set<Int>>(label: "test")

        #expect(param.format([] as Set<Int>, format: Set<Int>.stringFormatStyle(transform: .string)) == "")

        #expect(param.format(Set([1]), format: Set<Int>.stringFormatStyle(transform: .string)) == "1")

        let a = param.format(Set([2, 1]), format: Set<Int>.stringFormatStyle(transform: .string))
        #expect(a == "1,2" || a == "2,1")
    }

    @Test
    func concreteStatic_customSeparator() throws {
        let param = AnyPathMethodParameter<Set<Int>>(label: "test")

        #expect(param.format([] as Set<Int>, format: Set<Int>.stringFormatStyle(separator: "|", transform: .string)) == "")

        #expect(param.format(Set([1]), format: Set<Int>.stringFormatStyle(separator: "|", transform: .string)) == "1")

        let a = param.format(Set([2, 1]), format: Set<Int>.stringFormatStyle(separator: "|", transform: .string))
        #expect(a == "1|2" || a == "2|1")
    }

    @Test
    func composition_separator() throws {
        let param = AnyPathMethodParameter<Set<Int>>(label: "test")

        #expect(param.format([] as Set<Int>, format: Set<Int>.stringFormatStyle(transform: .string).separator("|")) == "")

        #expect(param.format(Set([1]), format: Set<Int>.stringFormatStyle(transform: .string).separator("|")) == "1")

        let a = param.format(Set([2, 1]), format: Set<Int>.stringFormatStyle(transform: .string).separator("|"))
        #expect(a == "1|2" || a == "2|1")
    }
}
