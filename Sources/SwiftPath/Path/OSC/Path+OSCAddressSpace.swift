//
//  Path+OSCAddressSpace.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if osc

import Foundation
import SwiftOSCCore

// MARK: - OSCAddressSpace Registration

extension Path /* where Self: OSCAddressPatternFormattablePath */ {
    /// Registers the path as a method ID in the specified OSC address space.
    public func register<S: OSCAddressSpace<Self>>(
        in oscAddressSpace: S,
        block: S.MethodBlock? = nil
    ) async {
        await oscAddressSpace.register(localAddress: pathComponents.components, id: self, block: block)
    }
}

extension Sequence where Element: Path & OSCAddressPatternFormattablePath & Hashable & Sendable {
    /// Registers all paths as method IDs in the specified OSC address space.
    public func register(in oscAddressSpace: OSCAddressSpace<Element>) async {
        for path in self {
            await path.register(in: oscAddressSpace)
        }
    }
}

#endif
