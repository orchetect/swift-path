//
//  EmptyStringDictionaryParseablePathMethodParameterValues.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Conforms a ``PathMethodParameterValues`` type to ``StringDictionaryParseablePathMethodParameterValues`` and provides
/// default implementation to initialize the type by parsing an empty dictionary of `String` key/value pairs.
///
/// This is provided as a convenience where a type has no parameters.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol EmptyStringDictionaryParseablePathMethodParameterValues: StringDictionaryParseablePathMethodParameterValues {
    init()
}

// MARK: - `StringDictionaryParseablePathMethodParameterValues` Default Implementation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension EmptyStringDictionaryParseablePathMethodParameterValues {
    public static var stringDictionaryParseStrategy: EmptyStringDictionaryParseStrategy<Self> {
        EmptyStringDictionaryParseStrategy()
    }
}

// MARK: - Types

/// A format style that expects an empty dictionary of `String` key/value pairs.
///
/// This is provided as a convenience where a type has no parameters.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct EmptyStringDictionaryParseStrategy<ParseOutput>: ParseStrategy,
    Sendable where ParseOutput: EmptyStringDictionaryParseablePathMethodParameterValues
{
    public func parse(_ value: [String: String]) throws -> ParseOutput {
        guard value.isEmpty else {
            throw PathMethodParametersParseError.invalidParameters
        }
        return .init()
    }

    public init() { }
}
