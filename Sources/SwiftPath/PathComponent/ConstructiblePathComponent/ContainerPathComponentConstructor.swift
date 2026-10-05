//
//  ContainerPathComponentConstructor.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// A path component constructor used may be for path components that are containers.
public struct ContainerPathComponentConstructor<BaseComponent: ConstructiblePathComponent, SubComponent: ConstructiblePathComponent> {
    public typealias Constructor = @Sendable (_ subComponent: SubComponent) -> BaseComponent
    let constructor: Constructor

    public typealias AllCasesConstructor = @Sendable () -> [SubComponent]
    let allCasesConstructor: AllCasesConstructor

    /// Initializes by capturing the `CaseIterable` sub component's `allCases` property.
    public init(
        of subComponentType: SubComponent.Type,
        constructor: @escaping Constructor
    ) where SubComponent: CaseIterable, SubComponent.AllCases == [SubComponent] {
        allCasesConstructor = { SubComponent.allCases }
        self.constructor = constructor
    }

    /// Initializes by supplying sub component's `allCases` contents.
    @_disfavoredOverload
    public init(
        of subComponentType: SubComponent.Type,
        allCases: @escaping AllCasesConstructor = { [] },
        constructor: @escaping Constructor
    ) {
        allCasesConstructor = allCases
        self.constructor = constructor
    }
}

extension ContainerPathComponentConstructor: PathComponentConstructor {
    public var pathComponentType: PathComponentType {
        .container
    }

    public func construct(trailingPathComponents: PathComponents) throws -> BaseComponent {
        let subComponent = try SubComponent(pathComponents: trailingPathComponents)
        return constructor(subComponent)
    }
}

extension ContainerPathComponentConstructor: CaseIterablePathComponentConstructor {
    public func constructAllCases() -> [BaseComponent] {
        allCasesConstructor()
            .map(constructor)
    }
}

extension ContainerPathComponentConstructor: Sendable { }

// MARK: - Additional Methods

extension ContainerPathComponentConstructor {
    public func construct(subComponent: SubComponent) -> BaseComponent {
        constructor(subComponent)
    }
}
