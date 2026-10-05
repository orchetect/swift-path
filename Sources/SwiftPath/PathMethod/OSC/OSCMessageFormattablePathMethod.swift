//
//  OSCMessageFormattablePathMethod.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if osc

import Foundation
import SwiftOSCCore

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol OSCMessageFormattablePathMethod: PathMethod where Path: OSCValuesMethodFormablePath {
    /// Returns the path method encoded as an OSC message.
    var oscMessage: OSCMessage { get }

    /// Returns the path parameter values type formattable as OSC values.
    var formattableOSCValues: any OSCValuesFormattablePathMethodParameterValues { get }
}

// MARK: - Default Implementation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension OSCMessageFormattablePathMethod {
    public var oscMessage: OSCMessage {
        let address = OSCAddressPattern(pathComponents: path.pathComponents.components)
        let values = formattableOSCValues.oscValues
        return OSCMessage(address, values: values)
    }
}

// MARK: - Methods

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension OSCMessageFormattablePathMethod {
    public var oscValues: OSCValues {
        formattableOSCValues.oscValues
    }
}

#endif
