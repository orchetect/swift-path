//
//  PathComponentsParseablePath.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Conforms a ``Path`` type to an explicitly-associated path components parsing strategy.
/// Provides default implementation for ``Path``'s `init(pathComponents:)` initializer.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol PathComponentsParseablePath: Path {
    /// Parse strategy used to parse path strings into path components.
    associatedtype PathComponentsParseStrategy: ParseStrategy where PathComponentsParseStrategy.ParseInput == PathComponents,
        PathComponentsParseStrategy.ParseOutput == Self

    /// Parse strategy used to parse path strings into path components.
    static var pathComponentsParseStrategy: PathComponentsParseStrategy { get }
}

// MARK: - Path Default Implementation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathComponentsParseablePath {
    public init(pathComponents: PathComponents) throws {
        self = try Self.pathComponentsParseStrategy.parse(pathComponents)
    }
}
