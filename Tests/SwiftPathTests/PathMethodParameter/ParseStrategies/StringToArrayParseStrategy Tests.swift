//
//  StringToArrayParseStrategy Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

/// This suite tests:
/// - `[Type]` static constructors
/// - String parsing results
@Suite
struct StringToArrayParseStrategy_Tests {
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func baseline() {
        let param = AnyPathMethodParameter<[Int]>(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == [Int].self)
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
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

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
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

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func concreteStatic_defaultSeparator() throws {
        let param = AnyPathMethodParameter<[Int]>(label: "test")

        #expect(try param.parse("", strategy: [Int].stringParseStrategy(transform: .int)) == [])
        #expect(try param.parse("1", strategy: [Int].stringParseStrategy(transform: .int)) == [1])
        #expect(try param.parse("1,2", strategy: [Int].stringParseStrategy(transform: .int)) == [1, 2])
        #expect(try param.parse("3,1,2", strategy: [Int].stringParseStrategy(transform: .int)) == [3, 1, 2])
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func concreteStatic_customSeparator() throws {
        let param = AnyPathMethodParameter<[Int]>(label: "test")

        #expect(try param.parse("", strategy: [Int].stringParseStrategy(separator: "|", transform: .int)) == [])
        #expect(try param.parse("1", strategy: [Int].stringParseStrategy(separator: "|", transform: .int)) == [1])
        #expect(try param.parse("1|2", strategy: [Int].stringParseStrategy(separator: "|", transform: .int)) == [1, 2])
        #expect(try param.parse("3|1|2", strategy: [Int].stringParseStrategy(separator: "|", transform: .int)) == [3, 1, 2])
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func separatorComposition() throws {
        let param = AnyPathMethodParameter<[Int]>(label: "test")

        #expect(try param.parse("", strategy: [Int].stringParseStrategy(transform: .int).separator("|")) == [])
        #expect(try param.parse("1", strategy: [Int].stringParseStrategy(transform: .int).separator("|")) == [1])
        #expect(try param.parse("1|2", strategy: [Int].stringParseStrategy(transform: .int).separator("|")) == [1, 2])
        #expect(try param.parse("3|1|2", strategy: [Int].stringParseStrategy(transform: .int).separator("|")) == [3, 1, 2])
    }
}
