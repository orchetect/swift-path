//
//  AnyPath.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// Type-erased concrete ``Path`` box.
///
/// A general-purpose ``Path`` implementation which uses a default parse strategy and format style.
public struct AnyPath: Path {
    nonisolated
    public let pathComponents: PathComponents

    @inline(__always)
    nonisolated
    public init(pathComponents: PathComponents) {
        self.pathComponents = pathComponents
    }
}

extension AnyPath: Equatable { }

extension AnyPath: Hashable { }

extension AnyPath: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension AnyPath: StringParseablePath {
    nonisolated
    public static let pathStringParseStrategy = PathComponents.ParseStrategy()
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension AnyPath: StringFormattablePath {
    nonisolated
    public static let pathStringFormatStyle = PathComponents.FormatStyle()
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension AnyPath: StringCodablePath { }
