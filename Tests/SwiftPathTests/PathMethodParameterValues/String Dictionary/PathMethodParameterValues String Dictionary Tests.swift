//
//  PathMethodParameterValues String Dictionary Tests.swift
//  SwiftPath
//

import Foundation
import Testing
import SwiftPath

@Suite
struct PathMethodParameterValues_String_Dictionary_Tests {
    @Test
    func parseDictionary_A() throws {
        let method = try MyMethod(stringDictionary: ["int": "123", "string": "Test"])
        #expect(method.int == 123)
        #expect(method.string == "Test")
        #expect(method.bool == nil)
    }

    @Test
    func parseDictionary_B() throws {
        let method = try MyMethod(stringDictionary: ["int": "123", "string": "Test", "bool": "true"])
        #expect(method.int == 123)
        #expect(method.string == "Test")
        #expect(method.bool == true)
    }

    @Test
    func formatDictionary_A() throws {
        let dict = MyMethod(int: 123, string: "Test", bool: nil).stringDictionary
        try #require(dict.count == 2)
        guard let intString = dict["int"], let int = Int(intString),
              let string = dict["string"]
        else { Issue.record(); return }
        #expect(int == 123)
        #expect(string == "Test")
    }

    @Test
    func formatDictionary_B() throws {
        let dict = MyMethod(int: 123, string: "Test", bool: true).stringDictionary
        try #require(dict.count == 3)
        guard let intString = dict["int"], let int = Int(intString),
              let string = dict["string"],
              let boolString = dict["bool"], let bool = Bool(boolString)
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

extension MyMethod: PathMethodParameterValues /* , ParseablePathMethodParameterValues, FormattablePathMethodParameterValues */ {
    static let requiredPathParameters = (AnyPathMethodParameter.int(label: "int"), AnyPathMethodParameter.string(label: "string"))
    static let optionalPathParameters = AnyPathMethodParameter.bool(label: "bool")
}

// MARK: - Test Types - MyMethod - `[String: String]`

extension MyMethod: StringDictionaryParseablePathMethodParameterValues {
    static let stringDictionaryParseStrategy = StringDictionaryParseStrategy()

    /// String dictionary, which could typically be used with URL query key/value pairs
    /// or CLI command line arguments.
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    struct StringDictionaryParseStrategy: ParseStrategy {
        func parse(_ value: [String: String]) throws -> MyMethod {
            // note that this logic currently does not throw an error if extra unexpected dictionary entries exist

            guard let intValue = value[MyMethod.requiredPathParameters.0.label],
                  let stringValue = value[MyMethod.requiredPathParameters.1.label]
            else { throw PathMethodParametersParseError.invalidParameters }

            let int = try MyMethod.requiredPathParameters.0.parse(intValue, strategy: .int)
            let string = try MyMethod.requiredPathParameters.1.parse(stringValue, strategy: .string)

            let bool: Bool? = if let boolValue = value[MyMethod.optionalPathParameters.label] {
                try MyMethod.optionalPathParameters.parse(boolValue, strategy: .bool)
            } else {
                nil
            }

            return MyMethod(int: int, string: string, bool: bool)
        }

        init() { }
    }
}

extension MyMethod: StringDictionaryFormattablePathMethodParameterValues {
    static let stringDictionaryFormatStyle = StringDictionaryFormatStyle()

    /// String dictionary, which could typically be used with URL query key/value pairs
    /// or CLI command line arguments.
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    struct StringDictionaryFormatStyle: FormatStyle {
        func format(_ value: MyMethod) -> [String: String] {
            let int = MyMethod.requiredPathParameters.0.format(value.int, format: .string)
            let string = MyMethod.requiredPathParameters.1.format(value.string, format: .string)
            let bool: String? = if let v = value.bool { MyMethod.optionalPathParameters.format(v, format: .string) } else { nil }

            var dict: [String: String] = [:]
            dict[MyMethod.requiredPathParameters.0.label] = int
            dict[MyMethod.requiredPathParameters.1.label] = string
            dict[MyMethod.optionalPathParameters.label] = bool
            return dict
        }
    }
}
