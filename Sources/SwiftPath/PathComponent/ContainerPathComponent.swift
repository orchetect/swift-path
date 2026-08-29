//
//  ContainerPathComponent.swift
//  SwiftPath
//

/// A path component that is a container.
public protocol ContainerPathComponent: PathComponent {
    /// Returns the next path component in the path.
    var nextPathComponent: (any PathComponent)? { get }
}
