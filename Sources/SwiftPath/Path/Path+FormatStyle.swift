//
//  Path+FormatStyle.swift
//  SwiftPath
//

import Foundation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension Path {
    // MARK: - Format `Self`

    // `func formatted(_:)` is implemented by `Formattable` protocol conformance

    // MARK: - Format `pathComponents`

    /// Converts path components in `self` to another representation using the specified format style.
    ///
    /// - Parameters:
    ///   - format: The format for formatting path components in `self`.
    /// - Returns: A representation of path components in `self` using the given `format`. The type of
    ///   the representation is specified by the format style's `FormatOutput`.
    public func formatted<S: FormatStyle>(_ format: S) -> S.FormatOutput where S.FormatInput == PathComponents {
        format.format(pathComponents)
    }
}
