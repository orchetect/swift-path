//
//  PathParseError.swift
//  SwiftPath
//

/// ``Path`` parsing errors.
public enum PathParseError: Error, Sendable {
    case pathDoesNotExist
    case invalidPath
    case invalidValues
}
