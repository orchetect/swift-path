//
//  PathComponentConstructor.swift
//  SwiftPath
//

/// Defines the requirements for a path component constructor used when a type conforms
/// to ``ConstructiblePathComponent``.
public protocol PathComponentConstructor<BaseComponent> {
    associatedtype BaseComponent: ConstructiblePathComponent

    var pathComponentType: PathComponentType { get }

    func construct(trailingPathComponents: PathComponents) throws -> BaseComponent

    func constructAllCases() -> [BaseComponent]
}

public protocol CaseIterablePathComponentConstructor: PathComponentConstructor {
    func constructAllCases() -> [BaseComponent]
}
