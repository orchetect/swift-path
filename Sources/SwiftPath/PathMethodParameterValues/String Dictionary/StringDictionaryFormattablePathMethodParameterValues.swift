//
//  StringDictionaryFormattablePathMethodParameterValues.swift
//  SwiftPath
//

import Foundation

/// Conforms a ``PathMethodParameterValues`` type to be formattable as a dictionary of `String` key/value pairs
/// by way of the `stringDictionary` property.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol StringDictionaryFormattablePathMethodParameterValues: FormattablePathMethodParameterValues {
    /// Formatter used to encode the type's parameter values as a dictionary of `String` key/value pairs.
    associatedtype StringDictionaryFormatStyle: FormatStyle
        where StringDictionaryFormatStyle.FormatInput == Self,
              StringDictionaryFormatStyle.FormatOutput == [String: String]

    /// Formatter used to encode the type's parameter values as a dictionary of `String` key/value pairs.
    static var stringDictionaryFormatStyle: StringDictionaryFormatStyle { get }

    /// Returns the type's parameter values as a dictionary of `String` key/value pairs using
    /// ``StringDictionaryFormatStyle``.
    var stringDictionary: [String: String] { get }
}

// MARK: - Default Implementation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringDictionaryFormattablePathMethodParameterValues {
    public var stringDictionary: [String: String] {
        formatted(Self.stringDictionaryFormatStyle)
    }
}
