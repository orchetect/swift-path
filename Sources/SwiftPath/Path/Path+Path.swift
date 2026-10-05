//
//  Path+Path.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension Path {
    /// Converts the path to a different path type.
    /// An error is thrown if the path is not representable by the new path type.
    public func converted<P: Path>(to other: P.Type) throws -> P {
        try P(pathComponents: pathComponents)
    }

    /// Constructs a new path by converting a path of another type.
    /// An error is thrown if the path is not representable.
    public init(converting path: some Path) throws {
        try self.init(pathComponents: path.pathComponents)
    }
}
