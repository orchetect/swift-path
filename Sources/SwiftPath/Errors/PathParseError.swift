//
//  PathParseError.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// ``Path`` parsing errors.
public enum PathParseError: Error, Sendable {
    case pathDoesNotExist
    case invalidPath
    case invalidValues
}
