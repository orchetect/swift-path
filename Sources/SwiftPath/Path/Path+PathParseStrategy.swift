//
//  Path+PathParseStrategy.swift
//  SwiftPath
//

import Foundation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension Path {
    /// Creates a new `Path` by parsing the given representation.
    ///
    /// This initializer is an overload of the standard  `init(_:strategy:)` initializer. This is
    /// provided to facilitate use of the `.path(components:path:)` static `strategy` constructor.
    ///
    /// - Parameters:
    ///   - value: Path string.
    ///   - strategy: The parse strategy to parse `value` whose `ParseInput` is `Self`.
    public init<ComponentsParser: ParseStrategy, PathParser: ParseStrategy>(
        _ value: String,
        strategy: PathParseStrategy<Self, ComponentsParser, PathParser>
    ) throws
        where ComponentsParser.ParseInput == String, ComponentsParser.ParseOutput == PathComponents,
        PathParser.ParseInput == PathComponents, PathParser.ParseOutput == Self
    {
        self = try strategy.parse(value)
    }
}
