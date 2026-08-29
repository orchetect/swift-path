//
//  Nested Structs Tests.swift
//  SwiftPath
//

import Foundation
import Testing
import SwiftPath

/// This suite uses a mock `Path` type comprised of nested structs conforming to `PathComponent`
/// and its sister protocols as needed.
///
/// This mocks a structure where individual types may be constructed as nodes which is a subtly
/// different topology than using nested enums.
@Suite
struct Nested_Structs_PathComponent_Tests {
    // MARK: - `Path` Implementation

    @Test
    func init_pathComponents() throws {
        #expect(try RootPath(pathComponents: ["one", "foo", "a"]) == .one(.foo(.a)))
        #expect(try RootPath(pathComponents: ["one", "bar"]) == .one(.bar))

        #expect(try RootPath(pathComponents: ["two", "foo", "b"]) == .two(.foo(.b)))
        #expect(try RootPath(pathComponents: ["two", "bar"]) == .two(.bar))

        #expect(try RootPath(pathComponents: ["three"]) == .three)
    }

    @Test
    func init_pathComponents_invalid() throws {
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try RootPath(pathComponents: [])
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try RootPath(pathComponents: [""])
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try RootPath(pathComponents: ["", ""])
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try RootPath(pathComponents: ["one"])
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try RootPath(pathComponents: ["three", "foo"])
        }
    }

    @Test
    func pathComponents() throws {
        #expect(RootPath.one(.foo(.a)).pathComponents == ["one", "foo", "a"])
        #expect(RootPath.one(.bar).pathComponents == ["one", "bar"])

        #expect(RootPath.two(.foo(.b)).pathComponents == ["two", "foo", "b"])
        #expect(RootPath.two(.bar).pathComponents == ["two", "bar"])

        #expect(RootPath.three.pathComponents == ["three"])
    }

    // MARK: - `StringParseablePath` Implementation

    @Test
    func init_pathString() throws {
        // `>` root separator and `.` path separator
        #expect(try RootPath(pathString: ">one.foo.a") == .one(.foo(.a)))
        #expect(try RootPath(pathString: ">one.bar") == .one(.bar))
        #expect(try RootPath(pathString: ">two.foo.b") == .two(.foo(.b)))
        #expect(try RootPath(pathString: ">two.bar") == .two(.bar))

        #expect(try RootPath(pathString: "one.bar.") == .one(.bar))
        #expect(try RootPath(pathString: "one.bar") == .one(.bar))
        #expect(try RootPath(pathString: "two.bar.") == .two(.bar))
        #expect(try RootPath(pathString: "two.bar") == .two(.bar))

        #expect(try RootPath(pathString: ">three") == .three)
    }

    @Test
    func init_pathString_invalid() throws {
        // invalid/non-existent paths
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try RootPath(pathString: "")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try RootPath(pathString: ">")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try RootPath(pathString: ">.")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try RootPath(pathString: ">invalidpath")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try RootPath(pathString: ">invalidpath.nonexistent")
        }

        // `/` root & path separator
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try RootPath(pathString: "/one/foo")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try RootPath(pathString: "/one/bar")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try RootPath(pathString: "/two")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try RootPath(pathString: "one/bar/")
        }
        #expect(throws: PathParseError.pathDoesNotExist) {
            _ = try RootPath(pathString: "one/bar")
        }
    }

    // MARK: - `StringFormattablePath` Implementation

    @Test
    func pathString() throws {
        #expect(RootPath.one(.foo(.a)).pathString == ">one.foo.a")
        #expect(RootPath.one(.bar).pathString == ">one.bar")

        #expect(RootPath.two(.foo(.b)).pathString == ">two.foo.b")
        #expect(RootPath.two(.bar).pathString == ">two.bar")

        #expect(RootPath.three.pathString == ">three")
    }

    // MARK: - `Codable` by way of `StringDecodablePath`/`StringEncodablePath`

    @Test
    func stringEncodeDecode() throws {
        let original = RootPath.one(.foo(.a))

        let encoder = JSONEncoder()
        let encoded = try encoder.encode(original)

        // verify encoded format is a path string as a single value
        // and that it uses the string format style provided
        let encodedString = try #require(String(data: encoded, encoding: .utf8))
        #expect(encodedString == #"">one.foo.a""#)

        let decoder = JSONDecoder()
        let decoded = try decoder.decode(RootPath.self, from: encoded)

        #expect(decoded == original)
    }
}

// MARK: - Test Types - `MyPathComponent`

private protocol MyPathComponent: Path, PathComponent, IdentifiablePathComponent, Sendable {
    var child: (any MyPathComponent)? { get }
}

// MARK: Test Types - `RootPath`

private struct RootPath: Sendable {
    let pathComponentID: PathComponentID
    var child: (any MyPathComponent)?

    init(pathComponentID: PathComponentID, child: (any MyPathComponent)?) {
        self.pathComponentID = pathComponentID
        self.child = child
    }
}

extension RootPath: Equatable {
    static func == (lhs: Self, rhs: RootPath) -> Bool {
        isEqual(lhs: lhs, rhs: rhs)
    }
}

private func isEqual(lhs: any PathComponent, rhs: any PathComponent) -> Bool {
    lhs.pathComponents == rhs.pathComponents
}

extension RootPath: Path {
    // `var pathComponents` default implementation is provided by `PathComponent`

    // `init(pathComponents: PathComponents)` default implementation is provided by `ConstructiblePathComponent`
}

extension RootPath: StringParseablePath {
    static let pathStringParseStrategy = PathComponents.ParseStrategy(
        root: nil,
        rootSeparator: ">",
        pathSeparator: "."
    )
}

extension RootPath: StringFormattablePath {
    static let pathStringFormatStyle = PathComponents.FormatStyle(
        root: .absolute,
        rootSeparator: ">",
        pathSeparator: "."
    )
}

extension RootPath: StringCodablePath { }

extension RootPath: PathComponent { }

extension RootPath: IdentifiablePathComponent {
    enum PathComponentID: String {
        case one
        case two
        case three
    }
}

extension RootPath: ConstructiblePathComponent {
    static func constructor(for pathComponent: PathComponentID) -> any PathComponentConstructor<Self> {
        switch pathComponent {
        case .one: ContainerConstructor(of: SubPath.self) { .one($0) }
        case .two: ContainerConstructor(of: SubPath.self) { .two($0) }
        case .three: MethodConstructor { .three }
        }
    }
}

extension RootPath: ContainerPathComponent {
    var nextPathComponent: (any PathComponent)? {
        child
    }
}

extension RootPath {
    // MARK: Static Constructors

    static func one(_ child: SubPath) -> Self {
        Self(pathComponentID: .one, child: child)
    }

    static func two(_ child: SubPath) -> Self {
        Self(pathComponentID: .two, child: child)
    }

    static var three: Self {
        Self(pathComponentID: .three, child: nil)
    }
}

// MARK: - Test Types - `SubPath`

private struct SubPath: MyPathComponent {
    var pathComponentID: PathComponentID
    var child: (any MyPathComponent)?
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
        child
    }
}

extension SubPath {
    // MARK: Static Constructors

    static func foo(_ child: TertiaryPath) -> Self {
        Self(pathComponentID: .foo, child: child)
    }

    static var bar: Self {
        Self(pathComponentID: .bar, child: nil)
    }
}

// MARK: - Test Types - `TertiaryPath`

private struct TertiaryPath: MyPathComponent {
    var pathComponentID: PathComponentID
    var child: (any MyPathComponent)?
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
}

extension TertiaryPath: ConstructiblePathComponent {
    static func constructor(for pathComponent: PathComponentID) -> any PathComponentConstructor<Self> {
        switch pathComponent {
        case .a: MethodConstructor { .a }
        case .b: MethodConstructor { .b }
        }
    }
}

extension TertiaryPath {
    // MARK: Static Constructors

    static var a: Self {
        Self(pathComponentID: .a, child: nil)
    }

    static var b: Self {
        Self(pathComponentID: .b, child: nil)
    }
}
