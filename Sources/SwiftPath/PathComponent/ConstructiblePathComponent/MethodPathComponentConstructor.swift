//
//  MethodPathComponentConstructor.swift
//  SwiftPath
//

/// A path component constructor that may be used for path components that are methods.
public struct MethodPathComponentConstructor<BaseComponent: ConstructiblePathComponent> {
    public typealias Constructor = @Sendable () -> BaseComponent
    let constructor: Constructor

    public init(
        constructor: @escaping Constructor
    ) {
        self.constructor = constructor
    }
}

extension MethodPathComponentConstructor: PathComponentConstructor {
    public var pathComponentType: PathComponentType { .method }

    public func construct(trailingPathComponents: PathComponents) throws -> BaseComponent {
        // ensure path component is a method by checking that there are no additional path components
        guard trailingPathComponents.components.isEmpty else { throw PathParseError.pathDoesNotExist }

        return constructor()
    }
}

extension MethodPathComponentConstructor: CaseIterablePathComponentConstructor {
    public func constructAllCases() -> [BaseComponent] {
        [constructor()]
    }
}

extension MethodPathComponentConstructor: Sendable { }

// MARK: - Additional Methods

extension MethodPathComponentConstructor {
    public func construct() -> BaseComponent {
        constructor()
    }
}
