//
//  StringDictionaryPathMethod.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// Combination of protocols that define a ``PathMethod`` type usable with `String` dictionary
/// method parameter values.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public typealias StringDictionaryPathMethod = PathMethod & StringDictionaryFormattablePathMethod
