//
//  StringArrayToStringFormatStyle Tests.swift
//  SwiftPath
//

import Foundation
import Testing
import SwiftPath

/// This suite tests:
/// - `StringArrayToStringFormatStyle` static constructor
/// - Basic string formatting results
@Suite
struct StringArrayToStringFormatStyle_Tests {
    @Test
    func baseline() throws {
        let param = AnyPathMethodParameter<[String]>(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == [String].self)
    }

    @Test
    func staticConstructor() throws {
        let param = AnyPathMethodParameter<[String]>(label: "test")

        // default separator
        #expect(param.format(["foo"], format: .string) == "foo")
        #expect(param.format(["foo", "bar"], format: .string) == "foo,bar")

        // custom separator
        #expect(param.format(["foo"], format: .string(separator: "|")) == "foo")
        #expect(param.format(["foo", "bar"], format: .string(separator: "|")) == "foo|bar")
    }

    @Test
    func separatorComposition() throws {
        let param = AnyPathMethodParameter<[String]>(label: "test")

        #expect(param.format(["foo"], format: .string.separator("|")) == "foo")
        #expect(param.format(["foo", "bar"], format: .string.separator("|")) == "foo|bar")
    }
}
