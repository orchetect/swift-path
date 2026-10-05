//
//  PathMethod Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

/// This suite tests implementing a custom type conforming to `PathMethod`.
@Suite
struct PathMethod_Tests {
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func path_pathString() {
        #expect(MyMethod().path.pathString == "/foo/bar")
        #expect(MyMethod().values.int == 1)
    }
}

// MARK: - Test Types - `MyMethod`

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
private struct MyMethod {
    let path: AnyPath = .init(pathComponents: PathComponents(["foo", "bar"]))

    let values: Values = .init(int: 1)

    init() { }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension MyMethod: PathMethod {
    struct Values: PathMethodParameterValues {
        let int: Int

        init(int: Int) {
            self.int = int
        }
    }
}
