//
//  OSCPathMethod.swift
//  SwiftPath
//

#if osc

/// Combination of protocols that define a ``PathMethod`` type usable with OSC (Open Sound Control).
public typealias OSCPathMethod = PathMethod & OSCMessageFormattablePathMethod

#endif
