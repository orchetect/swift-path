//
//  PathMethod.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

public protocol PathMethod {
    /// The path associated with the method.
    associatedtype Path: SwiftPath.Path

    /// The path associated with the method.
    var path: Path { get }
}
