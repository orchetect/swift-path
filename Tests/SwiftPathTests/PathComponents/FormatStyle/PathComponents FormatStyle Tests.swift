//
//  PathComponents FormatStyle Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

@Suite
struct PathComponents_FormatStyle_Tests {
    @Test
    func composition() {
        let style: PathComponents.FormatStyle = .pathComponents
            .root(.relative)
            .rootSeparator(">")
            .pathSeparator(".")
        #expect(style.root == .relative)
        #expect(style.rootSeparator == ">")
        #expect(style.pathSeparator == ".")
    }

    @Test
    func formatAbsoluteRoot() {
        let style: PathComponents.FormatStyle = .pathComponents
            .root(.absolute)

        #expect(style.format([]) == "/")
        #expect(style.format([""]) == "/")
        #expect(style.format(["", ""]) == "//")
        #expect(style.format(["", "", ""]) == "///")
        #expect(style.format(["one"]) == "/one")
        #expect(style.format(["one", "launch"]) == "/one/launch")
        #expect(style.format(["one", "launch", ""]) == "/one/launch/")
        #expect(style.format(["one", "", "launch"]) == "/one//launch")
        #expect(style.format(["", "one", "launch"]) == "//one/launch")
        #expect(style.format(["", "", "one", "", "", "launch", "", ""]) == "///one///launch//")
        #expect(style.format(["One", "Launch"]) == "/One/Launch")
        #expect(style.format(["ONE", "LAUNCH"]) == "/ONE/LAUNCH")

        // "invalid", but a FormatStyle cannot throw, so it can't validate what it's formatting
        #expect(style.format(["//", "///"]) == "///////")
    }

    @Test
    func formatRelativeRoot() {
        let style: PathComponents.FormatStyle = .pathComponents
            .root(.relative)

        #expect(style.format([]) == "")
        #expect(style.format([""]) == "")
        #expect(style.format(["", ""]) == "/")
        #expect(style.format(["", "", ""]) == "//")
        #expect(style.format(["one"]) == "one")
        #expect(style.format(["one", "launch"]) == "one/launch")
        #expect(style.format(["one", "launch", ""]) == "one/launch/")
        #expect(style.format(["one", "", "launch"]) == "one//launch")
        #expect(style.format(["", "one", "launch"]) == "/one/launch")
        #expect(style.format(["", "", "one", "", "", "launch", "", ""]) == "//one///launch//")
        #expect(style.format(["One", "Launch"]) == "One/Launch")
        #expect(style.format(["ONE", "LAUNCH"]) == "ONE/LAUNCH")

        // "invalid", but a FormatStyle cannot throw, so it can't validate what it's formatting
        #expect(style.format(["//", "///"]) == "//////")
    }
}
