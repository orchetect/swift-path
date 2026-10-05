//
//  PathMethodParameterValues OSC Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if osc

import Foundation
import SwiftOSCCore
import SwiftPath
import Testing

@Suite
struct PathMethodParameterValues_OSC_Tests {
    @Test
    func init_oscValues_A() throws {
        let method = try MyMethod(oscValues: [123, "Test"])
        #expect(method.int == 123)
        #expect(method.string == "Test")
        #expect(method.bool == nil)
    }

    @Test
    func init_oscValues_B() throws {
        let method = try MyMethod(oscValues: [123, "Test", true])
        #expect(method.int == 123)
        #expect(method.string == "Test")
        #expect(method.bool == true)
    }

    @Test
    func oscValues_A() throws {
        let array = MyMethod(int: 123, string: "Test", bool: nil).oscValues
        try #require(array.count == 2)
        guard let int = array[0] as? Int,
              let string = array[1] as? String
        else { Issue.record(); return }
        #expect(int == 123)
        #expect(string == "Test")
    }

    @Test
    func oscValues_B() throws {
        let array = MyMethod(int: 123, string: "Test", bool: true).oscValues
        try #require(array.count == 3)
        guard let int = array[0] as? Int,
              let string = array[1] as? String,
              let bool = array[2] as? Bool
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

// extension MyMethod: PathMethodParameterValues, ParseablePathMethodParameterValues, FormattablePathMethodParameterValues { }

// MARK: - Test Types - MyMethod - `OSCValues`

extension MyMethod: OSCValuesParseablePathMethodParameterValues {
    static let oscValuesParseStrategy = OSCValuesParseStrategy()

    /// Ordered OSC message values array.
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    struct OSCValuesParseStrategy: ParseStrategy {
        func parse(_ value: OSCValues) throws -> MyMethod {
            let (int, string, bool) = try value.masked(Int.self, String.self, Bool?.self)
            return MyMethod(int: int, string: string, bool: bool)
        }

        init() { }
    }
}

extension MyMethod: OSCValuesFormattablePathMethodParameterValues {
    static let oscValuesFormatStyle: OSCValuesFormatStyle = .init()

    /// Ordered OSC message values array.
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    struct OSCValuesFormatStyle: FormatStyle {
        func format(_ value: MyMethod) -> OSCValues {
            var values: OSCValues = [value.int, value.string]
            if let bool = value.bool {
                values.append(bool)
            }
            return values
        }
    }
}

#endif
