//
//  Path+ParseStrategy Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

@Suite
struct Path_ParseStrategy_Tests {
    /// Test path construction using a `PathComponents` parse strategy directly on a `Path` type.
    @Test
    func init_valueStrategy_PathComponents() throws {
        let path = try PathA(">foo.bar", strategy: .pathComponents.root(.absolute).rootSeparator(">").pathSeparator("."))
        #expect(path.pathComponents == ["foo", "bar"])
    }
}

// MARK: - Test Types

private struct PathA: Path, Equatable {
    let pathComponents: PathComponents
}

private struct PathB: Path, Equatable {
    let pathComponents: PathComponents
}
