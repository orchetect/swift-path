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
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func baseline() {
        let param = AnyPathMethodParameter<[String]>(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == [String].self)
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
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

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func separatorComposition() {
        let param = AnyPathMethodParameter<[String]>(label: "test")

        #expect(param.format(["foo"], format: .string.separator("|")) == "foo")
        #expect(param.format(["foo", "bar"], format: .string.separator("|")) == "foo|bar")
    }
}
