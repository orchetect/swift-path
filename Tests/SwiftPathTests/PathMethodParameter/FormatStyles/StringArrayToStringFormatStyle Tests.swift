//
//  StringArrayToStringFormatStyle Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftPath
import Testing

/// This suite tests:
/// - `StringArrayToStringFormatStyle` static constructor
/// - Basic string formatting results
@Suite
struct StringArrayToStringFormatStyle_Tests {
    @Test
    func baseline() {
        let param = AnyPathMethodParameter<[String]>(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == [String].self)
    }

    @Test
    func staticConstructor() {
        let param = AnyPathMethodParameter<[String]>(label: "test")

        // default separator
        #expect(param.format(["foo"], format: .string) == "foo")
        #expect(param.format(["foo", "bar"], format: .string) == "foo,bar")

        // custom separator
        #expect(param.format(["foo"], format: .string(separator: "|")) == "foo")
        #expect(param.format(["foo", "bar"], format: .string(separator: "|")) == "foo|bar")
    }

    @Test
    func separatorComposition() {
        let param = AnyPathMethodParameter<[String]>(label: "test")

        #expect(param.format(["foo"], format: .string.separator("|")) == "foo")
        #expect(param.format(["foo", "bar"], format: .string.separator("|")) == "foo|bar")
    }
}
