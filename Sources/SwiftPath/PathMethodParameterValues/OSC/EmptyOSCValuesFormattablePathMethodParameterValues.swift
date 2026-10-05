//
//  EmptyOSCValuesFormattablePathMethodParameterValues.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if osc

import Foundation
import SwiftOSCCore

/// Conforms a ``PathMethodParameterValues`` type to ``OSCValuesFormattablePathMethodParameterValues`` and provides
/// default implementation to format the type as an empty OSC values array.
///
/// This is provided as a convenience where a type has no parameters.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol EmptyOSCValuesFormattablePathMethodParameterValues: OSCValuesFormattablePathMethodParameterValues { }

// MARK: - `OSCValuesFormattablePathMethodParameterValues` Default Implementation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension EmptyOSCValuesFormattablePathMethodParameterValues {
    public static var oscValuesFormatStyle: EmptyOSCValuesFormatStyle<Self> {
        EmptyOSCValuesFormatStyle()
    }
}

// MARK: - Types

/// A format style that always returns an empty OSC values array.
///
/// This is provided as a convenience where a type has no parameters.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public struct EmptyOSCValuesFormatStyle<FormatInput>: FormatStyle, Sendable {
    public func format(_ value: FormatInput) -> OSCValues {
        []
    }

    public init() { }
}

#endif
