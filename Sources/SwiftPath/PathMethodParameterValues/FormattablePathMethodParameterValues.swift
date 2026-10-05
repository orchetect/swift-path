//
//  FormattablePathMethodParameterValues.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftValueFormatting

/// Conforms a ``PathMethodParameterValues`` type to be formattable by way of the `formatted(_:)` method.
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public protocol FormattablePathMethodParameterValues: PathMethodParameterValues, Formattable { }
