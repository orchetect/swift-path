//
//  CaseIterableContainerPathComponent.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// Conforms a ``PathComponent`` type to `CaseIterable` and provides default implementation for the
/// `allCases` static property when `PathComponentID` conforms to `CaseIterable`.
///
/// > Note:
/// >
/// > The default implementation for the `allCases` static property is computed on every access.
/// > For repeated access and or large path trees, it is recommended to either store a copy of this
/// > property's value or override the default `static var allCases` declaration in your concrete type
/// > with a statically-stored copy of the collection by calling the underlying ``generateAllCases()``
/// > static method:
/// >
/// > ```swift
/// > struct MyPath: CaseIterableContainerPathComponent {
/// >     static let allCases: [Self] = generateAllCases()
/// > }
/// > ```
public protocol CaseIterableContainerPathComponent: CaseIterable where Self: IdentifiablePathComponent, PathComponentID: CaseIterable {
    /// Returns all nested paths for the given path component ID.
    ///
    /// This method is called by the ``allCases`` property default implementation.
    static func allCases(for id: PathComponentID) -> [Self]
}

// MARK: - `CaseIterable` Default Implementation

extension CaseIterableContainerPathComponent {
    public static var allCases: [Self] {
        generateAllCases()
    }
}

// MARK: - `ConstructiblePathComponent` Default Implementation

extension CaseIterableContainerPathComponent where Self: ConstructiblePathComponent {
    public static func allCases(for id: PathComponentID) -> [Self] {
        constructor(for: id).constructAllCases()
    }
}

// MARK: - Methods

extension CaseIterableContainerPathComponent {
    /// Generates a collection of all cases for the path.
    public static func generateAllCases() -> [Self] {
        PathComponentID.allCases.reduce(into: []) { partialResult, id in
            partialResult.append(contentsOf: allCases(for: id))
        }
    }
}
