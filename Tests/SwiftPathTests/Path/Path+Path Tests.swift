//
//  Path+Path Tests.swift
//  SwiftPath
//

import Testing
import SwiftPath

@Suite
struct Path_Path_Tests {
    @Test
    func converted() throws {
        #expect(
            try PathA(pathComponents: ["foo", "bar"]).converted(to: PathB.self)
                == PathB(pathComponents: ["foo", "bar"])
        )
        #expect(
            try PathA(pathComponents: ["foo", "bar"]).converted(to: AnyPath.self)
                == AnyPath(pathComponents: ["foo", "bar"])
        )
    }

    @Test
    func init_converting() throws {
        #expect(
            try PathB(converting: PathA(pathComponents: ["foo", "bar"]))
                == PathB(pathComponents: ["foo", "bar"])
        )

        #expect(
            try AnyPath(converting: PathA(pathComponents: ["foo", "bar"]))
                == AnyPath(pathComponents: ["foo", "bar"])
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
