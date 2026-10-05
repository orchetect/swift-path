//
//  OSCAddressPatternParseablePath.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if osc

import Foundation
import SwiftOSCCore

/// Conforms a ``Path`` type to allow it to be matched against an OSC message address pattern.
public protocol OSCAddressPatternParseablePath: Path, OSCAddressPatternFormattablePath, Hashable, Sendable, CaseIterable {
    /// Returns all matching paths for the given OSC message address pattern.
    static func paths(matching oscAddressPattern: OSCAddressPattern) -> [Self]

    /// Returns all matching paths for the given OSC message address pattern.
    static func paths(matching oscAddressPattern: OSCAddressPattern) async -> [Self]

    /// Static path cache used internally for OSC address pattern matching.
    static var oscPathCache: OSCPathCache<Self> { get }

    /// Returns a boolean value describing whether the path matches the given OSC message address pattern.
    func matches(oscAddressPattern: OSCAddressPattern) -> Bool
}

// MARK: - Default Implementation (Non-Async)

extension OSCAddressPatternParseablePath {
    public static func paths(matching oscAddressPattern: OSCAddressPattern) -> [Self] {
        // Note: This works, but it can be very inefficient.
        // It's better to use OSCAddressSpace to return matching paths.
        allCases.lazy.filter { path in
            path.matches(oscAddressPattern: oscAddressPattern)
        }
    }

    public static func paths(matching oscAddressPattern: OSCAddressPattern) async -> [Self] {
        let oscAddressSpace = await oscPathCache.get()
        return await oscAddressSpace.methods(matching: oscAddressPattern)
    }

    public func matches(oscAddressPattern: OSCAddressPattern) -> Bool {
        let localAddress = OSCAddressPattern(pathComponents: pathComponents.components).stringValue
        return oscAddressPattern.matches(localAddress: localAddress)
    }
}

// MARK: - OSCAddressSpace

extension OSCAddressPatternParseablePath {
    /// Returns a new OSC address space instance with all path cases registered as method IDs.
    static func oscAddressSpaceFactory() async -> OSCAddressSpace<Self> {
        let addressSpace = OSCAddressSpace<Self>()
        await allCases.register(in: addressSpace)
        return addressSpace
    }
}

// MARK: - OSCPathCache

/// Static path cache used internally for OSC address pattern matching.
public final actor OSCPathCache<Path>: Sendable
    where Path: SwiftPath.Path & OSCAddressPatternFormattablePath & Hashable & Sendable & CaseIterable
{
    let oscAddressSpace = OSCAddressSpace<Path>()
    var isRegistered = false

    public init() { }

    /// Returns the static OSC address space instance.
    /// If the instance does not yet exist, it will first be created.
    nonisolated
    func get() async -> OSCAddressSpace<Path> {
        if await isRegistered {
            return oscAddressSpace
        }
        await Path.allCases.register(in: oscAddressSpace)
        await setIsRegistered(true)
        return oscAddressSpace
    }

    func setIsRegistered(_ value: Bool) {
        isRegistered = value
    }
}

#endif
