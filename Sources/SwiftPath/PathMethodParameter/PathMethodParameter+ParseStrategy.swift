//
//  PathMethodParameter+ParseStrategy.swift
//  SwiftPath
//

import Foundation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathMethodParameter {
    /// Creates a new instance of <doc:/documentation/SwiftPath/PathMethodParameter/Value> by parsing
    /// the given representation.
    ///
    /// - Parameters:
    ///   - value: A representation of the parameter value. The type of the representation is specified
    ///     by the parse strategy's `ParseInput`.
    ///   - strategy: The parse strategy to parse `value` whose `ParseOutput` is `Value`.
    public func parse<T>(_ value: T.ParseInput, strategy: T) throws -> Value where T: ParseStrategy, T.ParseOutput == Value {
        try strategy.parse(value)
    }
}

// MARK: - StringToRawRepresentableParseStrategy Overload

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathMethodParameter where Value: RawRepresentable, Value.RawValue == String {
    /// Creates a new instance of <doc:/documentation/SwiftPath/PathMethodParameter/Value> by parsing
    /// the given representation.
    ///
    /// - Parameters:
    ///   - value: A representation of the parameter value. The type of the representation is specified
    ///     by the parse strategy's `ParseInput`.
    ///   - strategy: The parse strategy to parse `value` whose `ParseOutput` is `Value`.
    public func parse(_ value: String, strategy: StringToRawRepresentableParseStrategy<Value>) throws -> Value {
        try strategy.parse(value)
    }
}
