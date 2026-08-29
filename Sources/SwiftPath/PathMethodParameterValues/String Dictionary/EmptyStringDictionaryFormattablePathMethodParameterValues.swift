//
//  EmptyStringDictionaryFormattablePathMethodParameterValues.swift
//  SwiftPath
//

import Foundation

/// Conforms a ``PathMethodParameterValues`` type to ``StringDictionaryFormattablePathMethodParameterValues`` and provides
/// default implementation to format the type as an empty dictionary of `String` key/value pairs.
///
/// This is provided as a convenience where a type has no parameters.
public protocol EmptyStringDictionaryFormattablePathMethodParameterValues: StringDictionaryFormattablePathMethodParameterValues { }

// MARK: - `StringDictionaryFormattablePathMethodParameterValues` Default Implementation

extension EmptyStringDictionaryFormattablePathMethodParameterValues {
    public static var stringDictionaryFormatStyle: EmptyStringDictionaryFormatStyle<Self> {
        EmptyStringDictionaryFormatStyle()
    }
}

// MARK: - Types

/// A format style that always returns an empty dictionary of `String` key/value pairs.
///
/// This is provided as a convenience where a type has no parameters.
public struct EmptyStringDictionaryFormatStyle<FormatInput>: FormatStyle, Sendable {
    public func format(_ value: FormatInput) -> [String: String] {
        [:]
    }

    public init() { }
}
