//
//  RawRepresentableToStringFormatStyle Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftPath
import Testing

/// This suite tests:
/// - `RawRepresentableToStringFormatStyle` static constructors
/// - Basic string formatting results
@Suite
struct RawRepresentableToStringFormatStyle_Tests {
    @Test
    func baseline() {
        let param = AnyPathMethodParameter<MyEnum>(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == MyEnum.self)
    }

    /// Tests using the `<TYPE>.rawValueFormatStyle` static constructor
    @Test
    func rawRepresentableExtension() {
        let param = AnyPathMethodParameter<MyEnum>(label: "test")
        #expect(param.format(.foo, format: MyEnum.rawValueFormatStyle) == "foo")
        #expect(param.format(.bar, format: MyEnum.rawValueFormatStyle) == "bar")
    }
}

// MARK: - Test Types

private enum MyEnum: String {
    case foo
    case bar
}
