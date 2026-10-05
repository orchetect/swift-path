//
//  PathComponents ParseStrategy+Reciprocal.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathComponents.ParseStrategy {
    public typealias Strategy = PathComponents.FormatStyle

    // Conforming `FormatStyle` to `ParseableFormatStyle` requires it to have a `parseStrategy`
    // property. While it's not necessary to have a `formatStyle` property on `ParseStrategy`,
    // we can provide it for convenience to provide a reciprocal API shape.

    /// A `FormatStyle` that can be used to format this `ParseStrategy`'s output.
    nonisolated
    public var formatStyle: Strategy {
        .pathComponents(root: root ?? .absolute, rootSeparator: rootSeparator, pathSeparator: pathSeparator)
    }
}
