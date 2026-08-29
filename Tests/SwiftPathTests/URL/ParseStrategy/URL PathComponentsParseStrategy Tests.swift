//
//  URL PathComponentsParseStrategy Tests.swift
//  SwiftPath
//

import Foundation
import Testing
import SwiftPath

@Suite
struct URL_PathComponentsParseStrategy_Tests {
    @Test
    func composition() throws {
        let style: URL.PathComponentsParseStrategy = .pathComponents
            .scheme("path")
            .host("hostname")
        #expect(style.scheme == "path")
        #expect(style.host == "hostname")
    }

    @Test
    func initValueStrategy() throws {
        // path only
        #expect(
            try URL(PathComponents([]), strategy: .pathComponents)
                .absoluteString == ""
        )
        #expect(
            try URL(PathComponents(["foo"]), strategy: .pathComponents)
                .absoluteString == "foo"
        )
        #expect(
            try URL(PathComponents(["foo", "bar"]), strategy: .pathComponents)
                .absoluteString == "foo/bar"
        )

        // scheme + path only
        #expect(
            try URL(PathComponents([]), strategy: .pathComponents.scheme("path"))
                .absoluteString == "path:"
        )
        #expect(
            try URL(PathComponents(["foo"]), strategy: .pathComponents.scheme("path"))
                .absoluteString == "path:foo"
        )
        #expect(
            try URL(PathComponents(["foo", "bar"]), strategy: .pathComponents.scheme("path"))
                .absoluteString == "path:foo/bar"
        )

        // scheme + host + path
        #expect(
            try URL(PathComponents([]), strategy: .pathComponents.scheme("path").host("hostname"))
                .absoluteString == "path://hostname"
        )
        #expect(
            try URL(PathComponents(["foo"]), strategy: .pathComponents.scheme("path").host("hostname"))
                .absoluteString == "path://hostname/foo"
        )
        #expect(
            try URL(PathComponents(["foo", "bar"]), strategy: .pathComponents.scheme("path").host("hostname"))
                .absoluteString == "path://hostname/foo/bar"
        )

        // host + path
        #expect(
            try URL(PathComponents([]), strategy: .pathComponents.host("hostname"))
                .absoluteString == "//hostname"
        )
        #expect(
            try URL(PathComponents(["foo"]), strategy: .pathComponents.host("hostname"))
                .absoluteString == "//hostname/foo"
        )
        #expect(
            try URL(PathComponents(["foo", "bar"]), strategy: .pathComponents.host("hostname"))
                .absoluteString == "//hostname/foo/bar"
        )
    }

    @Test
    func parse_edgeCases() throws {
        let parser = URL.PathComponentsParseStrategy(scheme: "path", host: "myhost")

        #expect(try parser.parse([]).absoluteString == "path://myhost")
        #expect(try parser.parse([""]).absoluteString == "path://myhost/")
        #expect(try parser.parse(["", ""]).absoluteString == "path://myhost//")
        #expect(try parser.parse(["", "", ""]).absoluteString == "path://myhost///")
        #expect(try parser.parse(["one"]).absoluteString == "path://myhost/one")
        #expect(try parser.parse(["one", "launch"]).absoluteString == "path://myhost/one/launch")
        #expect(try parser.parse(["one", "launch", ""]).absoluteString == "path://myhost/one/launch/")
        #expect(try parser.parse(["one", "", "launch"]).absoluteString == "path://myhost/one//launch")
        #expect(try parser.parse(["", "one", "launch"]).absoluteString == "path://myhost//one/launch")
        #expect(try parser.parse(["", "", "one", "", "", "launch", "", ""]).absoluteString == "path://myhost///one///launch//")
    }
}
