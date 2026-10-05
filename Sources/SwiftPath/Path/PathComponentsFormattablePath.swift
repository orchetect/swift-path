//
//  PathComponentsFormattablePath.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Conforms a ``Path`` type to an explicitly-associated path components format style.
/// Provides default implementation for ``Path``'s `pathComponents` property.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol PathComponentsFormattablePath: Path {
    /// Format style used to format path strings from path components.
    associatedtype PathComponentsFormatStyle: FormatStyle where PathComponentsFormatStyle.FormatInput == Self,
        PathComponentsFormatStyle.FormatOutput == PathComponents

    /// Format style used to format path strings from path components.
    static var pathComponentsFormatStyle: PathComponentsFormatStyle { get }
}

// MARK: - Path Default Implementation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathComponentsFormattablePath {
    public var pathComponents: PathComponents {
        Self.pathComponentsFormatStyle.format(self)
    }
}
