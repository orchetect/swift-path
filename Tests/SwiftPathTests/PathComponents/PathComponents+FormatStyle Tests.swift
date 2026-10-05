//
//  PathComponents+FormatStyle Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

@Suite
struct PathComponents_and_FormatStyle_Tests {
    @Test
    func formattedStrategy() {
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
