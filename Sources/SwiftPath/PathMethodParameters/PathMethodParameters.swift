//
//  PathMethodParameters.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

public protocol PathMethodParameters: Sendable {
    /// Parameters stored as a type-erased array allowing for anonymized iteration over parameters at
    /// runtime.
    var anyParameters: [any PathMethodParameter] { get }
}

// MARK: - Properties

extension PathMethodParameters {
    /// Returns the number of parameters contained in `self`.
    @inlinable
    public var count: Int {
        anyParameters.count
    }
}
