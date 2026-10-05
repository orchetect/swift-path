//
//  PathMethodParameterValues Empty OSC Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if osc

import Foundation
import SwiftOSCCore
import SwiftPath
import Testing

@Suite
struct PathMethodParameterValues_Empty_OSC_Tests {
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func init_oscValues_A() throws {
        let method = try MyMethod(oscValues: [])
        #expect(method.value == 0)
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func init_oscValues_B() throws {
        #expect(throws: (any Error).self) {
            _ = try MyMethod(oscValues: [123])
        }
        #expect(throws: (any Error).self) {
            _ = try MyMethod(oscValues: [123, "Test"])
        }
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func oscValues() {
        #expect(MyMethod().oscValues.isEmpty)
        #expect(MyMethod(value: 1).oscValues.isEmpty)
    }
}

// MARK: - Test Types - MyMethod

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
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

// MARK: - Test Types - MyMethod - `OSCValues`

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension MyMethod: EmptyOSCValuesParseablePathMethodParameterValues { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension MyMethod: EmptyOSCValuesFormattablePathMethodParameterValues { }

#endif
