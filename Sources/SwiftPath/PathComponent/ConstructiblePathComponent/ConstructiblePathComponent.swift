//
//  ConstructiblePathComponent.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// Conforms a ``PathComponent`` to allow default implementation to handle recursive
/// path construction in a declarative fashion.
///
/// The reason that this protocol makes use of initializers that require the full path's
/// components is that some ``PathComponent`` implementations (such as nested enums)
/// have individual path components that cannot be initialized individually and by
/// their inherent restrictions require the entire path to be constructed recursively.
public protocol ConstructiblePathComponent: IdentifiablePathComponent {
    /// An alias to the concrete constructor used for path components that are containers.
    typealias ContainerConstructor<SubComponent: ConstructiblePathComponent> = ContainerPathComponentConstructor<Self, SubComponent>

    /// An alias to the concrete constructor used for path components that are methods.
    typealias MethodConstructor = MethodPathComponentConstructor<Self>

    /// Returns the constructor that is used to create a new instance of `Self` for the
    /// given path component. Generally, an instance of either ``ContainerConstructor``
    /// or ``MethodConstructor`` should be returned.
    static func constructor(for pathComponent: PathComponentID) -> any PathComponentConstructor<Self>

    // this is shared with `Path`, but `Path` is intentionally not a required protocol to conform to here.
    /// Constructs a new path from primitive path components.
    init(pathComponents: PathComponents) throws

    // this is shared with `Path`, but `Path` is intentionally not a required protocol to conform to here.
    /// Constructs a new path from an initial path component and trailing path components.
    init(pathComponent: PathComponentID, trailingPathComponents: PathComponents) throws
}

// MARK: - Default Implementation

extension ConstructiblePathComponent {
    public init(pathComponent: PathComponentID, trailingPathComponents: PathComponents) throws {
        let constructor = Self.constructor(for: pathComponent)
        let component = try constructor.construct(trailingPathComponents: trailingPathComponents)
        self = component
    }
}

// MARK: - `Path` Default Implementation

extension ConstructiblePathComponent where PathComponentID == String {
    public init(pathComponents: PathComponents) throws {
        let (id, trailingPathComponents) = try pathComponents.parseID()
        try self.init(pathComponent: id, trailingPathComponents: trailingPathComponents)
    }
}

extension ConstructiblePathComponent where PathComponentID: RawRepresentable, PathComponentID.RawValue == String {
    public init(pathComponents: PathComponents) throws {
        let (id, trailingPathComponents) = try pathComponents.parseID(of: PathComponentID.self)
        try self.init(pathComponent: id, trailingPathComponents: trailingPathComponents)
    }
}
