//
//  URL PathComponentsFormatStyle.swift
//  SwiftPath
//

import Foundation

extension URL {
    /// A structure that extracts path components from a URL and returns a new ``PathComponents`` instance.
    /// Only the URL's path components are used; all other URL components are ignored and/or discarded.
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    public struct PathComponentsFormatStyle {
        @inlinable
        nonisolated
        public init() { }
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension URL.PathComponentsFormatStyle: Equatable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension URL.PathComponentsFormatStyle: Hashable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension URL.PathComponentsFormatStyle: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension URL.PathComponentsFormatStyle: FormatStyle {
    nonisolated
    public func format(_ value: URL) -> PathComponents {
        // all other other URL components apart from path components are ignored/discarded here
        // (scheme, hostname, etc.)

        let root = value.pathRootType

        let components = switch root {
        case .absolute:
            Array(value.pathComponents.dropFirst())
        case .relative:
            value.pathComponents
        }

        return PathComponents(components)
    }
}

// MARK: - Static Constructor

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle where Self == URL.PathComponentsFormatStyle {
    /// A structure that extracts path components from a URL and returns a new ``PathComponents`` instance.
    /// Only the URL's path components are used; all other URL components are ignored and/or discarded.
    @inlinable
    nonisolated
    public static var pathComponents: Self {
        Self()
    }
}

// MARK: - Helpers

extension URL {
    /// Internal:
    /// Returns a boolean
    nonisolated
    var pathRootType: PathRootType {
        // `URL.pathComponents` will return "/" as the first path component if path is non-empty
        // and absolute.
        if let firstPathComponent = pathComponents.first,
           firstPathComponent == "/"
        {
            .absolute
        } else {
            .relative
        }
    }
}
