//
//  ParseablePathMethodParameterValues.swift
//  SwiftPath
//

import Foundation
import SwiftValueFormatting

/// Conforms a ``PathMethodParameterValues`` type to be parseable by way of the `init(_:strategy:)` initializer.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol ParseablePathMethodParameterValues: PathMethodParameterValues, Parseable { }
