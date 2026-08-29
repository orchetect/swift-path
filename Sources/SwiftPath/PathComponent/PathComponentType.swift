//
//  PathComponentType.swift
//  swift-path
//
//  Created by Steffan Andrews on 2026-09-20.
//

public enum PathComponentType {
    case container
    case method
}

extension PathComponentType: Equatable { }

extension PathComponentType: Hashable { }

extension PathComponentType: Sendable { }
