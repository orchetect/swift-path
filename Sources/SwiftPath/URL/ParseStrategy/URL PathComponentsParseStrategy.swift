//
//  URL PathComponentsParseStrategy.swift
//  SwiftPath
//

import Foundation

extension URL {
    /// A parse strategy for combining individual path component strings into a URL.
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    public struct PathComponentsParseStrategy {
        /// URL scheme component.
        ///
        /// For example: a scheme value of `path` would imply a URL prefixed by `path://`)
        nonisolated
        public let scheme: String?

        /// URL hostname component.
        ///
        /// For example: a scheme value of `path` and a `host` value of `myhost` would imply a
        /// URL prefixed by `path://host/` followed by the path components.
        nonisolated
        public let host: String?

        /// - Parameters:
        ///   - scheme: URL scheme component.
        ///     (For example: a scheme value of `path` would imply a URL prefixed by `path://`).
        ///   - host: URL hostname component.
        ///     (For example: a scheme value of `path` and a `host` value of `myhost` would imply a
        ///     URL prefixed by `path://host/` followed by the path components).
        @inlinable
        nonisolated
        public init(scheme: String? = nil, host: String? = nil) {
            self.scheme = scheme
            self.host = host
        }
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension URL.PathComponentsParseStrategy: Equatable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension URL.PathComponentsParseStrategy: Hashable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension URL.PathComponentsParseStrategy: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension URL.PathComponentsParseStrategy: ParseStrategy {
    nonisolated
    public func parse(_ value: PathComponents) throws -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme

        urlComponents.host = host
        let isHostUsed = urlComponents.host != nil

        if !value.components.isEmpty {
            var path = ""
            if isHostUsed {
                path += "/"
            }
            path += value.components.joined(separator: "/")
            urlComponents.path = path
        }
        
        guard let url = urlComponents.url else {
            throw PathParseError.invalidPath
        }
        return url
    }
}

// MARK: - Static Constructor

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension ParseStrategy where Self == URL.PathComponentsParseStrategy {
    // Note that due to Swift's code auto-completion limitations, a static method will not be surfaced
    // where call-site method parameters are bound to generic constraints on `ParseStrategy`. However,
    // a static property will be surfaced. We offer both here and both can be used, but only the static
    // property is auto-completed. To accommodate, we also offer all parameters in the static method
    // as individual composable instance methods, similar to how Foundation's `ParseStrategy`
    // implementations do.

    @inlinable
    nonisolated
    public static var pathComponents: Self {
        Self()
    }

    /// A parse strategy for combining individual path component strings into a URL.
    ///
    /// - Parameters:
    ///   - scheme: URL scheme component.
    ///     (For example: a scheme value of `path` would imply a URL prefixed by `path://`).
    ///   - host: URL hostname component.
    ///     (For example: a scheme value of `path` and a `host` value of `myhost` would imply a
    ///     URL prefixed by `path://host/` followed by the path components).
    @inlinable
    nonisolated
    public static func pathComponents(scheme: String, host: String) -> Self {
        Self(scheme: scheme, host: host)
    }
}
