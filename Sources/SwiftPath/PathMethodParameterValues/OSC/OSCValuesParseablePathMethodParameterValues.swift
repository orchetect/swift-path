//
//  OSCValuesParseablePathMethodParameterValues.swift
//  SwiftPath
//

#if osc

import Foundation
import SwiftOSCCore

/// Conforms a ``PathMethodParameterValues`` type to be parseable from `OSCValues` by way of the `init(oscValues:)` initializer.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol OSCValuesParseablePathMethodParameterValues: ParseablePathMethodParameterValues {
    /// Parser used to decode the type's parameter values from OSC values.
    associatedtype OSCValuesParseStrategy: ParseStrategy where OSCValuesParseStrategy.ParseInput == OSCValues, OSCValuesParseStrategy.ParseOutput == Self

    /// Parser used to decode the type's parameter values from OSC values.
    static var oscValuesParseStrategy: OSCValuesParseStrategy { get }

    /// Constructs a new instance by parsing OSC values using ``OSCValuesParseStrategy``.
    init(oscValues: OSCValues) throws
}

// MARK: - Default Implementation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension OSCValuesParseablePathMethodParameterValues {
    public init(oscValues: OSCValues) throws {
        try self.init(oscValues, strategy: Self.oscValuesParseStrategy)
    }
}

#endif
