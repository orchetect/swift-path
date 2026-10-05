//
//  PathMethodParameter Derivative Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

/// This suite tests implementing a custom type conforming to `PathMethodParameter` in order to
/// bundle additional metadata properties.
///
/// This approach is taken when the `AnyPathMethodParameter` struct vended by the library is insufficient for
/// more complex use cases (needs additional properties stored or its `Value` type further constrained).
@Suite
struct PathParameter_Derivative_Tests {
    @Test
    func init_label_description() throws {
        let param = MyParam<Int>(label: "test", description: "Test")
        #expect(param.label == "test")
        #expect(param.paramDescription == "Test")
        #expect(try param.parse("123", strategy: .int) == 123)
        #expect(param.format(123, format: .string) == "123")
    }

    @Test
    func staticConstructor_bool() {
        let bool: any MyParamPathParameter = .bool(label: "test", description: "Test")
        #expect(bool.label == "test")
        #expect(bool.paramDescription == "Test")
        // can't use `format()` or `parse()` on an `any` protocol because they have associated generics
    }

    @Test
    func staticConstructor_int() {
        let int: any MyParamPathParameter = .int(label: "test", description: "Test")
        #expect(int.label == "test")
        #expect(int.paramDescription == "Test")
        // can't use `format()` or `parse()` on an `any` protocol because they have associated generics
    }

    @Test
    func staticConstructor_string() {
        let string: any MyParamPathParameter = .string(label: "test", description: "Test")
        #expect(string.label == "test")
        #expect(string.paramDescription == "Test")
        // can't use `format()` or `parse()` on an `any` protocol because they have associated generics
    }

    @Test
    func protocolConstrainedFormatMethodParameter() {
        func format<P: MyParamPathParameter>(value: Int, using param: P) -> String where P.Value == Int {
            param.format(value, format: .string)
        }

        #expect(format(value: 123, using: .int(label: "test", description: "Test")) == "123")
    }

    @Test
    func protocolConstrainedParseMethodParameter() throws {
        func parse<P: MyParamPathParameter>(string: String, using param: P) throws -> Int where P.Value == Int {
            try param.parse(string, strategy: .int)
        }

        #expect(try parse(string: "123", using: .int(label: "test", description: "Test")) == 123)
    }
}

// MARK: - Test Types - `MyParam`

private struct MyParam<Value: MyValue> {
    let label: String
    let paramDescription: String

    init(label: String, description: String) {
        self.label = label
        paramDescription = description
    }
}

extension MyParam: PathMethodParameter { }

extension MyParam: MyParamPathParameter { }

// MARK: - Test Types - `MyParamPathParameter`

/// Protocol that extends `PathMethodParameter` by refining the allowed value types and adding custom metadata properties.
private protocol MyParamPathParameter: PathMethodParameter where Value: MyValue {
    var paramDescription: String { get }
}

// MARK: - MyParamPathParameter Static Constructors (Not Exhaustive)

extension MyParamPathParameter where Self == MyParam<Bool> {
    static func bool(label: String, description: String) -> Self {
        Self(label: label, description: description)
    }
}

extension MyParamPathParameter where Self == MyParam<Int> {
    static func int(label: String, description: String) -> Self {
        Self(label: label, description: description)
    }
}

extension MyParamPathParameter where Self == MyParam<String> {
    static func string(label: String, description: String) -> Self {
        Self(label: label, description: description)
    }
}

// MARK: - Test Types - `MyValue`

/// A custom protocol that refines the available value types usable by `MyParamPathParameter`.
private protocol MyValue { }

extension Bool: MyValue { }
extension Int: MyValue { }
extension String: MyValue { }
