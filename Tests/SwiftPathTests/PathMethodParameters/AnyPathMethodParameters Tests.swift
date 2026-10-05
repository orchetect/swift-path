//
//  AnyPathMethodParameters Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

@Suite
struct AnyPathParameters_Tests {
    @available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
    @Test
    func initA() {
        let params = AnyPathMethodParameters(parameters: (
            AnyPathMethodParameter.int(label: "int"),
            AnyPathMethodParameter.string(label: "string")
        ))
        #expect(params.parameters.0.label == "int")
        #expect(params.parameters.1.label == "string")
    }

    @available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
    @Test
    func initB() {
        let tuple = (AnyPathMethodParameter.int(label: "int"), AnyPathMethodParameter.string(label: "string"))
        let params = AnyPathMethodParameters(parameters: tuple)
        #expect(params.parameters.0.label == "int")
        #expect(params.parameters.1.label == "string")
    }

    @available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
    @Test
    func initC() {
        typealias TupleType = (AnyPathMethodParameter<Int>, AnyPathMethodParameter<String>)
        let tuple: TupleType = (.int(label: "int"), .string(label: "string"))

        // doesn't work; Swift can't parse tuple in generic constraint
        // let params: PathParameters<TupleType>
        // params = PathParameters(parameters: tuple)

        // generics have to be manually specified without tuple encapsulation
        let params: AnyPathMethodParameters<AnyPathMethodParameter<Int>, AnyPathMethodParameter<String>>
        params = AnyPathMethodParameters(parameters: tuple)

        #expect(params.parameters.0.label == "int")
        #expect(params.parameters.1.label == "string")
    }

    @available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
    @Test
    func initD() {
        typealias MyParameters = AnyPathMethodParameters<AnyPathMethodParameter<Int>, AnyPathMethodParameter<String>>
        let tuple /* : MyParameters.Parameters */ = (
            AnyPathMethodParameter.int(label: "int"),
            AnyPathMethodParameter.string(label: "string")
        )

        // doesn't work; Swift can't parse tuple in generic constraint
        // let params: PathParameters<MyParameters.Parameters>
        // params = PathParameters(parameters: tuple)

        // generics have to be manually specified without tuple encapsulation
        let params: MyParameters
        params = AnyPathMethodParameters(parameters: tuple)

        #expect(params.parameters.0.label == "int")
        #expect(params.parameters.1.label == "string")
    }

    @available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
    @Test
    func staticConstructor() {
        let params: AnyPathMethodParameters = .testParams
        #expect(params.parameters.0.label == "int")
        #expect(params.parameters.1.label == "string")
    }

    @available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
    @Test
    func anyParameters() {
        let params = AnyPathMethodParameters(parameters: (
            AnyPathMethodParameter.int(label: "int"),
            AnyPathMethodParameter.string(label: "string")
        ))
        let labels = params.anyParameters.map(\.label)
        #expect(params.count == 2)
        #expect(params.anyParameters.count == 2)
        #expect(labels == ["int", "string"])
    }

    @available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
    @Test
    func cast() throws {
        let params = AnyPathMethodParameters(parameters: (
            AnyPathMethodParameter.int(label: "int"),
            AnyPathMethodParameter.string(label: "string")
        ))

        #expect(try params.cast(values: [123, "Test"]) == (123, "Test"))

        #expect(throws: (any Error).self) {
            _ = try params.cast(values: [])
        }
        #expect(throws: (any Error).self) {
            _ = try params.cast(values: [123])
        }
        #expect(throws: (any Error).self) {
            _ = try params.cast(values: ["Test"])
        }
        #expect(throws: (any Error).self) {
            _ = try params.cast(values: ["Test", 123])
        }
        #expect(throws: (any Error).self) {
            _ = try params.cast(values: [123, "Test", true])
        }
    }

    @available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
    @Test
    func castOptional() throws {
        let params = AnyPathMethodParameters(parameters: (
            AnyPathMethodParameter.int(label: "int"),
            AnyPathMethodParameter.string(label: "string")
        ))

        #expect(try params.castOptional(values: []) == (nil, nil))
        #expect(try params.castOptional(values: [123]) == (123 as Int?, nil))
        #expect(try params.castOptional(values: [123, "Test"]) == (123 as Int?, "Test" as String?))

        #expect(throws: (any Error).self) {
            _ = try params.castOptional(values: [true])
        }
        #expect(throws: (any Error).self) {
            _ = try params.castOptional(values: ["Test"])
        }
        #expect(throws: (any Error).self) {
            _ = try params.castOptional(values: [123, "Test", true])
        }
    }
}

// MARK: - Test Types

@available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
extension AnyPathMethodParameters {
    fileprivate static var testParams: AnyPathMethodParameters<AnyPathMethodParameter<Int>, AnyPathMethodParameter<String>> {
        .init(parameters: (.int(label: "int"), .string(label: "string")))
    }
}
