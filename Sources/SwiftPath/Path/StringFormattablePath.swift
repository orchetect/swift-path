//
//  StringFormattablePath.swift
//  SwiftPath
//

import Foundation

/// Conforms a ``Path`` type to an explicitly-associated path string format style.
/// Provides default implementation for the `pathString` property.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol StringFormattablePath: Path {
    /// Format style used to format path strings from path components.
    associatedtype StringFormatStyle: FormatStyle where StringFormatStyle.FormatInput == PathComponents, StringFormatStyle.FormatOutput == String

    /// Format style used to format path strings from path components.
    static var pathStringFormatStyle: StringFormatStyle { get }

    /// Returns the path string for the path instance.
    /// Default implementation uses the static ``pathStringFormatStyle`` instance.
    var pathString: String { get }
}

// MARK: - Default Implementation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringFormattablePath {
    public var pathString: String {
        Self.pathStringFormatStyle.format(pathComponents)
    }
}
