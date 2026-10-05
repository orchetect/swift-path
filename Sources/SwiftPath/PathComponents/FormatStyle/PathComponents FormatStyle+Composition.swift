//
//  PathComponents FormatStyle+Composition.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathComponents.FormatStyle {
    /// Modifies a parse strategy to be formatted as an absolute or relative path.
    @inlinable
    nonisolated
    public func root(_ pathRootType: PathRootType) -> Self {
        Self(root: pathRootType, rootSeparator: rootSeparator, pathSeparator: pathSeparator)
    }

    /// Modifies a parse strategy to use the given character to designate the root.
    @inlinable
    nonisolated
    public func rootSeparator(_ character: Character) -> Self {
        Self(root: root, rootSeparator: character, pathSeparator: pathSeparator)
    }

    /// Modifies a parse strategy to use the given character to separate path components in the path
    /// string.
    @inlinable
    nonisolated
    public func pathSeparator(_ character: Character) -> Self {
        Self(root: root, rootSeparator: rootSeparator, pathSeparator: character)
    }
}
