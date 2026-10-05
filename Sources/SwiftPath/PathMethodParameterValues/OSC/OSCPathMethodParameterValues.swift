//
//  OSCPathMethodParameterValues.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if osc

/// Combination of protocols that define a ``PathMethodParameterValues`` type usable with OSC (Open Sound Control).
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public typealias OSCPathMethodParameterValues = OSCValuesFormattablePathMethodParameterValues
    & OSCValuesParseablePathMethodParameterValues
    & PathMethodParameterValues

#endif
