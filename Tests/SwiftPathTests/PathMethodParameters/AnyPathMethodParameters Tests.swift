//
//  AnyPathMethodParameters Tests.swift
//  SwiftPath
//

import Testing
import SwiftPath

@Suite
struct AnyPathParameters_Tests {
    @Test
    func initA() throws {
        let params = AnyPathMethodParameters(parameters: (AnyPathMethodParameter.int(label: "int"), AnyPathMethodParameter.string(label: "string")))
        #expect(params.parameters.0.label == "int")
        #expect(params.parameters.1.label == "string")
    }

    @Test
    func initB() throws {
        let tuple = (AnyPathMethodParameter.int(label: "int"), AnyPathMethodParameter.string(label: "string"))
        let params = AnyPathMethodParameters(parameters: tuple)
        #expect(params.parameters.0.label == "int")
        #expect(params.parameters.1.label == "string")
    }

    @Test
    func initC() throws {
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

    @Test
    func initD() throws {
        typealias MyParameters = AnyPathMethodParameters<AnyPathMethodParameter<Int>, AnyPathMethodParameter<String>>
        let tuple /* : MyParameters.Parameters */ = (AnyPathMethodParameter.int(label: "int"), AnyPathMethodParameter.string(label: "string"))

        // doesn't work; Swift can't parse tuple in generic constraint
        // let params: PathParameters<MyParameters.Parameters>
        // params = PathParameters(parameters: tuple)

        // generics have to be manually specified without tuple encapsulation
        let params: MyParameters
        params = AnyPathMethodParameters(parameters: tuple)

        #expect(params.parameters.0.label == "int")
        #expect(params.parameters.1.label == "string")
    }

    @Test
    func staticConstructor() throws {
        let params: AnyPathMethodParameters = .testParams
        #expect(params.parameters.0.label == "int")
        #expect(params.parameters.1.label == "string")
    }

    @Test
    func anyParameters() throws {
        let params = AnyPathMethodParameters(parameters: (AnyPathMethodParameter.int(label: "int"), AnyPathMethodParameter.string(label: "string")))
        let labels = params.anyParameters.map(\.label)
        #expect(params.count == 2)
        #expect(params.anyParameters.count == 2)
        #expect(labels == ["int", "string"])
    }

    @Test
    func cast() throws {
        let params = AnyPathMethodParameters(parameters: (AnyPathMethodParameter.int(label: "int"), AnyPathMethodParameter.string(label: "string")))

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

    @Test
    func castOptional() throws {
        let params = AnyPathMethodParameters(parameters: (AnyPathMethodParameter.int(label: "int"), AnyPathMethodParameter.string(label: "string")))

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

extension AnyPathMethodParameters {
    fileprivate static var testParams: AnyPathMethodParameters<AnyPathMethodParameter<Int>, AnyPathMethodParameter<String>> {
        .init(parameters: (.int(label: "int"), .string(label: "string")))
    }
}
