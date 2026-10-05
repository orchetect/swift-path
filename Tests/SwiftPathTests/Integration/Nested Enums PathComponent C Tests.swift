//
//  Nested Enums PathComponent C Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftPath
import Testing

/// This is an example of type(s) that conform to both ``Path`` and ``PathComponent``.
///
/// It additionally tests the use of ``ConstructiblePathComponent`` to handle `init`.
@Suite
struct Nested_Enums_PathComponent_C_Tests {
    // MARK: - `Path` Implementation

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func init_pathComponents() throws {
        #expect(try EnumPath(pathComponents: ["one", "foo", "a"]) == .one(.foo(.a)))
        #expect(try EnumPath(pathComponents: ["one", "bar"]) == .one(.bar))

        #expect(try EnumPath(pathComponents: ["two", "foo", "b"]) == .two(.foo(.b)))
        #expect(try EnumPath(pathComponents: ["two", "bar"]) == .two(.bar))

        #expect(try EnumPath(pathComponents: ["three"]) == .three)
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func init_pathComponents_invalid() throws {
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try EnumPath(pathComponents: [])
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try EnumPath(pathComponents: [""])
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try EnumPath(pathComponents: ["", ""])
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try EnumPath(pathComponents: ["one"])
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try EnumPath(pathComponents: ["three", "foo"])
        }
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func pathComponents() {
        #expect(EnumPath.one(.foo(.a)).pathComponents == ["one", "foo", "a"])
        #expect(EnumPath.one(.bar).pathComponents == ["one", "bar"])

        #expect(EnumPath.two(.foo(.b)).pathComponents == ["two", "foo", "b"])
        #expect(EnumPath.two(.bar).pathComponents == ["two", "bar"])

        #expect(EnumPath.three.pathComponents == ["three"])
    }

    // MARK: - `StringParseablePath` Implementation

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func init_pathString() throws {
        // `>` root separator and `.` path separator
        #expect(try EnumPath(pathString: ">one.foo.a") == .one(.foo(.a)))
        #expect(try EnumPath(pathString: ">one.bar") == .one(.bar))
        #expect(try EnumPath(pathString: ">two.foo.b") == .two(.foo(.b)))
        #expect(try EnumPath(pathString: ">two.bar") == .two(.bar))

        #expect(try EnumPath(pathString: "one.bar.") == .one(.bar))
        #expect(try EnumPath(pathString: "one.bar") == .one(.bar))
        #expect(try EnumPath(pathString: "two.bar.") == .two(.bar))
        #expect(try EnumPath(pathString: "two.bar") == .two(.bar))

        #expect(try EnumPath(pathString: ">three") == .three)
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func init_pathString_invalid() throws {
        // invalid/non-existent paths
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try EnumPath(pathString: "")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try EnumPath(pathString: ">")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try EnumPath(pathString: ">.")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try EnumPath(pathString: ">invalidpath")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try EnumPath(pathString: ">invalidpath.nonexistent")
        }

        // `/` root & path separator
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try EnumPath(pathString: "/one/foo")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try EnumPath(pathString: "/one/bar")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try EnumPath(pathString: "/two")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try EnumPath(pathString: "one/bar/")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try EnumPath(pathString: "one/bar")
        }
    }

    // MARK: - `StringFormattablePath` Implementation

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func pathString() {
        #expect(EnumPath.one(.foo(.a)).pathString == ">one.foo.a")
        #expect(EnumPath.one(.bar).pathString == ">one.bar")

        #expect(EnumPath.two(.foo(.b)).pathString == ">two.foo.b")
        #expect(EnumPath.two(.bar).pathString == ">two.bar")

        #expect(EnumPath.three.pathString == ">three")
    }

    // MARK: - `Codable` by way of `StringDecodablePath`/`StringEncodablePath`

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func stringEncodeDecode() throws {
        let original = EnumPath.one(.foo(.a))

        let encoder = JSONEncoder()
        let encoded = try encoder.encode(original)

        // verify encoded format is a path string as a single value
        // and that it uses the string format style provided
        let encodedString = try #require(String(data: encoded, encoding: .utf8))
        #expect(encodedString == #"">one.foo.a""#)

        let decoder = JSONDecoder()
        let decoded = try decoder.decode(EnumPath.self, from: encoded)

        #expect(decoded == original)
    }
}

// MARK: - Test Types - `EnumPath`

private enum EnumPath: Equatable {
    case one(SubPath)
    case two(SubPath)
    case three
}

extension EnumPath: Path {
    // `var pathComponents` default implementation is provided by `PathComponent`

    // `init(pathComponents: PathComponents)` default implementation is provided by `ConstructiblePathComponent`
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension EnumPath: StringParseablePath {
    static let pathStringParseStrategy = PathComponents.ParseStrategy(
        root: nil,
        rootSeparator: ">",
        pathSeparator: "."
    )
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension EnumPath: StringFormattablePath {
    static let pathStringFormatStyle = PathComponents.FormatStyle(
        root: .absolute,
        rootSeparator: ">",
        pathSeparator: "."
    )
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension EnumPath: StringDecodablePath {
    // default implementation is provided when Self conforms to `StringParseablePath`
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension EnumPath: StringEncodablePath {
    // default implementation is provided when Self conforms to `StringFormattablePath`
}

extension EnumPath: PathComponent { }

extension EnumPath: IdentifiablePathComponent {
    enum PathComponentID: String {
        case one
        case two
        case three
    }

    var pathComponentID: PathComponentID {
        switch self {
        case .one: .one
        case .two: .two
        case .three: .three
        }
    }
}

extension EnumPath: ConstructiblePathComponent {
    static func constructor(for pathComponent: PathComponentID) -> any PathComponentConstructor<Self> {
        switch pathComponent {
        case .one: ContainerConstructor(of: SubPath.self) { .one($0) }
        case .two: ContainerConstructor(of: SubPath.self) { .two($0) }
        case .three: MethodConstructor { .three }
        }
    }
}

extension EnumPath: ContainerPathComponent {
    var nextPathComponent: (any PathComponent)? {
        switch self {
        case let .one(one): one
        case let .two(two): two
        case .three: nil
        }
    }
}

// MARK: - Test Types - `SubPath`

private enum SubPath: Equatable {
    case foo(TertiaryPath)
    case bar
}

extension SubPath: Path {
    // `var pathComponents` default implementation is provided by `PathComponent`

    // `init(pathComponents: PathComponents)` default implementation is provided by `ConstructiblePathComponent`
}

extension SubPath: PathComponent { }

extension SubPath: IdentifiablePathComponent {
    enum PathComponentID: String {
        case foo
        case bar
    }

    var pathComponentID: PathComponentID {
        switch self {
        case .foo: .foo
        case .bar: .bar
        }
    }
}

extension SubPath: ConstructiblePathComponent {
    static func constructor(for pathComponent: PathComponentID) -> any PathComponentConstructor<Self> {
        switch pathComponent {
        case .foo: ContainerConstructor(of: TertiaryPath.self) { .foo($0) }
        case .bar: MethodConstructor { .bar }
        }
    }
}

extension SubPath: ContainerPathComponent {
    var nextPathComponent: (any PathComponent)? {
        switch self {
        case let .foo(foo): foo
        case .bar: nil
        }
    }
}

// MARK: - Test Types - `TertiaryPath`

private enum TertiaryPath: Equatable {
    case a
    case b
}

extension TertiaryPath: Path {
    // `var pathComponents` default implementation is provided by `PathComponent`

    // `init(pathComponents: PathComponents)` default implementation is provided by `ConstructiblePathComponent`
}

extension TertiaryPath: PathComponent { }

extension TertiaryPath: IdentifiablePathComponent {
    enum PathComponentID: String {
        case a
        case b
    }

    var pathComponentID: PathComponentID {
        switch self {
        case .a: .a
        case .b: .b
        }
    }
}

extension TertiaryPath: ConstructiblePathComponent {
    static func constructor(for pathComponent: PathComponentID) -> any PathComponentConstructor<Self> {
        switch pathComponent {
        case .a: MethodConstructor { .a }
        case .b: MethodConstructor { .b }
        }
    }
}
