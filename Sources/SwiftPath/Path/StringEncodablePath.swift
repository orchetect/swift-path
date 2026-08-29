//
//  StringEncodablePath.swift
//  SwiftPath
//

/// Conforms a ``Path`` type to `Encodable` and provides default implementation to encode to a
/// path string as a single value.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol StringEncodablePath: StringFormattablePath, Encodable { }

// MARK: - Default Implementation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringEncodablePath {
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(pathString)
    }
}
