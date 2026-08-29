//
//  StringDictionaryMethodFormablePath.swift
//  SwiftPath
//

import Foundation

public protocol StringDictionaryMethodFormablePath: Path {
    associatedtype StringDictionaryMethod: PathMethod

    func method(stringDictionary: [String: String]) throws -> StringDictionaryMethod
}
