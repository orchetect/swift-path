//
//  PathComponents+ParseStrategy Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

@Suite
struct PathComponents_and_ParseStrategy_Tests {
    @Test
    func initStrategy() throws {
        #expect(
            try PathComponents("/foo/bar", strategy: .pathComponents) // default
                == PathComponents(["foo", "bar"])
        )

        // root types
        #expect(
            try PathComponents("/foo/bar", strategy: .pathComponents.root(nil))
                == PathComponents(["foo", "bar"])
        )
        #expect(
            try PathComponents("foo/bar", strategy: .pathComponents.root(nil))
                == PathComponents(["foo", "bar"])
        )
        #expect(
            try PathComponents("/foo/bar", strategy: .pathComponents.root(.absolute))
                == PathComponents(["foo", "bar"])
        )
        #expect(
            try PathComponents("foo/bar", strategy: .pathComponents.root(.relative))
                == PathComponents(["foo", "bar"])
        )

        // mismatched root types
        #expect(throws: PathParseError.invalidPath) {
            _ = try PathComponents("foo/bar", strategy: .pathComponents.root(.absolute))
        }
        #expect(throws: PathParseError.invalidPath) {
            _ = try PathComponents("/foo/bar", strategy: .pathComponents.root(.relative))
        }

        // custom root & path separators
        #expect(
            try PathComponents("/foo/bar", strategy: .pathComponents.rootSeparator("/").pathSeparator("/"))
                == PathComponents(["foo", "bar"])
        )
        #expect(
            try PathComponents(">foo.bar", strategy: .pathComponents.rootSeparator(">").pathSeparator("."))
                == PathComponents(["foo", "bar"])
        )

        // root types + custom root & path separators
        #expect(
            try PathComponents(">foo.bar", strategy: .pathComponents.root(.absolute).rootSeparator(">").pathSeparator("."))
                == PathComponents(["foo", "bar"])
        )
        #expect(
            try PathComponents("foo.bar", strategy: .pathComponents.root(.relative).rootSeparator(">").pathSeparator("."))
                == PathComponents(["foo", "bar"])
        )

        // mismatched root types + custom root & path separators
        #expect(throws: PathParseError.invalidPath) {
            _ = try PathComponents("/foo/bar", strategy: .pathComponents.root(.relative).rootSeparator("/").pathSeparator("/"))
        }
        #expect(throws: PathParseError.invalidPath) {
            _ = try PathComponents(">foo.bar", strategy: .pathComponents.root(.relative).rootSeparator(">").pathSeparator("."))
        }
    }
}
