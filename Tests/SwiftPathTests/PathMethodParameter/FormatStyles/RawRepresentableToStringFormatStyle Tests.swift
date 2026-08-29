//
//  RawRepresentableToStringFormatStyle Tests.swift
//  SwiftPath
//

import Foundation
import Testing
import SwiftPath

/// This suite tests:
/// - `RawRepresentableToStringFormatStyle` static constructors
/// - Basic string formatting results
@Suite
struct RawRepresentableToStringFormatStyle_Tests {
    @Test
    func baseline() throws {
        let param = AnyPathMethodParameter<MyEnum>(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == MyEnum.self)
    }

    /// Tests using the `<TYPE>.rawValueFormatStyle` static constructor
    @Test
    func rawRepresentableExtension() throws {
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
