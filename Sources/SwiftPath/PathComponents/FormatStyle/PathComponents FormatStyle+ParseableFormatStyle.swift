//
//  PathComponents FormatStyle+ParseableFormatStyle.swift
//  SwiftPath
//

import Foundation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathComponents.FormatStyle: ParseableFormatStyle {
    public typealias Strategy = PathComponents.ParseStrategy

    nonisolated
    public var parseStrategy: Strategy {
        .pathComponents(root: root, rootSeparator: rootSeparator, pathSeparator: pathSeparator)
    }
}
