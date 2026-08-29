//
//  OSCMessageFormattablePathMethod.swift
//  SwiftPath
//

#if osc

import Foundation
import SwiftOSCCore

public protocol OSCMessageFormattablePathMethod: PathMethod where Path: OSCValuesMethodFormablePath {
    /// Returns the path method encoded as an OSC message.
    var oscMessage: OSCMessage { get }

    /// Returns the path parameter values type formattable as OSC values.
    var formattableOSCValues: any OSCValuesFormattablePathMethodParameterValues { get }
}

// MARK: - Default Implementation

extension OSCMessageFormattablePathMethod {
    public var oscMessage: OSCMessage {
        let address = OSCAddressPattern(pathComponents: path.pathComponents.components)
        let values = formattableOSCValues.oscValues
        return OSCMessage(address, values: values)
    }
}

// MARK: - Methods

extension OSCMessageFormattablePathMethod {
    public var oscValues: OSCValues {
        formattableOSCValues.oscValues
    }
}

#endif
