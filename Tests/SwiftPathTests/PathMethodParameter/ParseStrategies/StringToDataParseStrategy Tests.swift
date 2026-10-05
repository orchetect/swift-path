//
//  StringToDataParseStrategy Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftPath
import Testing

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
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func data() {
        let param = AnyPathMethodParameter.data(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Data.self)
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func init_encoding() {
        #expect(StringToDataParseStrategy(encoding: .base64).encoding == .base64)
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func staticConstructors() {
        #expect(StringToDataParseStrategy.data(encoding: .base64).encoding == .base64)
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func encodingComposition() {
        #expect(StringToDataParseStrategy.data.encoding(.base64).encoding == .base64)
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
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

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
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
