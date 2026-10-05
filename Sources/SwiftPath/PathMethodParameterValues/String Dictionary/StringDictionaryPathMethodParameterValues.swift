//
//  StringDictionaryPathMethodParameterValues.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// Combination of protocols that define a ``PathMethodParameterValues`` type usable with a dictionary
/// of `String` key/value pairs.
public typealias StringDictionaryPathMethodParameterValues = PathMethodParameterValues
    & StringDictionaryFormattablePathMethodParameterValues
    & StringDictionaryParseablePathMethodParameterValues
