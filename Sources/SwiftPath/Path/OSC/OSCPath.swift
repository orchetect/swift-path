//
//  OSCPath.swift
//  SwiftPath
//

#if osc

/// Combination of protocols that define a ``Path`` type usable with OSC (Open Sound Control).
public typealias OSCPath = Path
    & OSCAddressPatternFormattablePath
    & OSCAddressPatternParseablePath
    & OSCMessageMethodFormablePath
    & OSCValuesMethodFormablePath

#endif
