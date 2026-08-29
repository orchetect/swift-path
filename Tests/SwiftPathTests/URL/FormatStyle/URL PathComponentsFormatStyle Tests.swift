//
//  URL PathComponentsFormatStyle Tests.swift
//  SwiftPath
//

import Foundation
import Testing
import SwiftPath

@Suite
struct URL_PathComponentsFormatStyle_Tests {
    @Test
    func composition() throws {
        let style: URL.PathComponentsFormatStyle = .pathComponents
        // does not have any chainable composition methods
        _ = style
    }

    @Test
    func formatted() throws {
        // scheme only
        #expect(
            URL(string: "path:")!.formatted(.pathComponents)
                == PathComponents([])
        )

        // scheme + host only
        #expect(
            URL(string: "path://hostname")!.formatted(.pathComponents)
                == PathComponents([])
        )
        #expect(
            URL(string: "path://hostname/")!.formatted(.pathComponents)
                == PathComponents([])
        )

        // scheme + path only
        #expect(
            URL(string: "path:/")!.formatted(.pathComponents)
                == PathComponents([])
        )
        #expect(
            URL(string: "path:foo")!.formatted(.pathComponents)
                == PathComponents(["foo"])
        )
        #expect(
            URL(string: "path:/foo")!.formatted(.pathComponents)
                == PathComponents(["foo"])
        )
        #expect(
            URL(string: "path:foo/bar/")!.formatted(.pathComponents)
                == PathComponents(["foo", "bar"])
        )

        // host + path only
        #expect(
            URL(string: "//hostname")!.formatted(.pathComponents)
                == PathComponents([])
        )
        #expect(
            URL(string: "//hostname/")!.formatted(.pathComponents)
                == PathComponents([])
        )
        #expect(
            URL(string: "//hostname/foo")!.formatted(.pathComponents)
                == PathComponents(["foo"])
        )
        #expect(
            URL(string: "//hostname/foo/bar/")!.formatted(.pathComponents)
                == PathComponents(["foo", "bar"])
        )

        // scheme + host + path
        #expect(
            URL(string: "path://hostname")!.formatted(.pathComponents)
                == PathComponents([])
        )
        #expect(
            URL(string: "path://hostname/")!.formatted(.pathComponents)
                == PathComponents([])
        )
        #expect(
            URL(string: "path://hostname/foo")!.formatted(.pathComponents)
                == PathComponents(["foo"])
        )
        #expect(
            URL(string: "path://hostname/foo/bar/")!.formatted(.pathComponents)
                == PathComponents(["foo", "bar"])
        )
    }

    @Test
    func format_edgeCases() throws {
        // format style ignores all URL components (including scheme and hostname)
        // other than path components
        let formatter = URL.PathComponentsFormatStyle()

        #expect(formatter.format(URL(string: "path://myhost")!) == [])
        #expect(formatter.format(URL(string: "path://myhost/")!) == [])
        #expect(formatter.format(URL(string: "path://myhost//")!) == [])
        #expect(formatter.format(URL(string: "path://myhost///")!) == [])
        #expect(formatter.format(URL(string: "path://myhost////")!) == [])
        #expect(formatter.format(URL(string: "path://myhost//one")!) == ["one"])
        #expect(formatter.format(URL(string: "path://myhost/one")!) == ["one"])
        #expect(formatter.format(URL(string: "path://myhost//one/")!) == ["one"])
        #expect(formatter.format(URL(string: "path://myhost/one/")!) == ["one"])
        #expect(formatter.format(URL(string: "path://myhost//one//")!) == ["one"])
        #expect(formatter.format(URL(string: "path://myhost///one/")!) == ["one"])
        #expect(formatter.format(URL(string: "path://myhost///one//")!) == ["one"])
        #expect(formatter.format(URL(string: "path://myhost//one/launch")!) == ["one", "launch"])
        #expect(formatter.format(URL(string: "path://myhost//one/launch/")!) == ["one", "launch"])
        #expect(formatter.format(URL(string: "path://myhost/one/launch/")!) == ["one", "launch"])
        #expect(formatter.format(URL(string: "path://myhost/one/launch")!) == ["one", "launch"])
        #expect(formatter.format(URL(string: "path://myhost//One/Launch")!) == ["One", "Launch"])
        #expect(formatter.format(URL(string: "path://myhost//ONE/LAUNCH")!) == ["ONE", "LAUNCH"])
        #expect(formatter.format(URL(string: "path://myhost/.")!) == ["."])
        #expect(formatter.format(URL(string: "path://myhost/..")!) == [".."])
        #expect(formatter.format(URL(string: "path://myhost/./")!) == ["."])
        #expect(formatter.format(URL(string: "path://myhost//./")!) == ["."])
        #expect(formatter.format(URL(string: "path://myhost//.")!) == ["."])
    }
}
