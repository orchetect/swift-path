//
//  Path.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// A type that represents a path.
public protocol Path {
    /// Returns the primitive path components.
    var pathComponents: PathComponents { get }

    /// Constructs a new path from primitive path components.
    init(pathComponents: PathComponents) throws
}
