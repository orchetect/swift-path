//
//  PathFormatStyle and PathParseStrategy Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftPath
import Testing

/// - Implements a custom ``Path`` type with as sparse implementation as possible.
/// - Tests ``PathFormatStyle`` and ``PathParseStrategy`` by creating static constructors for them.
@Suite
struct PathFormatStyle_and_PathParseStrategy_Tests {
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
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

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func pathString() {
        #expect(
            MyPath(pathComponents: PathComponents(["foo", "bar"]))
                .pathString == "/foo/bar"
        )
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
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

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
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

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
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

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func formatted_usingStaticConstructor() {
        #expect(
            MyPath(pathComponents: PathComponents([]))
                .formatted(.path(path: MyPath.FormatStyle(), components: .pathComponents)) == "/"
        )
        #expect(
            MyPath(pathComponents: PathComponents(["foo", "bar"]))
                .formatted(.path(path: MyPath.FormatStyle(), components: .pathComponents)) == "/foo/bar"
        )
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func formatted_usingCustomStaticConstructor() {
        #expect(
            MyPath(pathComponents: PathComponents([]))
                .formatted(.myPath) == "/"
        )
        #expect(
            MyPath(pathComponents: PathComponents(["foo", "bar"]))
                .formatted(.myPath) == "/foo/bar"
        )
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func formatted_usingInlineConstructor() {
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

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension MyPath: Path {
    var pathString: String {
        pathComponents.formatted()
    }

    init(pathString: String) throws {
        pathComponents = try PathComponents(pathString, strategy: .pathComponents)
    }
}

// MARK: Parser and Formatter

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
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

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle where Self == PathFormatStyle<MyPath, MyPath.FormatStyle, PathComponents.FormatStyle> {
    fileprivate static var myPath: Self {
        Self(for: MyPath.self, path: MyPath.FormatStyle(), components: .pathComponents)
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension ParseStrategy where Self == PathParseStrategy<MyPath, PathComponents.ParseStrategy, MyPath.ParseStrategy> {
    fileprivate static var myPath: Self {
        Self(for: MyPath.self, components: .pathComponents, path: MyPath.ParseStrategy())
    }
}
