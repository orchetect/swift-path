//
//  ArrayToStringFormatStyle Tests.swift
//  SwiftPath
//

import Foundation
import Testing
import SwiftPath

/// This suite tests:
/// - `[Type]` static constructor
/// - Basic string formatting results
///
/// Note that due to associated generics of the array's Element, there is no feasible way to offer
/// a standard static constructor extension on `FormatStyle` with an accompanying `.format()`
/// override on `PathMethodParameter`, as there is no way to express the constraints.
@Suite
struct ArrayToStringFormatStyle_Tests {
    @Test
    func baseline() throws {
        let param = AnyPathMethodParameter<[Int]>(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == [Int].self)
    }

    @Test
    func concreteType_defaultSeparator() throws {
        let param = AnyPathMethodParameter<[Int]>(label: "test")

        let format = ArrayToStringFormatStyle(of: Int.self, transform: .string)

        // default separator
        #expect(param.format([] as [Int], format: format) == "")
        #expect(param.format([1], format: format) == "1")
        #expect(param.format([3, 1, 2], format: format) == "3,1,2")
    }

    @Test
    func concreteType_customSeparator() throws {
        let param = AnyPathMethodParameter<[Int]>(label: "test")

        let format = ArrayToStringFormatStyle(of: Int.self, separator: "|", transform: .string)

        // default separator
        #expect(param.format([] as [Int], format: format) == "")
        #expect(param.format([1], format: format) == "1")
        #expect(param.format([3, 1, 2], format: format) == "3|1|2")
    }

    @Test
    func concreteStatic_defaultSeparator() throws {
        let param = AnyPathMethodParameter<[Int]>(label: "test")

        #expect(param.format([] as [Int], format: [Int].stringFormatStyle(transform: .string)) == "")
        #expect(param.format([1], format: [Int].stringFormatStyle(transform: .string)) == "1")
        #expect(param.format([3, 1, 2], format: [Int].stringFormatStyle(transform: .string)) == "3,1,2")
    }

    @Test
    func concreteStatic_customSeparator() throws {
        let param = AnyPathMethodParameter<[Int]>(label: "test")

        #expect(param.format([] as [Int], format: [Int].stringFormatStyle(separator: "|", transform: .string)) == "")
        #expect(param.format([1], format: [Int].stringFormatStyle(separator: "|", transform: .string)) == "1")
        #expect(param.format([3, 1, 2], format: [Int].stringFormatStyle(separator: "|", transform: .string)) == "3|1|2")
    }

    @Test
    func separatorComposition() throws {
        let param = AnyPathMethodParameter<[Int]>(label: "test")

        #expect(param.format([] as [Int], format: [Int].stringFormatStyle(transform: .string).separator("|")) == "")
        #expect(param.format([1], format: [Int].stringFormatStyle(transform: .string).separator("|")) == "1")
        #expect(param.format([3, 1, 2], format: [Int].stringFormatStyle(transform: .string).separator("|")) == "3|1|2")
    }
}
