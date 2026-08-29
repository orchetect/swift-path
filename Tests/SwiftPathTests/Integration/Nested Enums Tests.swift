//
//  Nested Enums Tests.swift
//  SwiftPath
//

import Foundation
import Testing
import SwiftPath

/// This suite uses a mock `Path` type comprised of nested enums and tests
/// `Path` requirements as well as requirements of various related protocols:
/// - StringParseablePath / StringFormattablePath
/// - StringDecodablePath / StringEncodablePath
@Suite
struct Nested_Enums_Tests {
    // MARK: - `Path` Implementation

    @Test
    func init_pathComponents() throws {
        #expect(try EnumPath(pathComponents: ["one", "foo"]) == .one(.foo))
        #expect(try EnumPath(pathComponents: ["one", "bar"]) == .one(.bar))
        #expect(try EnumPath(pathComponents: ["two"]) == .two)
    }

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

    @Test
    func pathComponents() throws {
        #expect(EnumPath.one(.foo).pathComponents == ["one", "foo"])
        #expect(EnumPath.one(.bar).pathComponents == ["one", "bar"])
        #expect(EnumPath.two.pathComponents == ["two"])
    }

    // MARK: - `StringParseablePath` Implementation

    @Test
    func init_pathString() throws {
        // `>` root separator and `.` path separator
        #expect(try EnumPath(pathString: ">one.foo") == .one(.foo))
        #expect(try EnumPath(pathString: ">one.bar") == .one(.bar))
        #expect(try EnumPath(pathString: ">two") == .two)
        #expect(try EnumPath(pathString: "one.bar.") == .one(.bar))
        #expect(try EnumPath(pathString: "one.bar") == .one(.bar))
    }

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

    @Test
    func pathString() throws {
        #expect(EnumPath.one(.foo).pathString == ">one.foo")
        #expect(EnumPath.one(.bar).pathString == ">one.bar")
        #expect(EnumPath.two.pathString == ">two")
    }

    // MARK: - `Codable` by way of `StringDecodablePath`/`StringEncodablePath`

    @Test
    func stringEncodeDecode() throws {
        let original = EnumPath.one(.foo)

        let encoder = JSONEncoder()
        let encoded = try encoder.encode(original)

        // verify encoded format is a path string as a single value
        // and that it uses the string format style provided
        let encodedString = try #require(String(data: encoded, encoding: .utf8))
        #expect(encodedString == #"">one.foo""#)

        let decoder = JSONDecoder()
        let decoded = try decoder.decode(EnumPath.self, from: encoded)

        #expect(decoded == original)
    }
}

// MARK: - Test Types - `EnumPath`

private enum EnumPath: Equatable {
    case one(One)
    case two
}

extension EnumPath {
    enum PathComponentID: String {
        case one
        case two
    }

    var pathComponentID: PathComponentID {
        switch self {
        case .one: .one
        case .two: .two
        }
    }
}

extension EnumPath: Path {
    var pathComponents: PathComponents {
        switch self {
        case let .one(one): [pathComponentID.rawValue] + one.pathComponents
        case .two: [pathComponentID.rawValue]
        }
    }

    init(pathComponents: PathComponents) throws {
        let (id, trailingPathComponents) = try pathComponents.parseID(of: PathComponentID.self)
        switch id {
        case .one:
            let one = try One(pathComponents: trailingPathComponents)
            self = .one(one)
        case .two:
            guard trailingPathComponents.components.isEmpty else { throw PathParseError.pathDoesNotExist }
            self = .two
        }
    }
}

extension EnumPath: StringParseablePath {
    static let pathStringParseStrategy = PathComponents.ParseStrategy(
        root: nil, 
        rootSeparator: ">",
        pathSeparator: "."
    )
}

extension EnumPath: StringFormattablePath {
    static let pathStringFormatStyle = PathComponents.FormatStyle(
        root: .absolute,
        rootSeparator: ">",
        pathSeparator: "."
    )
}

extension EnumPath: StringDecodablePath {
    // default implementation is provided when Self conforms to `StringParseablePath`
}

extension EnumPath: StringEncodablePath {
    // default implementation is provided when Self conforms to `StringFormattablePath`
}

// MARK: - Test Types - `EnumPath.One`

extension EnumPath {
    enum One: Equatable {
        case foo
        case bar
    }
}

extension EnumPath.One {
    enum PathComponentID: String {
        case foo
        case bar
    }

    fileprivate var pathComponentID: PathComponentID {
        switch self {
        case .foo: .foo
        case .bar: .bar
        }
    }
}

extension EnumPath.One: Path {
    var pathComponents: PathComponents {
        switch self {
        case .foo: [pathComponentID.rawValue]
        case .bar: [pathComponentID.rawValue]
        }
    }

    init(pathComponents: PathComponents) throws {
        let (id, trailingPathComponents) = try pathComponents.parseID(of: PathComponentID.self)
        switch id {
        case .foo:
            guard trailingPathComponents.components.isEmpty else { throw PathParseError.pathDoesNotExist }
            self = .foo
        case .bar:
            guard trailingPathComponents.components.isEmpty else { throw PathParseError.pathDoesNotExist }
            self = .bar
        }
    }
}
