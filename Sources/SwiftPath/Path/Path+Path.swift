//
//  Path+Path.swift
//  SwiftPath
//

extension Path {
    /// Converts the path to a different path type.
    /// An error is thrown if the path is not representable by the new path type.
    public func converted<P: Path>(to other: P.Type) throws -> P {
        try P(pathComponents: pathComponents)
    }

    /// Constructs a new path by converting a path of another type.
    /// An error is thrown if the path is not representable.
    public init<P: Path>(converting path: P) throws {
        try self.init(pathComponents: path.pathComponents)
    }
}
