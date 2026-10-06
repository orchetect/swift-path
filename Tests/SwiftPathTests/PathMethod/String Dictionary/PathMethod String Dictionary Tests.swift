//
//  PathMethod String Dictionary Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftPath
import Testing

/// This suite tests implementing a `Path`, `PathMethod`, and `PathMethodParameterValues` usable with a
/// `String` dictionary.
@Suite
struct PathMethod_String_Dictionary_Tests {
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func init_method_stringDictionary() throws {
        let path: MyPath = .foo
        let method = try path.method(stringDictionary: ["int": "123", "string": "Test"])

        guard case let .foo(foo) = method
        else { Issue.record(); return }

        #expect(foo.int == 123)
        #expect(foo.string == "Test")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func init_method_stringDictionary_invalidValues() throws {
        // no parameters
        #expect(throws: (any Error).self) {
            _ = try MyPath.foo.method(stringDictionary: [:])
        }
        // not all expected parameters are present
        #expect(throws: (any Error).self) {
            _ = try MyPath.foo.method(stringDictionary: ["int": "123"])
        }
        // all expected parameters are present, but also one extra unexpected parameter
        #expect(throws: (any Error).self) {
            _ = try MyPath.foo.method(stringDictionary: ["int": "123", "string": "Test", "extra": "foobar"])
        }
        // case-sensitive key names
        #expect(throws: (any Error).self) {
            _ = try MyPath.foo.method(stringDictionary: ["INT": "123", "STRING": "Test"])
        }
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func stringDictionary() {
        let method = MyMethod.foo(FooValues(int: 123, string: "Test"))
        let stringDictionary = method.stringDictionary
        #expect(stringDictionary == ["int": "123", "string": "Test"])
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func StringDictionaryPath_typealias() {
        let _: any StringDictionaryPath = MyPath.bar
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func StringDictionaryPathMethod_typealias() {
        let _: any StringDictionaryPathMethod = MyMethod.foo(FooValues(int: 123, string: "Test"))
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func StringDictionaryPathMethodParameterValues_typealias() {
        let _: any StringDictionaryPathMethodParameterValues = FooValues(int: 123, string: "Test")
        let _: any StringDictionaryPathMethodParameterValues = BarValues(bool: true)
    }
}

// MARK: - Test Types - `MyPath`

private enum MyPath: String, Sendable, CaseIterable {
    case foo
    case bar
}

extension MyPath: Path { }

extension MyPath: IdentifiablePathComponent {
    var pathComponentID: Self {
        self
    }
}

extension MyPath: ConstructiblePathComponent {
    static func constructor(for pathComponent: MyPath) -> any PathComponentConstructor<MyPath> {
        switch pathComponent {
        case .foo: MethodConstructor { .foo }
        case .bar: MethodConstructor { .bar }
        }
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension MyPath: StringDictionaryMethodFormablePath {
    typealias StringDictionaryMethod = MyMethod

    func method(stringDictionary: [String: String]) throws -> StringDictionaryMethod {
        switch self {
        case .foo:
            let myValues = try FooValues(stringDictionary: stringDictionary)
            return .foo(myValues)
        case .bar:
            let myValues = try BarValues(stringDictionary: stringDictionary)
            return .bar(myValues)
        }
    }
}

// MARK: - Test Types - `MyMethod`

private enum MyMethod: Equatable {
    case foo(FooValues)
    case bar(BarValues)
}

extension MyMethod: PathMethod {
    var path: MyPath {
        switch self {
        case .foo: .foo
        case .bar: .bar
        }
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension MyMethod: StringDictionaryFormattablePathMethod {
    var formattableStringDictionary: any StringDictionaryFormattablePathMethodParameterValues {
        switch self {
        case let .foo(foo): foo
        case let .bar(bar): bar
        }
    }
}

// MARK: - Test Types - `FooValues`

private struct FooValues: Equatable {
    let int: Int
    let string: String

    init(int: Int, string: String) {
        self.int = int
        self.string = string
    }
}

extension FooValues {
    static let parameters = (AnyPathMethodParameter.int(label: "int"), AnyPathMethodParameter.string(label: "string"))
}

// MARK: - Test Types - `FooValues` - `StringDictionary`

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FooValues: StringDictionaryParseablePathMethodParameterValues {
    static let stringDictionaryParseStrategy = StringDictionaryParseStrategy()

    struct StringDictionaryParseStrategy: ParseStrategy {
        func parse(_ value: [String: String]) throws -> FooValues {
            guard let intString = value["int"],
                  let stringString = value["string"],
                  value.count == 2
            else { throw PathMethodParametersParseError.invalidParameters }
            let int = try parameters.0.parse(intString, strategy: .int)
            let string = try parameters.1.parse(stringString, strategy: .string)
            return FooValues(int: int, string: string)
        }

        init() { }
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FooValues: StringDictionaryFormattablePathMethodParameterValues {
    static let stringDictionaryFormatStyle = StringDictionaryFormatStyle()

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    struct StringDictionaryFormatStyle: FormatStyle {
        func format(_ value: FooValues) -> [String: String] {
            [
                parameters.0.label: parameters.0.format(value.int, format: .string),
                parameters.1.label: parameters.1.format(value.string, format: .string)
            ]
        }
    }
}

// MARK: - Test Types - `BarValues`

private struct BarValues: Equatable {
    let bool: Bool

    init(bool: Bool) {
        self.bool = bool
    }
}

extension BarValues {
    static let parameter = AnyPathMethodParameter.bool(label: "bool")
}

// MARK: - Test Types - `BarValues` - `StringDictionary`

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension BarValues: StringDictionaryParseablePathMethodParameterValues {
    static let stringDictionaryParseStrategy = StringDictionaryParseStrategy()

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    struct StringDictionaryParseStrategy: ParseStrategy {
        func parse(_ value: [String: String]) throws -> BarValues {
            guard let boolString = value["bool"],
                  value.count == 1
            else { throw PathMethodParametersParseError.invalidParameters }
            let bool = try parameter.parse(boolString, strategy: .bool)
            return BarValues(bool: bool)
        }

        init() { }
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension BarValues: StringDictionaryFormattablePathMethodParameterValues {
    static let stringDictionaryFormatStyle = StringDictionaryFormatStyle()

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    struct StringDictionaryFormatStyle: FormatStyle {
        func format(_ value: BarValues) -> [String: String] {
            [parameter.label: parameter.format(value.bool, format: .string)]
        }
    }
}
