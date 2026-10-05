//
//  OSCAddressPatternFormattablePath.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if osc

import SwiftOSCCore

/// Conforms a ``Path`` type to allow it to be formatted as an OSC message address pattern.
public protocol OSCAddressPatternFormattablePath: Path {
    var oscAddressPattern: OSCAddressPattern { get }
}

// MARK: - Default Implementation

extension OSCAddressPatternFormattablePath {
    public var oscAddressPattern: OSCAddressPattern {
        OSCAddressPattern(pathComponents: pathComponents.components)
    }
}

#endif
