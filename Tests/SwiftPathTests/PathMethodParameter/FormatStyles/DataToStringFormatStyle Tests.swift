//
//  DataToStringFormatStyle Tests.swift
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
/// - `DataToStringFormatStyle`:
///   - Static constructors
///   - Composition methods
///   - All `Encoding` encodings
/// - Basic string formatting results
@Suite
struct DataToStringFormatStyle_Tests {
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func data() {
        let param = AnyPathMethodParameter.data(label: "test")
        #expect(param.label == "test")
        #expect(type(of: param).Value.self == Data.self)
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test(arguments: DataToStringFormatStyle.Encoding.allCases)
    func encodingComposition(encoding: DataToStringFormatStyle.Encoding) {
        switch encoding {
        case .base64:
            // struct init
            #expect(DataToStringFormatStyle(encoding: encoding).encoding == encoding)
            // composition method
            #expect(DataToStringFormatStyle.string.encoding(encoding).encoding == encoding)
        }
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func defaultEncoding() {
        // default uses Base64
        let formatter = DataToStringFormatStyle.string

        #expect(formatter.format(Data()) == "")
        #expect(formatter.format(Data([0x01, 0x02])) == "AQI=")
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test(arguments: DataToStringFormatStyle.Encoding.allCases)
    func allEncodings(encoding: DataToStringFormatStyle.Encoding) {
        // use a switch case on allCases for compiler enforcement of testing all encodings
        switch encoding {
        case .base64:
            let formatter = DataToStringFormatStyle.string(encoding: encoding)
            #expect(formatter.format(Data()) == "")
            #expect(formatter.format(Data([0x01, 0x02])) == "AQI=")
        }
    }
}
