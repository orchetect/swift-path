//
//  PathMethod.swift
//  SwiftPath
//

import Foundation

public protocol PathMethod {
    /// The path associated with the method.
    associatedtype Path: SwiftPath.Path

    /// The path associated with the method.
    var path: Path { get }
}
