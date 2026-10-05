//
//  SetToStringFormatStyle Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftPath
import Testing

/// This suite tests:
/// - `Set<Type>` static constructor
/// - Basic string formatting results
///
/// Note that due to associated generics of the set's Element, there is no feasible way to offer
/// a standard static constructor extension on `FormatStyle` with an accompanying `.format()`
/// override on `PathMethodParameter`, as there is no way to express the constraints.
@Suite
struct SetToStringFormatStyle_Tests {
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func baseline() {
        let param = AnyPathMethodParameter<Set<Int>>(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Set<Int>.self)
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func concreteType_defaultSeparator() {
        let param = AnyPathMethodParameter<Set<Int>>(label: "test")

        let format = SetToStringFormatStyle(of: Int.self, transform: .string)

        #expect(param.format([] as Set<Int>, format: format) == "")

        #expect(param.format(Set([1]), format: format) == "1")

        let a = param.format(Set([2, 1]), format: format)
        #expect(a == "1,2" || a == "2,1")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func concreteType_customSeparator() {
        let param = AnyPathMethodParameter<Set<Int>>(label: "test")

        let format = SetToStringFormatStyle(of: Int.self, separator: "|", transform: .string)

        #expect(param.format([] as Set<Int>, format: format) == "")

        #expect(param.format(Set([1]), format: format) == "1")

        let a = param.format(Set([2, 1]), format: format)
        #expect(a == "1|2" || a == "2|1")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func concreteStatic_defaultSeparator() {
        let param = AnyPathMethodParameter<Set<Int>>(label: "test")

        #expect(param.format([] as Set<Int>, format: Set<Int>.stringFormatStyle(transform: .string)) == "")

        #expect(param.format(Set([1]), format: Set<Int>.stringFormatStyle(transform: .string)) == "1")

        let a = param.format(Set([2, 1]), format: Set<Int>.stringFormatStyle(transform: .string))
        #expect(a == "1,2" || a == "2,1")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func concreteStatic_customSeparator() {
        let param = AnyPathMethodParameter<Set<Int>>(label: "test")

        #expect(param.format([] as Set<Int>, format: Set<Int>.stringFormatStyle(separator: "|", transform: .string)) == "")

        #expect(param.format(Set([1]), format: Set<Int>.stringFormatStyle(separator: "|", transform: .string)) == "1")

        let a = param.format(Set([2, 1]), format: Set<Int>.stringFormatStyle(separator: "|", transform: .string))
        #expect(a == "1|2" || a == "2|1")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func composition_separator() {
        let param = AnyPathMethodParameter<Set<Int>>(label: "test")

        #expect(param.format([] as Set<Int>, format: Set<Int>.stringFormatStyle(transform: .string).separator("|")) == "")

        #expect(param.format(Set([1]), format: Set<Int>.stringFormatStyle(transform: .string).separator("|")) == "1")

        let a = param.format(Set([2, 1]), format: Set<Int>.stringFormatStyle(transform: .string).separator("|"))
        #expect(a == "1|2" || a == "2|1")
    }
}
