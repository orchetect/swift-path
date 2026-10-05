//
//  PathMethodParameter+FormatStyle.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathMethodParameter {
    /// Converts an instance of <doc:/documentation/SwiftPath/PathParameter/Value> to another
    /// representation using the specified format style.
    ///
    /// - Parameters:
    ///   - value: An instance of <doc:/documentation/SwiftPath/PathParameter/Value> type.
    ///   - format: The format for converting `value`.
    /// - Returns: A new instance of <doc:/documentation/SwiftPath/PathParameter/Value> type
    ///   using the given `format`.
    public func format<S: FormatStyle>(_ value: Value, format: S) -> S.FormatOutput where S.FormatInput == Value {
        format.format(value)
    }
}

// MARK: - ArrayToStringFormatStyle Overload

// Note that due to associated generics of the array's Element, there is no feasible way to offer
// a standard static constructor extension on `FormatStyle` with an accompanying `.format()`
// override on `PathMethodParameter`, as there is no way to express the constraints.

// MARK: - RawRepresentableToStringFormatStyle Overload

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathMethodParameter where Value: RawRepresentable, Value.RawValue == String {
    /// Converts an instance of <doc:/documentation/SwiftPath/PathParameter/Value> to another
    /// representation using the specified format style.
    ///
    /// - Parameters:
    ///   - value: An instance of <doc:/documentation/SwiftPath/PathParameter/Value> type.
    ///   - format: The format for converting `value`.
    /// - Returns: A new instance of <doc:/documentation/SwiftPath/PathParameter/Value> type
    ///   using the given `format`.
    public func format(_ value: Value, format: RawRepresentableToStringFormatStyle<Value>) -> String {
        format.format(value)
    }
}
