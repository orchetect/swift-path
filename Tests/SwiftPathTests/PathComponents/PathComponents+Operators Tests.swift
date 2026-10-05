//
//  PathComponents+Operators Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

@Suite
struct PathComponents_Operators_Tests {
    @Test
    func pathComponents_plus_pathComponents() {
        #expect(
            PathComponents(["foo", "bar"]) + PathComponents(["test"])
                == PathComponents(["foo", "bar", "test"])
        )
    }

    @Test
    func pathComponents_plus_stringSequence() {
        #expect(
            PathComponents(["foo", "bar"]) + ["test"] // [String]
                == PathComponents(["foo", "bar", "test"])
        )
    }

    @Test
    func pathComponents_plus_someStringSequence() {
        let sequence = ["a", "b", "c", "d"][1 ... 2] // Array<String>.SubSequence

        #expect(
            PathComponents(["foo", "bar"]) + sequence
                == PathComponents(["foo", "bar", "b", "c"])
        )
    }

    @Test
    func pathComponents_plusEquals_pathComponents() {
        var pathComponents = PathComponents(["foo", "bar"])
        pathComponents += PathComponents(["test"])
        #expect(pathComponents == PathComponents(["foo", "bar", "test"]))
    }

    @Test
    func pathComponents_plusEquals_stringSequence() {
        var pathComponents = PathComponents(["foo", "bar"])
        pathComponents += ["test"] // [String]
        #expect(pathComponents == PathComponents(["foo", "bar", "test"]))
    }

    @Test
    func pathComponents_plusEquals_someStringSequence() {
        var pathComponents = PathComponents(["foo", "bar"])
        let sequence = ["a", "b", "c", "d"][1 ... 2] // Array<String>.SubSequence
        pathComponents += sequence
        #expect(pathComponents == PathComponents(["foo", "bar", "b", "c"]))
    }
}
