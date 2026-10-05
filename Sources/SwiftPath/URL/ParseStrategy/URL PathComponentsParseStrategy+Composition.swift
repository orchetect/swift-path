//
//  URL PathComponentsParseStrategy+Composition.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension URL.PathComponentsParseStrategy {
    /// Modifies a parse strategy use the given URL scheme.
    @inlinable
    nonisolated
    public func scheme(_ string: String) -> Self {
        Self(scheme: string, host: host)
    }

    /// Modifies a parse strategy use the given URL hostname.
    @inlinable
    nonisolated
    public func host(_ string: String) -> Self {
        Self(scheme: scheme, host: string)
    }
}
