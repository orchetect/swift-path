//
//  Path Tests.swift
//  SwiftPath
//

import Testing
import SwiftPath

@Suite
struct Path_Tests {
    @Test
    func equality() throws {
        #expect(PathA(pathComponents: ["foo"]) == PathA(pathComponents: ["foo"]))
        #expect(PathA(pathComponents: ["foo"]).pathComponents == PathA(pathComponents: ["foo"]).pathComponents)

        // #expect(PathA(pathComponents: ["foo"]) != PathB(pathComponents: ["foo"])) // no != operator exists for this
        #expect(PathA(pathComponents: ["foo"]).pathComponents == PathB(pathComponents: ["foo"]).pathComponents)
    }
}

// MARK: - Test Types

private struct PathA: Path, Equatable {
    let pathComponents: PathComponents
}

private struct PathB: Path, Equatable {
    let pathComponents: PathComponents
}
