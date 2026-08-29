//
//  PathMethodParameter Tests.swift
//  SwiftPath
//

import Testing
import SwiftPath

/// This suite contains basic tests for the `PathMethodParameter` protocol in various scenarios
/// using type erasure or generic constraints.
@Suite
struct PathParameter_Tests {
    @Test
    func anyProtocol() throws {
        let param: any PathMethodParameter = .int(label: "test")
        #expect(param.label == "test")
        // can't use `format()` or `parse()` on an `any` protocol because they have associated generics
    }

    @Test
    func protocolConstrainedFormatMethodParameter() throws {
        func format<P: PathMethodParameter>(value: Int, using param: P) -> String where P.Value == Int {
            param.format(value, format: .string)
        }

        #expect(format(value: 123, using: .int(label: "test")) == "123")
    }

    @Test
    func protocolConstrainedParseMethodParameter() throws {
        func parse<P: PathMethodParameter>(string: String, using param: P) throws -> Int where P.Value == Int {
            try param.parse(string, strategy: .int)
        }

        #expect(try parse(string: "123",  using: .int(label: "test")) == 123)
    }

    @Test
    func cast_empty() throws {
        #expect(try SwiftPath.cast(values: [], required: (), optional: ()) == ())
    }

    @Test
    func cast_requiredOnly() throws {
        let req = (AnyPathMethodParameter.int(label: "int"), AnyPathMethodParameter.string(label: "string"))

        #expect(
            try SwiftPath.cast(values: [123, "foo"], required: req, optional: ())
                == (123, "foo")
        )

        #expect(throws: (any Error).self) {
            _ = try SwiftPath.cast(values: [], required: req, optional: ())
        }
        #expect(throws: (any Error).self) {
            _ = try SwiftPath.cast(values: [123], required: req, optional: ())
        }
        #expect(throws: (any Error).self) {
            _ = try SwiftPath.cast(values: ["Test"], required: req, optional: ())
        }
        #expect(throws: (any Error).self) {
            _ = try SwiftPath.cast(values: ["Test", 123], required: req, optional: ())
        }
        #expect(throws: (any Error).self) {
            _ = try SwiftPath.cast(values: [123, "Test", true], required: req, optional: ())
        }
    }

    @Test
    func cast_optionalOnly() throws {
        let opt = (AnyPathMethodParameter.bool(label: "bool"), AnyPathMethodParameter.string(label: "string"))

        #expect(
            try SwiftPath.cast(values: [true, "bar"], required: (), optional: opt)
                == (true as Bool?, "bar" as String?)
        )
        #expect(
            try SwiftPath.cast(values: [true], required: (), optional: opt)
                == (true as Bool?, nil as String?)
        )
        #expect(
            try SwiftPath.cast(values: [], required: (), optional: opt)
                == (nil as Bool?, nil as String?)
        )

        #expect(throws: (any Error).self) {
            _ = try SwiftPath.cast(values: [123], required: (), optional: opt)
        }
        #expect(throws: (any Error).self) {
            _ = try SwiftPath.cast(values: ["bar"], required: (), optional: opt)
        }
        #expect(throws: (any Error).self) {
            _ = try SwiftPath.cast(values: ["bar", true], required: (), optional: opt)
        }
        #expect(throws: (any Error).self) {
            _ = try SwiftPath.cast(values: [true, "bar", 123], required: (), optional: opt)
        }
        #expect(throws: (any Error).self) {
            _ = try SwiftPath.cast(values: [(nil as Bool?) as Any], required: (), optional: opt)
        }
        #expect(throws: (any Error).self) {
            _ = try SwiftPath.cast(values: [(nil as Bool?) as Any, (nil as String?) as Any], required: (), optional: opt)
        }
    }

    @Test
    func cast_requiredAndOptional() throws {
        let req = (AnyPathMethodParameter.int(label: "int"), AnyPathMethodParameter.string(label: "string"))
        let opt = (AnyPathMethodParameter.bool(label: "bool"), AnyPathMethodParameter.string(label: "string"))

        #expect(
            try SwiftPath.cast(values: [123, "foo", true, "bar"], required: req, optional: opt)
                == (123, "foo", true as Bool?, "bar" as String?)
        )
        #expect(
            try SwiftPath.cast(values: [123, "foo", true], required: req, optional: opt)
                == (123, "foo", true as Bool?, nil as String?)
        )
        #expect(
            try SwiftPath.cast(values: [123, "foo"], required: req, optional: opt)
                == (123, "foo", nil as Bool?, nil as String?)
        )

        #expect(throws: (any Error).self) {
            _ = try SwiftPath.cast(values: [], required: req, optional: opt)
        }
        #expect(throws: (any Error).self) {
            _ = try SwiftPath.cast(values: [123], required: req, optional: opt)
        }
        #expect(throws: (any Error).self) {
            _ = try SwiftPath.cast(values: ["Test"], required: req, optional: opt)
        }
        #expect(throws: (any Error).self) {
            _ = try SwiftPath.cast(values: ["Test", 123], required: req, optional: opt)
        }
        #expect(throws: (any Error).self) {
            _ = try SwiftPath.cast(values: [123, "Test", true, "bar", false], required: req, optional: opt)
        }
    }
}
