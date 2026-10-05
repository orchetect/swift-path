//
//  PathComponents+ParseStrategy.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftValueFormatting

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathComponents: Parseable {
    // `init(_:strategy:) throws` is implemented by `Parseable` protocol conformance

    /// Default format style used by ``init(_:)-(String)``.
    nonisolated
    public static let defaultParseStrategy = ParseStrategy()

    /// Creates a new `PathComponents` by parsing the given representation using the default parse
    /// strategy.
    nonisolated
    public init(_ value: String) throws {
        self = try Self.defaultParseStrategy.parse(value)
    }
}
