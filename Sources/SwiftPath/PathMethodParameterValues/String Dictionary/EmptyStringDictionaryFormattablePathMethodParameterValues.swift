//
//  EmptyStringDictionaryFormattablePathMethodParameterValues.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Conforms a ``PathMethodParameterValues`` type to ``StringDictionaryFormattablePathMethodParameterValues`` and provides
/// default implementation to format the type as an empty dictionary of `String` key/value pairs.
///
/// This is provided as a convenience where a type has no parameters.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol EmptyStringDictionaryFormattablePathMethodParameterValues: StringDictionaryFormattablePathMethodParameterValues { }

// MARK: - `StringDictionaryFormattablePathMethodParameterValues` Default Implementation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension EmptyStringDictionaryFormattablePathMethodParameterValues {
    public static var stringDictionaryFormatStyle: EmptyStringDictionaryFormatStyle<Self> {
        EmptyStringDictionaryFormatStyle()
    }
}

// MARK: - Types

/// A format style that always returns an empty dictionary of `String` key/value pairs.
///
/// This is provided as a convenience where a type has no parameters.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct EmptyStringDictionaryFormatStyle<FormatInput>: FormatStyle, Sendable {
    public func format(_ value: FormatInput) -> [String: String] {
        [:]
    }

    public init() { }
}
