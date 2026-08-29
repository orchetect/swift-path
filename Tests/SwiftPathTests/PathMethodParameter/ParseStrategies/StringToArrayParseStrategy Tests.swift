//
//  StringToArrayParseStrategy Tests.swift
//  SwiftPath
//

import Testing
import SwiftPath

/// This suite tests:
/// - `[Type]` static constructors
/// - String parsing results
@Suite
struct StringToArrayParseStrategy_Tests {
    @Test
    func baseline() throws {
        let param = AnyPathMethodParameter<[Int]>(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == [Int].self)
    }

    @Test
    func concreteType_defaultSeparator() throws {
        let param = AnyPathMethodParameter<[Int]>(label: "test")

        let strategy = StringToArrayParseStrategy(of: Int.self, transform: .int)

        #expect(try param.parse("", strategy: strategy) == [])
        #expect(try param.parse("1", strategy: strategy) == [1])
        #expect(try param.parse("1,2", strategy: strategy) == [1, 2])
        #expect(try param.parse("3,1,2", strategy: strategy) == [3, 1, 2])

        #expect(throws: (any Error).self) {
            _ = try param.parse(" ", strategy: strategy)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("abc", strategy: strategy)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse(",", strategy: strategy)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse(",1,2,", strategy: strategy)
        }
    }

    @Test
    func concreteType_customSeparator() throws {
        let param = AnyPathMethodParameter<[Int]>(label: "test")

        let strategy = StringToArrayParseStrategy(of: Int.self, separator: "|", transform: .int)

        #expect(try param.parse("", strategy: strategy) == [])
        #expect(try param.parse("1", strategy: strategy) == [1])
        #expect(try param.parse("1|2", strategy: strategy) == [1, 2])
        #expect(try param.parse("3|1|2", strategy: strategy) == [3, 1, 2])

        #expect(throws: (any Error).self) {
            _ = try param.parse(" ", strategy: strategy)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("abc", strategy: strategy)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("|", strategy: strategy)
        }
        #expect(throws: (any Error).self) {
            _ = try param.parse("|1|2|", strategy: strategy)
        }
    }

    @Test
    func concreteStatic_defaultSeparator() throws {
        let param = AnyPathMethodParameter<[Int]>(label: "test")

        #expect(try param.parse("", strategy: [Int].stringParseStrategy(transform: .int)) == [])
        #expect(try param.parse("1", strategy: [Int].stringParseStrategy(transform: .int)) == [1])
        #expect(try param.parse("1,2", strategy: [Int].stringParseStrategy(transform: .int)) == [1, 2])
        #expect(try param.parse("3,1,2", strategy: [Int].stringParseStrategy(transform: .int)) == [3, 1, 2])
    }

    @Test
    func concreteStatic_customSeparator() throws {
        let param = AnyPathMethodParameter<[Int]>(label: "test")

        #expect(try param.parse("", strategy: [Int].stringParseStrategy(separator: "|", transform: .int)) == [])
        #expect(try param.parse("1", strategy: [Int].stringParseStrategy(separator: "|", transform: .int)) == [1])
        #expect(try param.parse("1|2", strategy: [Int].stringParseStrategy(separator: "|", transform: .int)) == [1, 2])
        #expect(try param.parse("3|1|2", strategy: [Int].stringParseStrategy(separator: "|", transform: .int)) == [3, 1, 2])
    }

    @Test
    func separatorComposition() throws {
        let param = AnyPathMethodParameter<[Int]>(label: "test")

        #expect(try param.parse("", strategy: [Int].stringParseStrategy(transform: .int).separator("|")) == [])
        #expect(try param.parse("1", strategy: [Int].stringParseStrategy(transform: .int).separator("|")) == [1])
        #expect(try param.parse("1|2", strategy: [Int].stringParseStrategy(transform: .int).separator("|")) == [1, 2])
        #expect(try param.parse("3|1|2", strategy: [Int].stringParseStrategy(transform: .int).separator("|")) == [3, 1, 2])

    }
}
