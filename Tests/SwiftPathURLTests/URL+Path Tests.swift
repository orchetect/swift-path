//
//  URL+Path Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftPath
import Testing

/// Tests `URL` conforming to `Path` using default parse strategies and format styles provided
/// by the library.
@Suite
struct URL_Path_Tests {
    // MARK: - `StringParseablePath`

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func init_pathString() throws {
        let url = try URL(pathString: "/foo/bar")
        #expect(url.absoluteString == "path://hostname/foo/bar")
    }

    // MARK: - `StringFormattablePath`

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func pathString() throws {
        let url = try #require(URL(string: "path://hostname/foo/bar"))
        #expect(url.pathString == "/foo/bar")
    }

    // MARK: - `StringParseablePath` & `StringFormattablePath`

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func roundTrip() throws {
        let url = try URL(pathString: "/foo/bar")
        #expect(url.absoluteString == "path://hostname/foo/bar")
        #expect(url.pathString == "/foo/bar")
    }
}
