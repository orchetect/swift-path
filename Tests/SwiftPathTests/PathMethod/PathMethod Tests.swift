//
//  PathMethod Tests.swift
//  SwiftPath
//

import Testing
import SwiftPath

/// This suite tests implementing a custom type conforming to `PathMethod`.
@Suite
struct PathMethod_Tests {
    @Test
    func path_pathString() throws {
        #expect(MyMethod().path.pathString == "/foo/bar")
        #expect(MyMethod().values.int == 1)
    }
}

// MARK: - Test Types - `MyMethod`

private struct MyMethod {
    let path: AnyPath = AnyPath(pathComponents: PathComponents(["foo", "bar"]))

    let values: Values = Values(int: 1)

    init() { }
}

extension MyMethod: PathMethod {
    struct Values: PathMethodParameterValues {
        let int: Int

        init(int: Int) {
            self.int = int
        }
    }
}
