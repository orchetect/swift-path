//
//  StringDictionaryPathMethodParameterValues.swift
//  SwiftPath
//

/// Combination of protocols that define a ``PathMethodParameterValues`` type usable with a dictionary
/// of `String` key/value pairs.
public typealias StringDictionaryPathMethodParameterValues = PathMethodParameterValues
    & StringDictionaryParseablePathMethodParameterValues
    & StringDictionaryFormattablePathMethodParameterValues
