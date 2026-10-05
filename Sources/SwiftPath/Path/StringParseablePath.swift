//
//  StringParseablePath.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Conforms a ``Path`` type to an explicitly-associated path string parsing strategy.
/// Provides default implementation for the `init(pathString:)` initializer.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol StringParseablePath: Path {
    /// Parse strategy used to parse path strings into path components.
    associatedtype StringParseStrategy: ParseStrategy where StringParseStrategy.ParseInput == String,
        StringParseStrategy.ParseOutput == PathComponents

    /// Parse strategy used to parse path strings into path components.
    static var pathStringParseStrategy: StringParseStrategy { get }

    /// Constructs a new instance from a path string.
    /// An error is thrown if the string is not a valid path.
    /// Default implementation uses the static ``pathStringParseStrategy`` instance.
    init(pathString: String) throws
}

// MARK: - Default Implementation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringParseablePath {
    public init(pathString: String) throws {
        let pathComponents = try Self.pathStringParseStrategy.parse(pathString)
        try self.init(pathComponents: pathComponents)
    }
}
