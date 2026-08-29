//
//  OSCPathMethodParameterValues.swift
//  SwiftPath
//

#if osc

/// Combination of protocols that define a ``PathMethodParameterValues`` type usable with OSC (Open Sound Control).
public typealias OSCPathMethodParameterValues = PathMethodParameterValues
    & OSCValuesParseablePathMethodParameterValues
    & OSCValuesFormattablePathMethodParameterValues

#endif
