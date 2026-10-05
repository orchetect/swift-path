//
//  Nested Enums CaseIterableContainerPathComponent Tests.swift
//  SwiftPath • https://github.com/orchetect/swift-path
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftPath
import Testing

/// This suite uses a mock `Path` type comprised of nested enums that each conform to
/// ``PathComponent``, ``ContainerPathComponent`` and ``CaseIterableContainerPathComponent``.
///
/// The `TertiaryPath` mock type is an example that overrides the default `static var allCases`
/// with a statically-stored property of the same name so that it is not re-computed on every access.
@Suite
struct Nested_Enums_CaseIterableContainerPathComponent_Tests {
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func enumPath_allCases() {
        #expect(EnumPath.allCases == [
            .one(.foo(.a)),
            .one(.foo(.b)),
            .one(.bar),
            .two(.foo(.a)),
            .two(.foo(.b)),
            .two(.bar),
            .three
        ])
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func subPath_allCases() {
        #expect(SubPath.allCases == [
            .foo(.a),
            .foo(.b),
            .bar
        ])
    }

    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    @Test
    func tertiaryPath_allCases() {
        #expect(TertiaryPath.allCases == [
            .a,
            .b
        ])
    }
}

// MARK: - Test Types - `EnumPath`

private enum EnumPath: Equatable {
    case one(SubPath)
    case two(SubPath)
    case three
}

extension EnumPath: Path {
    // `var pathComponents` default implementation is provided by `PathComponent`

    // `init(pathComponents: PathComponents)` default implementation is provided by `ConstructiblePathComponent`
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension EnumPath: StringParseablePath {
    static let pathStringParseStrategy = PathComponents.ParseStrategy(
        root: nil,
        rootSeparator: ">",
        pathSeparator: "."
    )
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension EnumPath: StringFormattablePath {
    static let pathStringFormatStyle = PathComponents.FormatStyle(
        root: .absolute,
        rootSeparator: ">",
        pathSeparator: "."
    )
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension EnumPath: StringDecodablePath {
    // default implementation is provided when Self conforms to `StringParseablePath`
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension EnumPath: StringEncodablePath {
    // default implementation is provided when Self conforms to `StringFormattablePath`
}

extension EnumPath: PathComponent { }

extension EnumPath: IdentifiablePathComponent {
    enum PathComponentID: String, CaseIterable {
        case one
        case two
        case three
    }

    var pathComponentID: PathComponentID {
        switch self {
        case .one: .one
        case .two: .two
        case .three: .three
        }
    }
}

extension EnumPath: ConstructiblePathComponent {
    static func constructor(for pathComponent: PathComponentID) -> any PathComponentConstructor<Self> {
        switch pathComponent {
        case .one: ContainerConstructor(of: SubPath.self) { .one($0) }
        case .two: ContainerConstructor(of: SubPath.self) { .two($0) }
        case .three: MethodConstructor { .three }
        }
    }
}

extension EnumPath: ContainerPathComponent {
    var nextPathComponent: (any PathComponent)? {
        switch self {
        case let .one(one): one
        case let .two(two): two
        case .three: nil
        }
    }
}

extension EnumPath: CaseIterableContainerPathComponent {
    static func allCases(for id: PathComponentID) -> [Self] {
        switch id {
        case .one: SubPath.allCases.map { .one($0) }
        case .two: SubPath.allCases.map { .two($0) }
        case .three: [.three]
        }
    }
}

// MARK: - Test Types - `SubPath`

private enum SubPath: Equatable {
    case foo(TertiaryPath)
    case bar
}

extension SubPath: Path {
    // `var pathComponents` default implementation is provided by `PathComponent`

    // `init(pathComponents: PathComponents)` default implementation is provided by `ConstructiblePathComponent`
}

extension SubPath: PathComponent { }

extension SubPath: IdentifiablePathComponent {
    enum PathComponentID: String, CaseIterable {
        case foo
        case bar
    }

    var pathComponentID: PathComponentID {
        switch self {
        case .foo: .foo
        case .bar: .bar
        }
    }
}

extension SubPath: ConstructiblePathComponent {
    static func constructor(for pathComponent: PathComponentID) -> any PathComponentConstructor<Self> {
        switch pathComponent {
        case .foo: ContainerConstructor(of: TertiaryPath.self) { .foo($0) }
        case .bar: MethodConstructor { .bar }
        }
    }
}

extension SubPath: ContainerPathComponent {
    var nextPathComponent: (any PathComponent)? {
        switch self {
        case let .foo(foo): foo
        case .bar: nil
        }
    }
}

extension SubPath: CaseIterableContainerPathComponent {
    static func allCases(for id: PathComponentID) -> [Self] {
        switch id {
        case .foo: TertiaryPath.allCases.map { .foo($0) }
        case .bar: [.bar]
        }
    }
}

// MARK: - Test Types - `TertiaryPath`

private enum TertiaryPath: Equatable {
    case a
    case b
}

extension TertiaryPath: Path {
    // `var pathComponents` default implementation is provided by `PathComponent`

    // `init(pathComponents: PathComponents)` default implementation is provided by `ConstructiblePathComponent`
}

extension TertiaryPath: PathComponent { }

extension TertiaryPath: IdentifiablePathComponent {
    enum PathComponentID: String, CaseIterable {
        case a
        case b
    }

    var pathComponentID: PathComponentID {
        switch self {
        case .a: .a
        case .b: .b
        }
    }
}

extension TertiaryPath: ConstructiblePathComponent {
    static func constructor(for pathComponent: PathComponentID) -> any PathComponentConstructor<Self> {
        switch pathComponent {
        case .a: MethodConstructor { .a }
        case .b: MethodConstructor { .b }
        }
    }
}

extension TertiaryPath: CaseIterableContainerPathComponent {
    // Note: it's possible to override the default `static var allCases` with a statically-stored
    // property so that it is not re-computed on every access.
    static let allCases: [Self] = generateAllCases()

    static func allCases(for id: PathComponentID) -> [Self] {
        switch id {
        case .a: [.a]
        case .b: [.b]
        }
    }
}
