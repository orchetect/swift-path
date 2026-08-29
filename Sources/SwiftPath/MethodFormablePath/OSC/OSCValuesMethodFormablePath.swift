//
//  OSCValuesMethodFormablePath.swift
//  SwiftPath
//

#if osc

import Foundation
import SwiftOSCCore

public protocol OSCValuesMethodFormablePath: Path {
    associatedtype OSCValuesMethod: PathMethod

    func method(oscValues: OSCValues) throws -> OSCValuesMethod
}

#endif
