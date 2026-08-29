//
//  Path.swift
//  SwiftPath
//

/// A type that represents a path.
public protocol Path {
    /// Returns the primitive path components.
    var pathComponents: PathComponents { get }

    /// Constructs a new path from primitive path components.
    init(pathComponents: PathComponents) throws
}
