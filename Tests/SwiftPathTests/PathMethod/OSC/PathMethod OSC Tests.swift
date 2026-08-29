//
//  PathMethod OSC Tests.swift
//  SwiftPath
//

#if osc

import Foundation
import Testing
import SwiftPath
import SwiftOSCCore

/// This suite tests implementing a `Path`, `PathMethod`, and `PathMethodParameterValues` usable with OSC.
///
/// The mock types included in this file constitute a typical use-case scenario when sending and receiving OSC.
@Suite
struct PathMethod_OSC_Tests {
    /// Test that OSC address patterns using wildcard(s) match the appropriate paths.
    @Test
    func init_pathsMatching_nonAsync() /* NOT ASYNC */ throws {
        #expect(MyPath.paths(matching: "") == [])
        #expect(MyPath.paths(matching: "/") == [])
        #expect(MyPath.paths(matching: "/foo") == [.foo])
        #expect(MyPath.paths(matching: "/bar") == [.bar])
        #expect(MyPath.paths(matching: "/foo/bar") == [])

        // OSC address pattern matching
        #expect(MyPath.paths(matching: "/?oo") == [.foo])
        #expect(MyPath.paths(matching: "/f??") == [.foo])
        #expect(MyPath.paths(matching: "/f*") == [.foo])
        #expect(MyPath.paths(matching: "/*") == [.foo, .bar])
        #expect(MyPath.paths(matching: "/???") == [.foo, .bar])
    }

    /// Test that OSC address patterns using wildcard(s) match the appropriate paths.
    @Test
    func init_pathsMatching_async() async throws {
        #expect(await MyPath.paths(matching: "") == [])
        #expect(await MyPath.paths(matching: "/") == [])
        #expect(await MyPath.paths(matching: "/foo") == [.foo])
        #expect(await MyPath.paths(matching: "/bar") == [.bar])
        #expect(await MyPath.paths(matching: "/foo/bar") == [])

        // OSC address pattern matching
        #expect(await MyPath.paths(matching: "/?oo") == [.foo])
        #expect(await MyPath.paths(matching: "/f??") == [.foo])
        #expect(await MyPath.paths(matching: "/f*") == [.foo])
        #expect(await MyPath.paths(matching: "/*") == [.foo, .bar])
        #expect(await MyPath.paths(matching: "/???") == [.foo, .bar])
    }

    @Test(arguments: ["/foo", "/?oo", "/f??", "/f*"])
    func init_methodsForOSCMessage_nonAsync(oscAddress: String) /* NOT ASYNC */ throws {
        let msg = OSCMessage(oscAddress, values: [123, "Test"])
        var errorCount = 0
        let methods = MyPath.methods(for: msg) { _, _ in errorCount += 1 }
        #expect(methods.count == 1)
        #expect(errorCount == 0)

        guard let method = methods.first,
              case let .foo(foo) = method
        else { Issue.record(); return }

        #expect(foo.int == 123)
        #expect(foo.string == "Test")
    }

    @Test(arguments: ["/foo", "/?oo", "/f??", "/f*"])
    func init_methodsForOSCMessage_async(oscAddress: String) async throws {
        let msg = OSCMessage(oscAddress, values: [123, "Test"])
        var errorCount = 0
        let methods = await MyPath.methods(for: msg) { _, _ in errorCount += 1 }
        #expect(methods.count == 1)
        #expect(errorCount == 0)

        guard let method = methods.first,
              case let .foo(foo) = method
                else { Issue.record(); return }

        #expect(foo.int == 123)
        #expect(foo.string == "Test")
    }

    @Test
    func init_methodsForOSCMessage_invalidValuesA() throws {
        // will match both `foo` and `bar` paths, but the values are invalid for both
        let msg = OSCMessage("/*", values: [Data([0x01, 0x02])])

        var errorCount = 0
        let methods = MyPath.methods(for: msg) { _, _ in errorCount += 1 }

        #expect(methods.isEmpty)
        #expect(errorCount == 2)
    }

    @Test
    func init_methodsForOSCMessage_invalidValuesB() throws {
        // values are valid for `foo` path, but not for the `bar` path
        let msg = OSCMessage("/*", values: [123, "Test"])

        var errorCount = 0
        let methods = MyPath.methods(for: msg) { _, _ in errorCount += 1 }

        #expect(methods == [.foo(FooValues(int: 123, string: "Test"))])
        #expect(errorCount == 1) // invalid values for `bar`
    }

    @Test
    func oscMessage() throws {
        let method = MyMethod.foo(FooValues(int: 123, string: "Test"))
        let msg = method.oscMessage
        #expect(msg.addressPattern == "/foo")
        #expect(msg.values == [123, "Test"])
    }

    @Test
    func oscValues() throws {
        let method = MyMethod.foo(FooValues(int: 123, string: "Test"))
        let values = method.oscValues
        #expect(values == [123, "Test"])
    }

    @Test
    func OSCPath_typealias() throws {
        let _: any OSCPath = MyPath.bar
    }

    @Test
    func OSCPathMethod_typealias() throws {
        let _: any OSCPathMethod = MyMethod.foo(FooValues(int: 123, string: "Test"))
    }

    @Test
    func OSCPathMethodParameterValues_typealias() throws {
        let _: any OSCPathMethodParameterValues = FooValues(int: 123, string: "Test")
        let _: any OSCPathMethodParameterValues = BarValues(bool: true)
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

extension MyPath: OSCValuesMethodFormablePath {
    typealias OSCValuesMethod = MyMethod

    func method(oscValues: OSCValues) throws -> OSCValuesMethod {
        switch self {
        case .foo:
            let myValues = try FooValues(oscValues: oscValues)
            return .foo(myValues)
        case .bar:
            let myValues = try BarValues(oscValues: oscValues)
            return .bar(myValues)
        }
    }
}

extension MyPath: OSCAddressPatternParseablePath {
    static let oscPathCache = OSCPathCache<Self>()
}

extension MyPath: OSCAddressPatternFormattablePath { }

extension MyPath: OSCMessageMethodFormablePath { }

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

extension MyMethod: OSCMessageFormattablePathMethod {
    var formattableOSCValues: any OSCValuesFormattablePathMethodParameterValues {
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

// MARK: - Test Types - `FooValues` - `OSCValues`

extension FooValues: OSCValuesParseablePathMethodParameterValues {
    static let oscValuesParseStrategy = OSCValuesParseStrategy()

    /// Ordered OSC message values array.
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    struct OSCValuesParseStrategy: ParseStrategy {
        func parse(_ value: OSCValues) throws -> FooValues {
            let (int, string) = try value.masked(Int.self, String.self)
            return FooValues(int: int, string: string)
        }

        init() { }
    }
}

extension FooValues: OSCValuesFormattablePathMethodParameterValues {
    static let oscValuesFormatStyle: OSCValuesFormatStyle = OSCValuesFormatStyle()

    /// Ordered OSC message values array.
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    struct OSCValuesFormatStyle: FormatStyle {
        func format(_ value: FooValues) -> OSCValues {
            [value.int, value.string]
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

// MARK: - Test Types - `BarValues` - `OSCValues`

extension BarValues: OSCValuesParseablePathMethodParameterValues {
    static let oscValuesParseStrategy = OSCValuesParseStrategy()

    /// Ordered OSC message values array.
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    struct OSCValuesParseStrategy: ParseStrategy {
        func parse(_ value: OSCValues) throws -> BarValues {
            let bool = try value.masked(Bool.self)
            return BarValues(bool: bool)
        }

        init() { }
    }
}

extension BarValues: OSCValuesFormattablePathMethodParameterValues {
    static let oscValuesFormatStyle: OSCValuesFormatStyle = OSCValuesFormatStyle()

    /// Ordered OSC message values array.
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    struct OSCValuesFormatStyle: FormatStyle {
        func format(_ value: BarValues) -> OSCValues {
            [value.bool]
        }
    }
}

#endif
