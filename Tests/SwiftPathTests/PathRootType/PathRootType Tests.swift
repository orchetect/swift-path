//
//  PathRootType Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftPath
import Testing

@Suite
struct PathRootType_Tests {
    @Test
    func isAbsolute() {
        for rootType in PathRootType.allCases {
            switch rootType {
            case .absolute:
                #expect(rootType.isAbsolute)
            case .relative:
                #expect(!rootType.isAbsolute)
            }
        }
    }

    @Test
    func init_isAbsolute() {
        #expect(PathRootType(isAbsolute: true) == .absolute)
        #expect(PathRootType(isAbsolute: false) == .relative)
    }
}
