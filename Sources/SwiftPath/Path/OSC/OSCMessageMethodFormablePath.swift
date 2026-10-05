//
//  OSCMessageMethodFormablePath.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if osc

import SwiftOSCCore

/// Conforms a ``Path`` type to allow it to be matched against an OSC message address pattern.
public protocol OSCMessageMethodFormablePath: OSCAddressPatternParseablePath, OSCValuesMethodFormablePath {
    /// Returns all methods matching the the given OSC message address pattern.
    /// An optional error handler closure may be used to handle errors thrown while parsing values.
    static func methods(
        for oscMessage: OSCMessage,
        errorHandler: ((_ message: OSCMessage, _ error: any Error) -> Void)?
    ) -> [OSCValuesMethod]

    /// Returns all methods matching the the given OSC message address pattern.
    /// An optional error handler closure may be used to handle errors thrown while parsing values.
    static func methods(
        for oscMessage: OSCMessage,
        errorHandler: ((_ message: OSCMessage, _ error: any Error) -> Void)?
    ) async -> [OSCValuesMethod]
}

// MARK: - Default Implementation

extension OSCMessageMethodFormablePath {
    public static func methods(
        for oscMessage: OSCMessage,
        errorHandler: ((_ message: OSCMessage, _ error: any Error) -> Void)? = nil
    ) -> [OSCValuesMethod] {
        let paths = paths(matching: oscMessage.addressPattern)
        return _methods(for: oscMessage, matchingPaths: paths, errorHandler: errorHandler)
    }

    public static func methods(
        for oscMessage: OSCMessage,
        errorHandler: ((_ message: OSCMessage, _ error: any Error) -> Void)? = nil
    ) async -> [OSCValuesMethod] {
        let paths = await paths(matching: oscMessage.addressPattern)
        return _methods(for: oscMessage, matchingPaths: paths, errorHandler: errorHandler)
    }

    private static func _methods(
        for oscMessage: OSCMessage,
        matchingPaths: [Self],
        errorHandler: ((_ message: OSCMessage, _ error: any Error) -> Void)? = nil
    ) -> [OSCValuesMethod] {
        var methods: [OSCValuesMethod] = []
        for path in matchingPaths {
            do {
                let method = try path.method(oscValues: oscMessage.values)
                methods.append(method)
            } catch {
                errorHandler?(oscMessage, error)
            }
        }
        return methods
    }
}

#endif
