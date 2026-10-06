//
//  PathMethodParameterValues Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftPath
import Testing

/// This suite tests conforming a basic data structure to `PathMethodParameterValues`.
/// It implements two generic parse strategies and format styles for `[Any]` and `[String: Any]`.
/// It tests the use of the `cast(values:required:optional:)` global method as well.
@Suite
struct PathMethodParameterValues_Tests {
    @available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
    @Test
    func parseAnyArray_A() throws {
        let method = try MyMethod([123, "Test"], strategy: .anyArray)
        #expect(method.int == 123)
        #expect(method.string == "Test")
        #expect(method.bool == nil)
    }

    @available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
    @Test
    func parseAnyArray_B() throws {
        #expect(throws: (any Error).self) {
            try MyMethod([123, "Test", (nil as Bool?) as Any], strategy: .anyArray)
        }
    }

    @available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
    @Test
    func parseAnyArray_C() throws {
        let method = try MyMethod([123, "Test", true], strategy: .anyArray)
        #expect(method.int == 123)
        #expect(method.string == "Test")
        #expect(method.bool == true)
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func formatAnyArray_A() throws {
        let array = MyMethod(int: 123, string: "Test", bool: nil).formatted(.anyArray)
        try #require(array.count == 2)
        guard let int = array[0] as? Int,
              let string = array[1] as? String
        else { Issue.record(); return }
        #expect(int == 123)
        #expect(string == "Test")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func formatAnyArray_B() throws {
        let array = MyMethod(int: 123, string: "Test", bool: true).formatted(.anyArray)
        try #require(array.count == 3)
        guard let int = array[0] as? Int,
              let string = array[1] as? String,
              let bool = array[2] as? Bool
        else { Issue.record(); return }
        #expect(int == 123)
        #expect(string == "Test")
        #expect(bool == true)
    }

    @available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
    @Test
    func parseDictionary_A() throws {
        let method = try MyMethod(["int": 123, "string": "Test"], strategy: .anyDictionary)
        #expect(method.int == 123)
        #expect(method.string == "Test")
        #expect(method.bool == nil)
    }

    @available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
    @Test
    func parseDictionary_B() throws {
        let method = try MyMethod(["int": 123, "string": "Test", "bool": true], strategy: .anyDictionary)
        #expect(method.int == 123)
        #expect(method.string == "Test")
        #expect(method.bool == true)
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func formatDictionary_A() throws {
        let dict = MyMethod(int: 123, string: "Test", bool: nil).formatted(.anyDictionary)
        try #require(dict.count == 2)
        guard let int = dict["int"] as? Int,
              let string = dict["string"] as? String
        else { Issue.record(); return }
        #expect(int == 123)
        #expect(string == "Test")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func formatDictionary_B() throws {
        let dict = MyMethod(int: 123, string: "Test", bool: true).formatted(.anyDictionary)
        try #require(dict.count == 3)
        guard let int = dict["int"] as? Int,
              let string = dict["string"] as? String,
              let bool = dict["bool"] as? Bool
        else { Issue.record(); return }
        #expect(int == 123)
        #expect(string == "Test")
        #expect(bool == true)
    }
}

// MARK: - Test Types - MyMethod

private struct MyMethod {
    let int: Int
    let string: String
    let bool: Bool?

    init(int: Int, string: String, bool: Bool?) {
        self.int = int
        self.string = string
        self.bool = bool
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension MyMethod: PathMethodParameterValues, ParseablePathMethodParameterValues, FormattablePathMethodParameterValues {
    static let requiredPathParameters = (AnyPathMethodParameter.int(label: "int"), AnyPathMethodParameter.string(label: "string"))
    static let optionalPathParameters = AnyPathMethodParameter.bool(label: "bool")
}

// MARK: - Test Types - MyMethod - `[Any]`

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension MyMethod {
    /// Ordered `Any` values array.
    @available(macOS 14, iOS 17, tvOS 17, watchOS 10, *) // requirement for `cast(...)`
    struct AnyArrayParseStrategy: ParseStrategy {
        func parse(_ value: [Any]) throws -> MyMethod {
            let (int, string, bool) = try cast(
                values: value,
                required: MyMethod.requiredPathParameters,
                optional: MyMethod.optionalPathParameters
            )

            // this also works if using `AnyPathMethodParameters` instead of bare tuples, but as a two-step process:
            // let (int, string) = try MyMethod.requiredPathParameters.cast(values: value.prefix(2))
            // let bool = try MyMethod.optionalPathParameters.castOptional(values: value.dropFirst(2))

            return MyMethod(int: int, string: string, bool: bool)
        }

        init() { }
    }
}

@available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
extension ParseStrategy where Self == MyMethod.AnyArrayParseStrategy {
    static var anyArray: Self {
        Self()
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension MyMethod {
    /// Ordered `Any` values array.
    struct AnyArrayFormatStyle: FormatStyle {
        func format(_ value: MyMethod) -> [Any] {
            var values: [Any] = [value.int, value.string]
            if let bool = value.bool {
                values.append(bool)
            }
            return values
        }
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle where Self == MyMethod.AnyArrayFormatStyle {
    static var anyArray: Self {
        Self()
    }
}

// MARK: - Test Types - MyMethod - `[String: Any]`

extension MyMethod {
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    struct AnyDictionaryParseStrategy: ParseStrategy {
        func parse(_ value: [String: Any]) throws -> MyMethod {
            // note that this logic currently does not throw an error if extra unexpected dictionary entries exist

            guard let int = value[MyMethod.requiredPathParameters.0.label] as? Int,
                  let string = value[MyMethod.requiredPathParameters.1.label] as? String
            else { throw PathMethodParametersParseError.invalidParameters }

            let bool: Bool? = value[MyMethod.optionalPathParameters.label] as? Bool

            return MyMethod(int: int, string: string, bool: bool)
        }

        init() { }
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension ParseStrategy where Self == MyMethod.AnyDictionaryParseStrategy {
    static var anyDictionary: Self {
        Self()
    }
}

extension MyMethod {
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    struct AnyDictionaryFormatStyle: FormatStyle {
        func format(_ value: MyMethod) -> [String: Any] {
            var dict: [String: Any] = [:]
            dict[MyMethod.requiredPathParameters.0.label] = value.int
            dict[MyMethod.requiredPathParameters.1.label] = value.string
            dict[MyMethod.optionalPathParameters.label] = value.bool
            return dict
        }
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle where Self == MyMethod.AnyDictionaryFormatStyle {
    static var anyDictionary: Self {
        Self()
    }
}
