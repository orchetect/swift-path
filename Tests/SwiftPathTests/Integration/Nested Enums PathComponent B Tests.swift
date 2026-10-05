//
//  Nested Enums PathComponent B Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftPath
import Testing

/// This is an example of implementing separate ``Path`` and ``PathComponent`` types.
///
/// This suite uses a mock `Path` type comprised of nested enums that each conform to
/// ``PathComponent`` and its various refining protocols.
///
/// It also ensures that path trees can be reused and are not tightly coupled to their parents.
@Suite
struct Nested_Enums_PathComponent_B_Tests {
    // MARK: - `Path` Implementation

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func init_pathComponents() throws {
        #expect(try MyPath(pathComponents: ["one", "foo", "a"]).path == .one(.foo(.a)))
        #expect(try MyPath(pathComponents: ["one", "bar"]).path == .one(.bar))

        #expect(try MyPath(pathComponents: ["two", "foo", "b"]).path == .two(.foo(.b)))
        #expect(try MyPath(pathComponents: ["two", "bar"]).path == .two(.bar))

        #expect(try MyPath(pathComponents: ["three"]).path == .three)
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func init_pathComponents_invalid() throws {
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try MyPath(pathComponents: [])
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try MyPath(pathComponents: [""])
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try MyPath(pathComponents: ["", ""])
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try MyPath(pathComponents: ["one"])
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
        #expect(try MyPath(pathString: ">one.foo.a").path == .one(.foo(.a)))
        #expect(try MyPath(pathString: ">one.bar").path == .one(.bar))
        #expect(try MyPath(pathString: ">two.foo.b").path == .two(.foo(.b)))
        #expect(try MyPath(pathString: ">two.bar").path == .two(.bar))

        #expect(try MyPath(pathString: "one.bar.").path == .one(.bar))
        #expect(try MyPath(pathString: "one.bar").path == .one(.bar))
        #expect(try MyPath(pathString: "two.bar.").path == .two(.bar))
        #expect(try MyPath(pathString: "two.bar").path == .two(.bar))

        #expect(try MyPath(pathString: ">three").path == .three)
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func init_pathString_invalid() throws {
        // invalid/non-existent paths
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try MyPath(pathString: "")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try MyPath(pathString: ">")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try MyPath(pathString: ">.")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try MyPath(pathString: ">invalidpath")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try MyPath(pathString: ">invalidpath.nonexistent")
        }

        // `/` root & path separator
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try MyPath(pathString: "/one/foo")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try MyPath(pathString: "/one/bar")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try MyPath(pathString: "/two")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try MyPath(pathString: "one/bar/")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try MyPath(pathString: "one/bar")
        }
    }

    // MARK: - `StringFormattablePath` Implementation

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func pathString() {
        #expect(MyPath(path: EnumPath.one(.foo(.a))).pathString == ">one.foo.a")
        #expect(MyPath(path: EnumPath.one(.bar)).pathString == ">one.bar")

        #expect(MyPath(path: EnumPath.two(.foo(.b))).pathString == ">two.foo.b")
        #expect(MyPath(path: EnumPath.two(.bar)).pathString == ">two.bar")

        #expect(MyPath(path: EnumPath.three).pathString == ">three")
    }

    // MARK: - `Codable` by way of `StringDecodablePath`/`StringEncodablePath`

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func stringEncodeDecode() throws {
        let original = MyPath(path: EnumPath.one(.foo(.a)))

        let encoder = JSONEncoder()
        let encoded = try encoder.encode(original)

        // verify encoded format is a path string as a single value
        // and that it uses the string format style provided
        let encodedString = try #require(String(data: encoded, encoding: .utf8))
        #expect(encodedString == #"">one.foo.a""#)

        let decoder = JSONDecoder()
        let decoded = try decoder.decode(MyPath.self, from: encoded)

        #expect(decoded == original)
    }
}

// MARK: - Test Types: `MyPath`

/// A `Path` type that references separate `PathComponent` types instead of a single type conforming to
/// both protocols.
private struct MyPath: Equatable {
    let path: EnumPath

    init(path: EnumPath) {
        self.path = path
    }
}

extension MyPath: Path {
    var pathComponents: PathComponents {
        path.pathComponents
    }

    init(pathComponents: PathComponents) throws {
        path = try EnumPath(pathComponents: pathComponents)
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension MyPath: StringParseablePath {
    static let pathStringParseStrategy = PathComponents.ParseStrategy(
        root: nil,
        rootSeparator: ">",
        pathSeparator: "."
    )
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension MyPath: StringFormattablePath {
    static let pathStringFormatStyle = PathComponents.FormatStyle(
        root: .absolute,
        rootSeparator: ">",
        pathSeparator: "."
    )
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension MyPath: StringCodablePath { }

// MARK: - Test Types - `EnumPath`

private enum EnumPath: Equatable {
    case one(SubPath)
    case two(SubPath)
    case three
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
