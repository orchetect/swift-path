//
//  AnyPath.swift
//  SwiftPath
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

extension AnyPath: StringParseablePath {
    nonisolated
    public static let pathStringParseStrategy = PathComponents.ParseStrategy()
}

extension AnyPath: StringFormattablePath {
    nonisolated
    public static let pathStringFormatStyle = PathComponents.FormatStyle()
}

extension AnyPath: StringCodablePath { }
