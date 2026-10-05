//
//  OSCValuesMethodFormablePath.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

#if osc

import Foundation
import SwiftOSCCore

public protocol OSCValuesMethodFormablePath: Path {
    associatedtype OSCValuesMethod: PathMethod

    func method(oscValues: OSCValues) throws -> OSCValuesMethod
}

#endif
