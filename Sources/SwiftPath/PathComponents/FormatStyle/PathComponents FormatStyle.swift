//
//  PathComponents FormatStyle.swift
//  SwiftPath
//

import Foundation

extension PathComponents {
    /// A structure that creates a path string from path components.
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    public struct FormatStyle {
        /// Specifies the presence of the path root, determining whether the path string should be
        /// prefixed by the root separator.
        nonisolated
        public let root: PathRootType

        /// The character used to designate the root.
        nonisolated
        public let rootSeparator: Character

        /// The character used to separate path components in the path string.
        nonisolated
        public let pathSeparator: Character

        /// - Parameters:
        ///   - root: Specifies the presence of the path root, determining whether the path string
        ///     should be prefixed by the root separator.
        ///   - rootSeparator: The character used to designate the root.
        ///   - pathSeparator: The character used to separate path components in the path string.
        @inlinable
        nonisolated
        public init(root: PathRootType = .absolute, rootSeparator: Character = "/", pathSeparator: Character = "/") {
            self.root = root
            self.rootSeparator = rootSeparator
            self.pathSeparator = pathSeparator
        }
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathComponents.FormatStyle: Equatable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathComponents.FormatStyle: Hashable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathComponents.FormatStyle: Sendable { }

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathComponents.FormatStyle: FormatStyle {
    nonisolated
    public func format(_ value: PathComponents) -> String {
        "\(root.isAbsolute ? "\(rootSeparator)" : "")\(value.components.joined(separator: "\(pathSeparator)"))"
    }
}

// MARK: - Static Constructor

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle where Self == PathComponents.FormatStyle {
    // Note that due to Swift's code auto-completion limitations, a static method will not be surfaced
    // where call-site method parameters are bound to generic constraints on `FormatStyle`. However,
    // a static property will be surfaced. We offer both here and both can be used, but only the static
    // property is auto-completed. To accommodate, we also offer all parameters in the static method
    // as individual composable instance methods, similar to how Foundation's `FormatStyle`
    // implementations do.

    /// A structure that creates a path string from path components.
    @inlinable
    nonisolated
    public static var pathComponents: Self {
        Self()
    }

    /// A structure that creates a path string from path components.
    ///
    /// - Parameters:
    ///   - root: Specifies the presence of the path root, determining whether the path string should
    ///     be prefixed by the root separator.
    ///   - rootSeparator: The character used to designate the root.
    ///   - pathSeparator: The character used to separate path components in the path string.
    @inlinable
    nonisolated
    public static func pathComponents(
        root: PathRootType = .absolute,
        rootSeparator: Character = "/",
        pathSeparator: Character = "/"
    ) -> Self {
        Self(root: root, rootSeparator: rootSeparator, pathSeparator: pathSeparator)
    }
}
