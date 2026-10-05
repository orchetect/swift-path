//
//  PathParseStrategy.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// A structure that creates a path from a path string by chaining a path components parser into a
/// path parser.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct PathParseStrategy<Path: SwiftPath.Path, ComponentsParser: ParseStrategy, PathParser: ParseStrategy>
    where ComponentsParser.ParseInput == String, ComponentsParser.ParseOutput == PathComponents,
    PathParser.ParseInput == PathComponents, PathParser.ParseOutput == Path
{
    /// Parser used to convert the path string into path components.
    nonisolated
    public let componentsParser: ComponentsParser

    /// Parser used to convert the path components returned by `componentsParser` into a path.
    nonisolated
    public let pathParser: PathParser

    /// - Parameters:
    ///   - pathType: Concrete path type used for the strategy's output.
    ///   - componentsParser: Parser used to convert the path string into path components.
    ///   - pathParser: Parser used to convert the path components returned by `componentsParser`
    ///     into a path.
    @inlinable
    nonisolated
    public init(
        for pathType: Path.Type = Path.self,
        components componentsParser: ComponentsParser = .pathComponents,
        path pathParser: PathParser
    ) {
        self.componentsParser = componentsParser
        self.pathParser = pathParser
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathParseStrategy: Equatable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathParseStrategy: Hashable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathParseStrategy: Sendable where ComponentsParser: Sendable, PathParser: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathParseStrategy: ParseStrategy {
    nonisolated
    public func parse(_ value: String) throws -> Path {
        let pathComponents = try componentsParser.parse(value)
        return try pathParser.parse(pathComponents)
    }
}

// MARK: - Static Constructor

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension ParseStrategy where ParseInput == String, ParseOutput: Path {
    // Note that this static constructor is only usable by way of a corresponding
    // `init(_:strategy:)` initializer overload on `Path` which carries necessary generic constraints.

    /// A structure that creates a path from a path string by chaining a path components parser into a
    /// path parser.
    ///
    /// - Parameters:
    ///   - componentsParser: Parser used to convert the path string into path components.
    ///   - pathParser: Parser used to convert the path components returned by `componentsParser`
    ///     into a path.
    @inlinable
    nonisolated
    public static func path<ComponentsParser: ParseStrategy, PathParser: ParseStrategy>(
        components componentsParser: ComponentsParser = .pathComponents,
        path pathParser: PathParser
    ) -> PathParseStrategy<ParseOutput, ComponentsParser, PathParser>
        where ComponentsParser.ParseInput == String, ComponentsParser.ParseOutput == PathComponents,
        PathParser.ParseInput == PathComponents, PathParser.ParseOutput == ParseOutput
    {
        PathParseStrategy(components: componentsParser, path: pathParser)
    }
}
