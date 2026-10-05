//
//  StringDictionaryFormattablePathMethod.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol StringDictionaryFormattablePathMethod: PathMethod where Path: StringDictionaryMethodFormablePath {
    /// Returns the path parameter values type formattable as a String dictionary.
    var formattableStringDictionary: any StringDictionaryFormattablePathMethodParameterValues { get }
}

// MARK: - Methods

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension StringDictionaryFormattablePathMethod {
    public var stringDictionary: [String: String] {
        formattableStringDictionary.stringDictionary
    }
}
