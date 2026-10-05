//
//  URL PathComponentsParseStrategy Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftPath
import Testing

@Suite
struct URL_PathComponentsParseStrategy_Tests {
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func composition() {
        let style: URL.PathComponentsParseStrategy = .pathComponents
            .scheme("path")
            .host("hostname")
        #expect(style.scheme == "path")
        #expect(style.host == "hostname")
    }

    @available(macOS 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *)
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

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
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
