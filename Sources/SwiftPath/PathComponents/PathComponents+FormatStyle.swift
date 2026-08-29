//
//  PathComponents+FormatStyle.swift
//  SwiftPath
//

import Foundation
import SwiftValueFormatting

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathComponents: Formattable {
    // `func formatted(_:)` is implemented by `Formattable` protocol conformance

    /// Default format style used by ``formatted()``.
    nonisolated
    public static let defaultFormatStyle = FormatStyle()

    /// Formats the path components as a path string using the default format style.
    nonisolated
    public func formatted() -> String {
        formatted(Self.defaultFormatStyle)
    }
}
