//
//  PathComponent.swift
//  SwiftPath
//

/// Protocol that can be applied to types when designing a path tree using more than one concrete type.
/// If types also conform to ``Path``, default implementation for its `init(pathComponents:)` requirement
/// is provided.
///
/// A path component inherently defines its own path tree and is responsible for its children, but is
/// never responsible for its parent(s) (if any). By being decoupled from any parent type(s), this allows
/// path components (path trees) to be more reusable and composable.
///
/// Path components can conform to ``IdentifiablePathComponent`` to allow them to provide their path
/// component identifier.
///
/// Path components can be refined as containers or methods by conforming to ``ContainerPathComponent``
/// or ``MethodPathComponent``.
///
/// Path components can gain implementation to help facilitate recursive construction of a path by
/// conforming to ``ConstructiblePathComponent``.
///
/// `CaseIterable` implementation can be added by additionally conforming to ``CaseIterableContainerPathComponent``.
public protocol PathComponent: Sendable { }

// MARK: - `Path` Default Implementation

extension PathComponent {
    public var pathComponents: PathComponents {
        var components: [String] = []

        // traverse parents
        var currentComponent: (any PathComponent)? = self
        while let component = currentComponent {
            if let identifiableComponent = component as? any IdentifiablePathComponent {
                components.append(identifiableComponent.pathComponent)
            }
            if let containerComponent = component as? any ContainerPathComponent {
                currentComponent = containerComponent.nextPathComponent
            } else {
                currentComponent = nil
            }
        }

        return PathComponents(components)
    }
}
