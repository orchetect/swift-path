//
//  ContainerPathComponent.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// A path component that is a container.
public protocol ContainerPathComponent: PathComponent {
    /// Returns the next path component in the path.
    var nextPathComponent: (any PathComponent)? { get }
}
