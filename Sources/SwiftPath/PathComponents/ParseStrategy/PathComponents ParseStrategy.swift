//
//  PathComponents ParseStrategy.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

extension PathComponents {
    /// A parse strategy for parsing a raw path string into individual path component strings.
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    public struct ParseStrategy {
        /// Determines the expected path root when parsing path strings.
        ///
        /// If non-`nil`, the specified path root is required and parsing will throw an error if the input
        /// path string's root does not match. If `nil`, the path root is not enforced and input path
        /// strings may be either absolute or relative will be parsed.
        nonisolated
        public let root: PathRootType?

        /// The character used to designate the root.
        nonisolated
        public let rootSeparator: Character

        /// The character used to separate path components in the path string.
        nonisolated
        public let pathSeparator: Character

        /// - Parameters:
        ///   - root: If non-`nil`, the specified path root is required and parsing will throw an error
        ///     if the input path string's root does not match. If `nil`, the path root is not enforced
        ///     and input path strings may be either absolute or relative will be parsed.
        ///   - rootSeparator: The character used to designate the root.
        ///   - pathSeparator: The character used to separate path components in the path string.
        @inlinable
        nonisolated
        public init(
            root: PathRootType? = nil,
            rootSeparator: Character = "/",
            pathSeparator: Character = "/"
        ) {
            self.root = root
            self.rootSeparator = rootSeparator
            self.pathSeparator = pathSeparator
        }
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathComponents.ParseStrategy: Equatable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathComponents.ParseStrategy: Hashable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathComponents.ParseStrategy: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathComponents.ParseStrategy: ParseStrategy {
    nonisolated
    public func parse(_ value: String) throws -> PathComponents {
        var value: any StringProtocol = value
        let pathRootType: PathRootType

        if let firstChar = value.first, firstChar == rootSeparator {
            value = value.dropFirst()
            pathRootType = .absolute
        } else {
            pathRootType = .relative
        }

        // validate path root
        if let root {
            guard pathRootType == root else {
                throw PathParseError.invalidPath
            }
        }

        guard !value.isEmpty else {
            return PathComponents([])
        }

        var pathComponents = value
            .split(separator: pathSeparator, omittingEmptySubsequences: false)

        if let lastChar = value.last, lastChar == pathSeparator, pathComponents.count > 1 {
            pathComponents = pathComponents.dropLast()
        }

        let components = pathComponents
            .map { String($0) }

        return PathComponents(components)
    }
}

// MARK: - Static Constructor

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension ParseStrategy where Self == PathComponents.ParseStrategy {
    // Note that due to Swift's code auto-completion limitations, a static method will not be surfaced
    // where call-site method parameters are bound to generic constraints on `ParseStrategy`. However,
    // a static property will be surfaced. We offer both here and both can be used, but only the static
    // property is auto-completed. To accommodate, we also offer all parameters in the static method
    // as individual composable instance methods, similar to how Foundation's `ParseStrategy`
    // implementations do.

    /// A parse strategy for parsing a raw path string into individual path component strings.
    @inlinable
    nonisolated
    public static var pathComponents: Self {
        Self()
    }

    /// A parse strategy for parsing a raw path string into individual path component strings.
    ///
    /// - Parameters:
    ///   - root: If non-`nil`, the specified path root is required and parsing will throw an error
    ///     if the input path string's root does not match. If `nil`, the path root is not enforced
    ///     and input path strings may be either absolute or relative will be parsed.
    ///   - rootSeparator: The character used to designate the root.
    ///   - pathSeparator: The character used to separate path components in the path string.
    @inlinable
    nonisolated
    public static func pathComponents(
        root: PathRootType? = nil,
        rootSeparator: Character = "/",
        pathSeparator: Character = "/"
    ) -> Self {
        Self(root: root, rootSeparator: rootSeparator, pathSeparator: pathSeparator)
    }
}
