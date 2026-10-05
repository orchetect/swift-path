//
//  PathComponents ParseStrategy+Codable.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathComponents.ParseStrategy: Decodable {
    public enum CodingKeys: String, CodingKey {
        case root
        case rootSeparator
        case pathSeparator
    }

    nonisolated
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        root = try container.decodeIfPresent(PathRootType.self, forKey: .root)

        let rawRootAnchor = try container.decode(String.self, forKey: .rootSeparator)
        rootSeparator = Character(rawRootAnchor)

        let rawPathSeparator = try container.decode(String.self, forKey: .pathSeparator)
        pathSeparator = Character(rawPathSeparator)
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension PathComponents.ParseStrategy: Encodable {
    nonisolated
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(root, forKey: .root)
        try container.encode(String(rootSeparator), forKey: .rootSeparator)
        try container.encode(String(pathSeparator), forKey: .pathSeparator)
    }
}
