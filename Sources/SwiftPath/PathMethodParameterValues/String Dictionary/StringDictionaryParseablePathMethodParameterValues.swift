//
//  StringDictionaryParseablePathMethodParameterValues.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

/// Conforms a ``PathMethodParameterValues`` type to be parseable from a dictionary of `String` key/value pairs
/// by way of the `init(stringDictionary:)` initializer.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol StringDictionaryParseablePathMethodParameterValues: ParseablePathMethodParameterValues {
    /// Parser used to decode the type's parameter values from a dictionary of `String` key/value pairs.
    associatedtype StringDictionaryParseStrategy: ParseStrategy
        where StringDictionaryParseStrategy.ParseInput == [String: String],
        StringDictionaryParseStrategy.ParseOutput == Self

    /// Parser used to decode the type's parameter values from a dictionary of `String` key/value pairs.
    static var stringDictionaryParseStrategy: StringDictionaryParseStrategy { get }

    /// Constructs a new instance by parsing a dictionary of `String` key/value pairs using
    /// ``StringDictionaryParseStrategy``.
    init(stringDictionary: [String: String]) throws
}

// MARK: - Default Implementation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringDictionaryParseablePathMethodParameterValues {
    public init(stringDictionary: [String: String]) throws {
        try self.init(stringDictionary, strategy: Self.stringDictionaryParseStrategy)
    }
}
