//
//  PathComponents ParseStrategy Tests.swift
//  SwiftPath
//

import Testing
import SwiftPath

@Suite
struct PathComponents_ParseStrategy_Tests {
    @Test
    func composition() throws {
        let strategy: PathComponents.ParseStrategy = .pathComponents
            .root(.relative)
            .rootSeparator(">")
            .pathSeparator(".")
        #expect(strategy.root == .relative)
        #expect(strategy.rootSeparator == ">")
        #expect(strategy.pathSeparator == ".")
    }

    @Test
    func parseAbsoluteOrRelativeRoot() throws {
        let strategy: PathComponents.ParseStrategy = .pathComponents
            .root(nil)

        #expect(try strategy.parse("/") == [])
        #expect(try strategy.parse("//") == [""])
        #expect(try strategy.parse("///") == ["", ""])
        #expect(try strategy.parse("/one") == ["one"])
        #expect(try strategy.parse("one") == ["one"])
        #expect(try strategy.parse("/one/") == ["one"])
        #expect(try strategy.parse("one/") == ["one"])
        #expect(try strategy.parse("/one//") == ["one", ""])
        #expect(try strategy.parse("//one/") == ["", "one"])
        #expect(try strategy.parse("//one//") == ["", "one", ""])
        #expect(try strategy.parse("/one/launch") == ["one", "launch"])
        #expect(try strategy.parse("/one/launch/") == ["one", "launch"])
        #expect(try strategy.parse("one/launch/") == ["one", "launch"])
        #expect(try strategy.parse("one/launch") == ["one", "launch"])
        #expect(try strategy.parse("/One/Launch") == ["One", "Launch"])
        #expect(try strategy.parse("/ONE/LAUNCH") == ["ONE", "LAUNCH"])
        #expect(try strategy.parse(".") == ["."])
        #expect(try strategy.parse("..") == [".."])
        #expect(try strategy.parse("./") == ["."])
        #expect(try strategy.parse("/./") == ["."])
        #expect(try strategy.parse("/.") == ["."])
    }

    @Test
    func parseAbsoluteRoot() throws {
        let strategy: PathComponents.ParseStrategy = .pathComponents
            .root(.absolute)

        #expect(try strategy.parse("/") == [])
        #expect(try strategy.parse("//") == [""])
        #expect(try strategy.parse("///") == ["", ""])
        #expect(try strategy.parse("/one") == ["one"])
        #expect((try? strategy.parse("one")) == nil)
        #expect(try strategy.parse("/one/") == ["one"])
        #expect((try? strategy.parse("one/")) == nil)
        #expect(try strategy.parse("/one//") == ["one", ""])
        #expect(try strategy.parse("//one/") == ["", "one"])
        #expect(try strategy.parse("//one//") == ["", "one", ""])
        #expect(try strategy.parse("/one/launch") == ["one", "launch"])
        #expect(try strategy.parse("/one/launch/") == ["one", "launch"])
        #expect((try? strategy.parse("one/launch/")) == nil)
        #expect((try? strategy.parse("one/launch")) == nil)
        #expect(try strategy.parse("/One/Launch") == ["One", "Launch"])
        #expect(try strategy.parse("/ONE/LAUNCH") == ["ONE", "LAUNCH"])
        #expect((try? strategy.parse(".")) == nil)
        #expect((try? strategy.parse("..")) == nil)
        #expect((try? strategy.parse("./")) == nil)
        #expect(try strategy.parse("/./") == ["."])
        #expect(try strategy.parse("/.") == ["."])
    }

    @Test
    func parseRelativeRoot() throws {
        let strategy: PathComponents.ParseStrategy = .pathComponents
            .root(.relative)

        #expect((try? strategy.parse("/")) == nil)
        #expect((try? strategy.parse("//")) == nil)
        #expect((try? strategy.parse("///")) == nil)
        #expect((try? strategy.parse("/one")) == nil)
        #expect(try strategy.parse("one") == ["one"])
        #expect((try? strategy.parse("/one/")) == nil)
        #expect(try strategy.parse("one/") == ["one"])
        #expect((try? strategy.parse("/one//")) == nil)
        #expect((try? strategy.parse("//one/")) == nil)
        #expect((try? strategy.parse("//one//")) == nil)
        #expect((try? strategy.parse("/one/launch")) == nil)
        #expect((try? strategy.parse("/one/launch/")) == nil)
        #expect(try strategy.parse("one/launch/") == ["one", "launch"])
        #expect(try strategy.parse("one/launch") == ["one", "launch"])
        #expect((try? strategy.parse("/One/Launch")) == nil)
        #expect((try? strategy.parse("/ONE/LAUNCH")) == nil)
        #expect(try strategy.parse(".") == ["."])
        #expect(try strategy.parse("..") == [".."])
        #expect(try strategy.parse("./") == ["."])
        #expect((try? strategy.parse("/./")) == nil)
        #expect((try? strategy.parse("/.")) == nil)
    }
}
