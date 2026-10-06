//
//  PathComponents ParseStrategy Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

@Suite
struct PathComponents_ParseStrategy_Tests {
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func composition() {
        let strategy: PathComponents.ParseStrategy = .pathComponents
            .root(.relative)
            .rootSeparator(">")
            .pathSeparator(".")
        #expect(strategy.root == .relative)
        #expect(strategy.rootSeparator == ">")
        #expect(strategy.pathSeparator == ".")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
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

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
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

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
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
