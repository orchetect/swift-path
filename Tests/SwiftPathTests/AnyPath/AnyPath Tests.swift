//
//  AnyPath Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftPath
import Testing

@Suite
struct AnyPath_Tests {
    // MARK: - `Path`

    @Test
    func init_pathComponents() {
        #expect(AnyPath(pathComponents: []).pathComponents == [])
        #expect(AnyPath(pathComponents: ["a", "b"]).pathComponents == ["a", "b"])
    }

    // MARK: - `Equatable`

    @Test
    func equatable() {
        #expect(AnyPath(pathComponents: []) == AnyPath(pathComponents: []))
        #expect(AnyPath(pathComponents: ["a", "b"]) == AnyPath(pathComponents: ["a", "b"]))
        #expect(AnyPath(pathComponents: ["a", "b"]) != AnyPath(pathComponents: []))
    }

    // MARK: - `Hashable`

    @Test
    func hashable() {
        let paths: Set<AnyPath> = [
            AnyPath(pathComponents: ["a", "b"]),
            AnyPath(pathComponents: ["a", "b"]),
            AnyPath(pathComponents: ["a", "b"])
        ]
        #expect(paths.count == 1)
    }

    // MARK: `Sendable`

    @Test
    func sendable() {
        final class TestClass: Sendable {
            let path: AnyPath

            init(path: AnyPath) {
                self.path = path
            }
        }
        let tc = TestClass(path: AnyPath(pathComponents: ["a", "b"]))
        #expect(tc.path.pathComponents == ["a", "b"])
    }

    // MARK: - `StringParseablePath`

    @Test
    func init_pathString() throws {
        #expect(try AnyPath(pathString: "").pathComponents == [])
        #expect(try AnyPath(pathString: "/").pathComponents == [])
        #expect(try AnyPath(pathString: "a/b").pathComponents == ["a", "b"])
        #expect(try AnyPath(pathString: "/a/b").pathComponents == ["a", "b"])
        #expect(try AnyPath(pathString: "/a/b/").pathComponents == ["a", "b"])
        #expect(try AnyPath(pathString: "a/b/").pathComponents == ["a", "b"])
    }

    // MARK: `StringFormattablePath`

    @Test
    func pathString() {
        #expect(AnyPath(pathComponents: []).pathString == "/")
        #expect(AnyPath(pathComponents: ["a", "b"]).pathString == "/a/b")
    }

    // MARK: - `Codable` by way of `StringDecodablePath`/`StringEncodablePath`

    @Test
    func stringEncodeDecode() throws {
        let original = AnyPath(pathComponents: ["a", "b"])

        let encoder = JSONEncoder()
        let encoded = try encoder.encode(original)

        // verify encoded format is a path string as a single value
        // and that it uses the string format style provided
        let encodedString = try #require(String(data: encoded, encoding: .utf8))
        #expect(encodedString == #""\/a\/b""#)

        let decoder = JSONDecoder()
        let decoded = try decoder.decode(AnyPath.self, from: encoded)

        #expect(decoded == original)
    }
}
