//
//  PathFormatStyle.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// A structure that creates a path string from a path by chaining a path formatter into a path
/// components formatter.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct PathFormatStyle<Path: SwiftPath.Path, PathFormatter: FormatStyle, ComponentsFormatter: FormatStyle>
    where PathFormatter.FormatInput == Path, PathFormatter.FormatOutput == PathComponents,
    ComponentsFormatter.FormatInput == PathComponents, ComponentsFormatter.FormatOutput == String
{
    /// Formatter used to format the path into path components.
    nonisolated
    public let pathFormatter: PathFormatter

    /// Formatter used to format the path components returned by `pathFormatter` into a
    /// path string.
    nonisolated
    public let componentsFormatter: ComponentsFormatter

    /// - Parameters:
    ///   - pathType: Concrete path type used for the formatter's input.
    ///   - pathFormatter: Formatter used to format the path into path components.
    ///   - componentsFormatter: Formatter used to format the path components returned by
    ///     `pathFormatter` into a path string.
    @inlinable
    nonisolated
    public init(
        for pathType: Path.Type = Path.self,
        path pathFormatter: PathFormatter,
        components componentsFormatter: ComponentsFormatter = .pathComponents
    ) {
        self.pathFormatter = pathFormatter
        self.componentsFormatter = componentsFormatter
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathFormatStyle: Equatable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathFormatStyle: Hashable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathFormatStyle: Sendable where PathFormatter: Sendable, ComponentsFormatter: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathFormatStyle: FormatStyle {
    nonisolated
    public func format(_ value: Path) -> String {
        let pathComponents = pathFormatter.format(value)
        return componentsFormatter.format(pathComponents)
    }
}

// MARK: - Static Constructor

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle where FormatInput: Path, FormatOutput == String {
    // Note that this static constructor is only usable by way of a corresponding
    // `func formatted(_:)` instance method overload on `Path` which carries necessary generic constraints.

    /// A structure that creates a path string from a path by chaining a path formatter into a path
    /// components formatter.
    ///
    /// - Parameters:
    ///   - pathFormatter: Formatter used to format the path into path components.
    ///   - componentsFormatter: Formatter used to format the path components returned by
    ///     `pathFormatter` into a path string.
    @inlinable
    nonisolated
    public static func path<PathFormatter: FormatStyle, ComponentsFormatter: FormatStyle>(
        path pathFormatter: PathFormatter,
        components componentsFormatter: ComponentsFormatter = .pathComponents
    ) -> PathFormatStyle<FormatInput, PathFormatter, ComponentsFormatter>
        where PathFormatter.FormatInput == FormatInput, PathFormatter.FormatOutput == PathComponents,
        ComponentsFormatter.FormatInput == PathComponents, ComponentsFormatter.FormatOutput == String
    {
        PathFormatStyle(path: pathFormatter, components: componentsFormatter)
    }
}
