//
//  PathComponents FormatStyle+ParseableFormatStyle.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
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
