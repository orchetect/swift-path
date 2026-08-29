//
//  PathRootType Tests.swift
//  SwiftPath
//

import Testing
import SwiftPath

@Suite
struct PathRootType_Tests {
    @Test
    func isAbsolute() throws {
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
    func init_isAbsolute() throws {
        #expect(PathRootType(isAbsolute: true) == .absolute)
        #expect(PathRootType(isAbsolute: false) == .relative)
    }
}
