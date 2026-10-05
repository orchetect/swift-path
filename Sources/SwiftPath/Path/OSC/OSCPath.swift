//
//  OSCPath.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if osc

/// Combination of protocols that define a ``Path`` type usable with OSC (Open Sound Control).
public typealias OSCPath = OSCAddressPatternFormattablePath
    & OSCAddressPatternParseablePath
    & OSCMessageMethodFormablePath
    & OSCValuesMethodFormablePath
    & Path

#endif
