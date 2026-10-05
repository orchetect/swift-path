//
//  URL PathComponentsFormatStyle Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftPath
import Testing

@Suite
struct URL_PathComponentsFormatStyle_Tests {
    @Test
    func composition() {
        let style: URL.PathComponentsFormatStyle = .pathComponents
        // does not have any chainable composition methods
        _ = style
    }

    @Test
    func formatted() {
        // scheme only
        #expect(
            URL(string: "path:")?.formatted(.pathComponents)
                == PathComponents([])
        )

        // scheme + host only
        #expect(
            URL(string: "path://hostname")?.formatted(.pathComponents)
                == PathComponents([])
        )
        #expect(
            URL(string: "path://hostname/")?.formatted(.pathComponents)
                == PathComponents([])
        )

        // scheme + path only
        #expect(
            URL(string: "path:/")?.formatted(.pathComponents)
                == PathComponents([])
        )
        #expect(
            URL(string: "path:foo")?.formatted(.pathComponents)
                == PathComponents(["foo"])
        )
        #expect(
            URL(string: "path:/foo")?.formatted(.pathComponents)
                == PathComponents(["foo"])
        )
        #expect(
            URL(string: "path:foo/bar/")?.formatted(.pathComponents)
                == PathComponents(["foo", "bar"])
        )

        // host + path only
        #expect(
            URL(string: "//hostname")?.formatted(.pathComponents)
                == PathComponents([])
        )
        #expect(
            URL(string: "//hostname/")?.formatted(.pathComponents)
                == PathComponents([])
        )
        #expect(
            URL(string: "//hostname/foo")?.formatted(.pathComponents)
                == PathComponents(["foo"])
        )
        #expect(
            URL(string: "//hostname/foo/bar/")?.formatted(.pathComponents)
                == PathComponents(["foo", "bar"])
        )

        // scheme + host + path
        #expect(
            URL(string: "path://hostname")?.formatted(.pathComponents)
                == PathComponents([])
        )
        #expect(
            URL(string: "path://hostname/")?.formatted(.pathComponents)
                == PathComponents([])
        )
        #expect(
            URL(string: "path://hostname/foo")?.formatted(.pathComponents)
                == PathComponents(["foo"])
        )
        #expect(
            URL(string: "path://hostname/foo/bar/")?.formatted(.pathComponents)
                == PathComponents(["foo", "bar"])
        )
    }

    @Test
    func format_edgeCases() throws {
        // format style ignores all URL components (including scheme and hostname)
        // other than path components
        let formatter = URL.PathComponentsFormatStyle()

        #expect(try formatter.format(#require(URL(string: "path://myhost"))) == [])
        #expect(try formatter.format(#require(URL(string: "path://myhost/"))) == [])
        #expect(try formatter.format(#require(URL(string: "path://myhost//"))) == [])
        #expect(try formatter.format(#require(URL(string: "path://myhost///"))) == [])
        #expect(try formatter.format(#require(URL(string: "path://myhost////"))) == [])
        #expect(try formatter.format(#require(URL(string: "path://myhost//one"))) == ["one"])
        #expect(try formatter.format(#require(URL(string: "path://myhost/one"))) == ["one"])
        #expect(try formatter.format(#require(URL(string: "path://myhost//one/"))) == ["one"])
        #expect(try formatter.format(#require(URL(string: "path://myhost/one/"))) == ["one"])
        #expect(try formatter.format(#require(URL(string: "path://myhost//one//"))) == ["one"])
        #expect(try formatter.format(#require(URL(string: "path://myhost///one/"))) == ["one"])
        #expect(try formatter.format(#require(URL(string: "path://myhost///one//"))) == ["one"])
        #expect(try formatter.format(#require(URL(string: "path://myhost//one/launch"))) == ["one", "launch"])
        #expect(try formatter.format(#require(URL(string: "path://myhost//one/launch/"))) == ["one", "launch"])
        #expect(try formatter.format(#require(URL(string: "path://myhost/one/launch/"))) == ["one", "launch"])
        #expect(try formatter.format(#require(URL(string: "path://myhost/one/launch"))) == ["one", "launch"])
        #expect(try formatter.format(#require(URL(string: "path://myhost//One/Launch"))) == ["One", "Launch"])
        #expect(try formatter.format(#require(URL(string: "path://myhost//ONE/LAUNCH"))) == ["ONE", "LAUNCH"])
        #expect(try formatter.format(#require(URL(string: "path://myhost/."))) == ["."])
        #expect(try formatter.format(#require(URL(string: "path://myhost/.."))) == [".."])
        #expect(try formatter.format(#require(URL(string: "path://myhost/./"))) == ["."])
        #expect(try formatter.format(#require(URL(string: "path://myhost//./"))) == ["."])
        #expect(try formatter.format(#require(URL(string: "path://myhost//."))) == ["."])
    }
}
