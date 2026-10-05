//
//  PathComponentType.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

public enum PathComponentType {
    case container
    case method
}

extension PathComponentType: Equatable { }

extension PathComponentType: Hashable { }

extension PathComponentType: Sendable { }
