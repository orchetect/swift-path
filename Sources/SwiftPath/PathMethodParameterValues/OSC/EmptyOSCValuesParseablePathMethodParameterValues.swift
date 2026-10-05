//
//  EmptyOSCValuesParseablePathMethodParameterValues.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if osc

import Foundation
import SwiftOSCCore

/// Conforms a ``PathMethodParameterValues`` type to ``OSCValuesParseablePathMethodParameterValues`` and provides
/// default implementation to initialize the type by parsing an empty OSC values array.
///
/// This is provided as a convenience where a type has no parameters.
public protocol EmptyOSCValuesParseablePathMethodParameterValues: OSCValuesParseablePathMethodParameterValues {
    init()
}

// MARK: - `OSCValuesParseablePathMethodParameterValues` Default Implementation

extension EmptyOSCValuesParseablePathMethodParameterValues {
    public static var oscValuesParseStrategy: EmptyOSCValuesParseStrategy<Self> {
        EmptyOSCValuesParseStrategy()
    }
}

// MARK: - Types

/// A format style that expects an empty OSC values array.
///
/// This is provided as a convenience where a type has no parameters.
public struct EmptyOSCValuesParseStrategy<ParseOutput>: ParseStrategy,
    Sendable where ParseOutput: EmptyOSCValuesParseablePathMethodParameterValues
{
    public func parse(_ value: OSCValues) throws -> ParseOutput {
        guard value.isEmpty else {
            throw PathMethodParametersParseError.invalidParameters
        }
        return .init()
    }

    public init() { }
}

#endif
