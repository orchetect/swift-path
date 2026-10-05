//
//  OSCPathMethodParameterValues.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if osc

/// Combination of protocols that define a ``PathMethodParameterValues`` type usable with OSC (Open Sound Control).
public typealias OSCPathMethodParameterValues = OSCValuesFormattablePathMethodParameterValues
    & OSCValuesParseablePathMethodParameterValues
    & PathMethodParameterValues

#endif
