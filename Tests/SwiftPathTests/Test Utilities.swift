//
//  Test Utilities.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import Testing

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension SortComparator where Self == String.Comparator {
    /// A comparator available cross-platform for testing (Apple, Linux, etc.)
    static var unitTestComparator: Self {
        .init(options: [])
    }
}
