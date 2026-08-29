//
//  OSCAddressPatternFormattablePath.swift
//  SwiftPath
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
