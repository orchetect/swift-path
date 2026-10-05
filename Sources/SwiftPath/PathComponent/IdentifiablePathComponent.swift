//
//  IdentifiablePathComponent.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

public protocol IdentifiablePathComponent: PathComponent {
    /// Path component identifier.
    ///
    /// This type is synonymous with the path component and therefore is typically of type
    /// `String` or a `RawRepresentable` type with a `String` raw value--both of which
    /// provide default implementation for other members of this protocol.
    associatedtype PathComponentID: Hashable

    /// Returns the path component ID.
    ///
    /// Default implementation is provided when ``PathComponentID`` is `String`.
    var pathComponentID: PathComponentID { get }

    /// Default implementation is provided when ``PathComponentID`` conforms to `RawRepresentable`
    /// with a `String` raw value.
    ///
    /// Returns the raw path component string.
    var pathComponent: String { get }
}

// MARK: - Default Implementation

extension IdentifiablePathComponent where PathComponentID == String {
    public var pathComponentID: PathComponentID {
        pathComponent
    }
}

extension IdentifiablePathComponent where PathComponentID: RawRepresentable, PathComponentID.RawValue == String {
    public var pathComponent: String {
        pathComponentID.rawValue
    }
}
