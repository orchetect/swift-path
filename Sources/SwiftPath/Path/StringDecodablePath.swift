//
//  StringDecodablePath.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// Conforms a ``Path`` type to `Decodable` and provides default implementation to decode from a
/// path string as a single value.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol StringDecodablePath: StringParseablePath, Decodable { }

// MARK: - Default Implementation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringDecodablePath {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        try self.init(pathString: string)
    }
}
