//
//  Path+ParseStrategy.swift
//  SwiftPath
//

import Foundation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension Path {
    // MARK: - Parse `Self`

    // `init(_:strategy:) throws` is implemented by `Parseable` protocol conformance

    // MARK: - Parse `PathComponents`

    /// Creates a new instance of `Self` by parsing the given path components.
    ///
    /// - Parameters:
    ///   - value: A representation of path components. The type of the representation is specified
    ///     by the parse strategy's `ParseInput`.
    ///   - strategy: The parse strategy to parse `value` whose `ParseOutput` is `Self`.
    public init<T>(_ value: T.ParseInput, strategy: T) throws where T: ParseStrategy, T.ParseOutput == PathComponents {
        let pathComponents = try strategy.parse(value)
        try self.init(pathComponents: pathComponents)
    }
}
