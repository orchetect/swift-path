//
//  StringDictionaryFormattablePathMethod.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftOSCCore

public protocol StringDictionaryFormattablePathMethod: PathMethod where Path: StringDictionaryMethodFormablePath {
    /// Returns the path parameter values type formattable as a String dictionary.
    var formattableStringDictionary: any StringDictionaryFormattablePathMethodParameterValues { get }
}

// MARK: - Methods

extension StringDictionaryFormattablePathMethod {
    public var stringDictionary: [String: String] {
        formattableStringDictionary.stringDictionary
    }
}
