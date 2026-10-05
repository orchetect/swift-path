//
//  PathMethodParameterValues Empty String Dictionary Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftPath
import Testing

@Suite
struct PathMethodParameterValues_Empty_String_Dictionary_Tests {
    @Test
    func init_stringDictionary_A() throws {
        let method = try MyMethod(stringDictionary: [:])
        #expect(method.value == 0)
    }

    @Test
    func init_stringDictionary_B() throws {
        #expect(throws: (any Error).self) {
            _ = try MyMethod(stringDictionary: ["value": "123"])
        }
    }

    @Test
    func stringDictionary() {
        #expect(MyMethod().stringDictionary.isEmpty)
        #expect(MyMethod(value: 1).stringDictionary.isEmpty)
    }
}

// MARK: - Test Types - MyMethod

private struct MyMethod {
    let value: Int

    init() {
        value = 0
    }

    init(value: Int) {
        self.value = value
    }
}

// extension MyMethod: PathMethodParameterValues, ParseablePathMethodParameterValues, FormattablePathMethodParameterValues { }

// MARK: - Test Types - MyMethod - `[String: String]`

extension MyMethod: EmptyStringDictionaryParseablePathMethodParameterValues { }

extension MyMethod: EmptyStringDictionaryFormattablePathMethodParameterValues { }
