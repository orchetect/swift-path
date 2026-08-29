//
//  PathFormatStyle and PathParseStrategy Tests.swift
//  SwiftPath
//

import Foundation
import Testing
import SwiftPath

/// - Implements a custom ``Path`` type with as sparse implementation as possible.
/// - Tests ``PathFormatStyle`` and ``PathParseStrategy`` by creating static constructors for them.
@Suite
struct PathFormatStyle_and_PathParseStrategy_Tests {
    @Test
    func init_pathString() throws {
        #expect(
            try MyPath(pathString: "")
                .pathComponents == PathComponents([])
        )
        #expect(
            try MyPath(pathString: "/foo/bar/")
                .pathComponents == PathComponents(["foo", "bar"])
        )
    }

    @Test
    func pathString() {
        #expect(
            MyPath(pathComponents: PathComponents(["foo", "bar"]))
                .pathString == "/foo/bar"
        )
    }

    @Test
    func init_valueStrategy_usingStaticConstructor() throws {
        #expect(
            try MyPath("/", strategy: .path(components: .pathComponents, path: MyPath.ParseStrategy()))
                .pathComponents == PathComponents([])
        )
        #expect(
            try MyPath("/foo/bar", strategy: .path(components: .pathComponents, path: MyPath.ParseStrategy()))
                .pathComponents == PathComponents(["foo", "bar"])
        )
    }

    @Test
    func init_valueStrategy_usingCustomStaticConstructor() throws {
        #expect(
            try MyPath("/", strategy: .myPath)
                .pathComponents == PathComponents([])
        )
        #expect(
            try MyPath("/foo/bar", strategy: .myPath)
                .pathComponents == PathComponents(["foo", "bar"])
        )
    }

    @Test
    func init_valueStrategy_usingInlineConstructor() throws {
        #expect(
            try MyPath("/", strategy: PathParseStrategy(components: .pathComponents, path: MyPath.ParseStrategy()))
                .pathComponents == PathComponents([])
        )
        #expect(
            try MyPath("/foo/bar", strategy: PathParseStrategy(components: .pathComponents, path: MyPath.ParseStrategy()))
                .pathComponents == PathComponents(["foo", "bar"])
        )
    }

    @Test
    func formatted_usingStaticConstructor() throws {
        #expect(
            MyPath(pathComponents: PathComponents([]))
                .formatted(.path(path: MyPath.FormatStyle(), components: .pathComponents)) == "/"
        )
        #expect(
            MyPath(pathComponents: PathComponents(["foo", "bar"]))
                .formatted(.path(path: MyPath.FormatStyle(), components: .pathComponents)) == "/foo/bar"
        )
    }

    @Test
    func formatted_usingCustomStaticConstructor() throws {
        #expect(
            MyPath(pathComponents: PathComponents([]))
                .formatted(.myPath) == "/"
        )
        #expect(
            MyPath(pathComponents: PathComponents(["foo", "bar"]))
                .formatted(.myPath) == "/foo/bar"
        )
    }

    @Test
    func formatted_usingInlineConstructor() throws {
        #expect(
            MyPath(pathComponents: PathComponents([]))
                .formatted(PathFormatStyle(path: MyPath.FormatStyle(), components: .pathComponents)) == "/"
        )
        #expect(
            MyPath(pathComponents: PathComponents(["foo", "bar"]))
                .formatted(PathFormatStyle(path: MyPath.FormatStyle(), components: .pathComponents)) == "/foo/bar"
        )
    }
}

// MARK: Test Types

private struct MyPath {
    let pathComponents: PathComponents

    init(pathComponents: PathComponents) {
        self.pathComponents = pathComponents
    }
}

extension MyPath: Path {
    var pathString: String { pathComponents.formatted() }

    init(pathString: String) throws {
        pathComponents = try PathComponents(pathString, strategy: .pathComponents)
    }
}

// MARK: Parser and Formatter

extension MyPath {
    struct ParseStrategy: Foundation.ParseStrategy {
        func parse(_ value: PathComponents) throws -> MyPath {
            MyPath(pathComponents: value)
        }
    }

    struct FormatStyle: Foundation.FormatStyle {
        func format(_ value: MyPath) -> PathComponents {
            value.pathComponents
        }
    }
}

// MARK: Custom Static Constructors

extension FormatStyle where Self == PathFormatStyle<MyPath, MyPath.FormatStyle, PathComponents.FormatStyle> {
    fileprivate static var myPath: Self {
        Self(for: MyPath.self, path: MyPath.FormatStyle(), components: .pathComponents)
    }
}

extension ParseStrategy where Self == PathParseStrategy<MyPath, PathComponents.ParseStrategy, MyPath.ParseStrategy> {
    fileprivate static var myPath: Self {
        Self(for: MyPath.self, components: .pathComponents, path: MyPath.ParseStrategy())
    }
}
