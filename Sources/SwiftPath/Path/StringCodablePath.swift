//
//  StringCodablePath.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// Conforms a ``Path`` type to `Codable` and provides default implementation to encode/decode
/// to/from a path string as a single value.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol StringCodablePath: Path, Codable, StringDecodablePath, StringEncodablePath { }
