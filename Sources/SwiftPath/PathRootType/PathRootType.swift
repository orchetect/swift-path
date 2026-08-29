//
//  PathRootType.swift
//  SwiftPath
//

/// Type describing whether a path is absolute or relative.
public enum PathRootType: String {
    case absolute
    case relative
}

extension PathRootType: Equatable { }

extension PathRootType: Hashable { }

extension PathRootType: Sendable { }

extension PathRootType: CaseIterable { }

extension PathRootType: Codable { }

// MARK: - isAbsolute

extension PathRootType {
    /// Returns a boolean value describing whether `self` indicates an absolute path.
    @inline(__always)
    nonisolated
    public var isAbsolute: Bool {
        switch self {
        case .absolute: true
        case .relative: false
        }
    }

    /// Construct from a boolean value describing whether a path is an absolute path.
    @inline(__always)
    nonisolated
    public init(isAbsolute: Bool) {
        self = switch isAbsolute {
        case true: .absolute
        case false: .relative
        }
    }
}
