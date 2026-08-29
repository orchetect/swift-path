//
//  Path+ParseStrategy Tests.swift
//  SwiftPath
//

import Testing
import SwiftPath

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
