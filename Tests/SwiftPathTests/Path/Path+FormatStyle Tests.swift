//
//  Path+FormatStyle Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

@Suite
struct Path_FormatStyle_Tests {
    /// Test ad-hoc path formatting using a `PathComponents` format style directly on a `Path` type.
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func formatted_PathComponents() {
        let path = PathA(pathComponents: ["foo", "bar"])

        #expect(
            path.formatted(.pathComponents) // default formatter config
                == "/foo/bar"
        )
        #expect(
            path.formatted(.pathComponents.root(.relative))
                == "foo/bar"
        )
        #expect(
            path.formatted(.pathComponents.root(.absolute).rootSeparator(">").pathSeparator("."))
                == ">foo.bar"
        )
    }
}

// MARK: - Test Types

private struct PathA: Path, Equatable {
    let pathComponents: PathComponents
}

private struct PathB: Path, Equatable {
    let pathComponents: PathComponents
}
