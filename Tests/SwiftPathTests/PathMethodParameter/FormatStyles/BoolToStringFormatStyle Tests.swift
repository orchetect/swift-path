//
//  BoolToStringFormatStyle Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

/// This suite tests:
/// - `AnyPathMethodParameter` static constructor for `Bool` type:
///   - Compiles successfully
///   - Has correct associated generic type
///   - Label property is correctly stored
/// - `BoolToStringFormatStyle` static constructors
/// - Basic string formatting results
@Suite
struct BoolToStringFormatStyle_Tests {
    @Test
    func bool() {
        let param = AnyPathMethodParameter.bool(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Bool.self)
        #expect(param.format(true as Bool, format: .string) == "true")
        #expect(param.format(false as Bool, format: .string) == "false")
    }
}
