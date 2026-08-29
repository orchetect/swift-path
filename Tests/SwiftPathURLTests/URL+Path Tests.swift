//
//  URL+Path Tests.swift
//  SwiftPath
//

import Foundation
import SwiftPath
import Testing

/// Tests `URL` conforming to `Path` using default parse strategies and format styles provided
/// by the library.
@Suite
struct URL_Path_Tests {
    @Test
    func init_pathString() throws {
        let url = try URL(pathString: "/foo/bar")
        #expect(url.absoluteString == "path://hostname/foo/bar")
    }

    @Test
    func pathString() throws {
        let url = try #require(URL(string: "path://hostname/foo/bar"))
        #expect(url.pathString == "/foo/bar")
    }

    @Test
    func roundTrip() throws {
        let url = try URL(pathString: "/foo/bar")
        #expect(url.absoluteString == "path://hostname/foo/bar")
        #expect(url.pathString == "/foo/bar")
    }
}
