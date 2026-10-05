//
//  URL+Path.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftPath

// Since the library does not conform `URL` to `Path` this conformance exists in an isolated test
// target so as to not pollute the main SwiftPathTests target.

extension URL: Path { }

extension URL: PathComponentsParseablePath {
    public static let pathComponentsParseStrategy = URL.PathComponentsParseStrategy(
        scheme: "path",
        host: "hostname"
    )
}

extension URL: PathComponentsFormattablePath {
    public static let pathComponentsFormatStyle = URL.PathComponentsFormatStyle()
}

extension URL: StringParseablePath {
    public static let pathStringParseStrategy = PathComponents.ParseStrategy()
}

extension URL: StringFormattablePath {
    public static let pathStringFormatStyle = PathComponents.FormatStyle()
}
