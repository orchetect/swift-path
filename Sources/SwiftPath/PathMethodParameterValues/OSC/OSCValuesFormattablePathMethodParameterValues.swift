//
//  OSCValuesFormattablePathMethodParameterValues.swift
//  SwiftPath
//

#if osc

import Foundation
import SwiftOSCCore

/// Conforms a ``PathMethodParameterValues`` type to be formattable as `OSCValues` by way of the `oscValues` property.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol OSCValuesFormattablePathMethodParameterValues: FormattablePathMethodParameterValues {
    /// Formatter used to encode the type's parameter values as OSC values.
    associatedtype OSCValuesFormatStyle: FormatStyle where OSCValuesFormatStyle.FormatInput == Self, OSCValuesFormatStyle.FormatOutput == OSCValues

    /// Formatter used to encode the type's parameter values as OSC values.
    static var oscValuesFormatStyle: OSCValuesFormatStyle { get }

    /// Returns the type's parameter values as OSC values using ``OSCValuesFormatStyle``.
    var oscValues: OSCValues { get }
}

// MARK: - Default Implementation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension OSCValuesFormattablePathMethodParameterValues {
    public var oscValues: OSCValues {
        formatted(Self.oscValuesFormatStyle)
    }
}

#endif
