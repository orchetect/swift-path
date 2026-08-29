//
//  PathComponents+FormatStyle Tests.swift
//  SwiftPath
//

import Testing
import SwiftPath

@Suite
struct PathComponents_and_FormatStyle_Tests {
    @Test
    func formattedStrategy() throws {
        #expect(
            PathComponents(["foo", "bar"])
                .formatted(.pathComponents) // default
                == "/foo/bar"
        )

        // root types
        #expect(
            PathComponents(["foo", "bar"])
                .formatted(.pathComponents.root(.absolute))
                == "/foo/bar"
        )
        #expect(
            PathComponents(["foo", "bar"])
                .formatted(.pathComponents.root(.relative))
                == "foo/bar"
        )

        // custom root & path separators
        #expect(
            PathComponents(["foo", "bar"])
                .formatted(.pathComponents.rootSeparator("/").pathSeparator("/"))
                == "/foo/bar"
        )
        #expect(
            PathComponents(["foo", "bar"])
                .formatted(.pathComponents.rootSeparator(">").pathSeparator("."))
                == ">foo.bar"
        )

        // root types + custom root & path separators
        #expect(
            PathComponents(["foo", "bar"])
                .formatted(.pathComponents.root(.relative).rootSeparator("/").pathSeparator("/"))
                == "foo/bar"
        )
        #expect(
            PathComponents(["foo", "bar"])
                .formatted(.pathComponents.root(.relative).rootSeparator(">").pathSeparator("."))
                == "foo.bar"
        )
    }
}
