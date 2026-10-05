//
//  StringDictionaryMethodFormablePath.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

public protocol StringDictionaryMethodFormablePath: Path {
    associatedtype StringDictionaryMethod: PathMethod

    func method(stringDictionary: [String: String]) throws -> StringDictionaryMethod
}
