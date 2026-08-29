//
//  StringToDataParseStrategy Tests.swift
//  SwiftPath
//

import Foundation
import Testing
import SwiftPath

/// This suite tests:
/// - `AnyPathMethodParameter` static constructor for `Data` type:
///   - Compiles successfully
///   - Has correct associated generic type
///   - Label property is correctly stored
/// - `StringToDataParseStrategy`:
///   - Static constructors
///   - Composition methods
///   - All `Encoding` encodings
/// - String parsing results
@Suite
struct StringToDataParseStrategy_Tests {
    @Test
    func data() throws {
        let param = AnyPathMethodParameter.data(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Data.self)
    }

    @Test
    func init_encoding() throws {
        #expect(StringToDataParseStrategy(encoding: .base64).encoding == .base64)
    }

    @Test
    func staticConstructors() throws {
        #expect(StringToDataParseStrategy.data(encoding: .base64).encoding == .base64)
    }

    @Test
    func encodingComposition() throws {
        #expect(StringToDataParseStrategy.data.encoding(.base64).encoding == .base64)
    }

    @Test
    func defaultEncoding() throws {
        // default uses Base64
        let formatter = StringToDataParseStrategy.data

        #expect(try formatter.parse("") == Data())
        #expect(try formatter.parse("AQI=") == Data([0x01, 0x02]))

        #expect(throws: (any Error).self) {
            _ = try formatter.parse("AQI")
        }
    }

    @Test(arguments: StringToDataParseStrategy.Encoding.allCases)
    func allEncodings(encoding: StringToDataParseStrategy.Encoding) throws {
        // use a switch case on allCases for compiler enforcement of testing all encodings
        switch encoding {
        case .base64:
            let formatter = StringToDataParseStrategy.data(encoding: encoding)
            #expect(try formatter.parse("") == Data())
            #expect(try formatter.parse("AQI=") == Data([0x01, 0x02]))

            #expect(throws: (any Error).self) {
                _ = try formatter.parse("AQI")
            }
        }
    }
}
