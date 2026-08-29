//
//  PathComponents.swift
//  SwiftPath
//

/// Primitive type containing path components and a path root type.
public struct PathComponents {
    /// Path components.
    nonisolated
    public var components: [String]

    /// - Parameters:
    ///   - components: Path components.
    @inline(__always)
    nonisolated
    public init(_ components: [String] = []) {
        self.components = components
    }

    /// - Parameters:
    ///   - components: Path components.
    @_disfavoredOverload @inlinable
    nonisolated
    public init(_ components: some Sequence<String>) {
        self.components = Array(components)
    }

    /// - Parameters:
    ///   - components: Path components.
    @_disfavoredOverload
    nonisolated
    public init(_ components: some Sequence<some StringProtocol>) {
        self.components = Array(components.map { String($0) })
    }
}

extension PathComponents: Equatable { }

extension PathComponents: Hashable { }

extension PathComponents: Sendable { }

extension PathComponents: Codable { }

extension PathComponents: Identifiable {
    nonisolated
    public var id: Self { self }
}

extension PathComponents: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = String

    @inline(__always)
    nonisolated
    public init(arrayLiteral elements: ArrayLiteralElement...) {
        self.init(elements)
    }
}

// MARK: - Methods

extension PathComponents {
    /// Parses an ID from the first path component and returns the ID with the remaining path
    /// components if successful.
    nonisolated
    public func parseID<ID: RawRepresentable>(
        of: ID.Type
    ) throws -> (id: ID, trailingPathComponents: PathComponents) where ID.RawValue == String {
        guard let pathComponent = components.first else {
            throw PathParseError.pathDoesNotExist
        }
        guard let id = ID(rawValue: pathComponent) else {
            throw PathParseError.pathDoesNotExist
        }
        let trailingPathComponents = PathComponents(components.dropFirst())
        return (id: id, trailingPathComponents: trailingPathComponents)
    }

    /// Parses an ID from the first path component and returns the ID with the remaining path
    /// components if successful.
    nonisolated
    public func parseID() throws -> (id: String, trailingPathComponents: PathComponents) {
        guard let pathComponent = components.first else {
            throw PathParseError.pathDoesNotExist
        }
        let trailingPathComponents = PathComponents(components.dropFirst())
        return (id: pathComponent, trailingPathComponents: trailingPathComponents)
    }
}

// MARK: - Operators

extension PathComponents {
    @inlinable
    nonisolated
    public static func + (lhs: Self, rhs: Self) -> Self {
        PathComponents(lhs.components + rhs.components)
    }

    @_disfavoredOverload @inlinable
    nonisolated
    public static func + (lhs: Self, rhs: some Sequence<some StringProtocol>) -> Self {
        lhs + Self(rhs)
    }

    @inlinable
    nonisolated
    public static func += (lhs: inout Self, rhs: Self) {
        lhs.components += rhs.components
    }

    @_disfavoredOverload @inlinable
    nonisolated
    public static func += (lhs: inout Self, rhs: some Sequence<some StringProtocol>) {
        lhs += Self(rhs)
    }
}
