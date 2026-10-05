//
//  Path+PathFormatStyle.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension Path {
    /// Converts `self` to a path string using the specified format style.
    ///
    /// This method is an overload of the standard `formatted(_:)` method. This is provided to
    /// facilitate the use of the `.path(path:components:)` static `format` constructor.
    ///
    /// - Parameters:
    ///   - format: The format for formatting `self`.
    public func formatted(
        _ format: PathFormatStyle<Self, some FormatStyle, some FormatStyle>
    ) -> String {
        format.format(self)
    }
}
