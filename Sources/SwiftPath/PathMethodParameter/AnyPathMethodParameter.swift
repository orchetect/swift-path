//
//  AnyPathMethodParameter.swift
//  SwiftPath
//

import Foundation

/// Generic concrete implementation of ``PathMethodParameter`` providing static constructors
/// for common value types.
public struct AnyPathMethodParameter<Value> {
    /// The canonical concrete value type of the parameter.
    public typealias Value = Value

    nonisolated
    public let label: String

    @inlinable
    nonisolated
    public init(label: String) {
        self.label = label
    }
}

extension AnyPathMethodParameter: Equatable { }

extension AnyPathMethodParameter: Hashable { }

extension AnyPathMethodParameter: Sendable { }

extension AnyPathMethodParameter: PathMethodParameter { }

// MARK: - Static Constructors: Bool

extension PathMethodParameter where Self == AnyPathMethodParameter<Bool> {
    /// Generic path method parameter descriptor instance using `Bool` value type.
    @inlinable
    nonisolated
    public static func bool(label: String) -> Self {
        Self(label: label)
    }
}

// MARK: - Static Constructors: Data

extension PathMethodParameter where Self == AnyPathMethodParameter<Data> {
    /// Generic path method parameter descriptor instance using `Data` value type.
    @inlinable
    nonisolated
    public static func data(label: String) -> Self {
        Self(label: label)
    }
}

// MARK: - Static Constructors: Int

extension PathMethodParameter where Self == AnyPathMethodParameter<Int> {
    /// Generic path method parameter descriptor instance using `Int` value type.
    @inlinable
    nonisolated
    public static func int(label: String) -> Self {
        Self(label: label)
    }
}

extension PathMethodParameter where Self == AnyPathMethodParameter<Int8> {
    /// Generic path method parameter descriptor instance using `Int8` value type.
    @inlinable
    nonisolated
    public static func int8(label: String) -> Self {
        Self(label: label)
    }
}

extension PathMethodParameter where Self == AnyPathMethodParameter<Int16> {
    /// Generic path method parameter descriptor instance using `Int16` value type.
    @inlinable
    nonisolated
    public static func int16(label: String) -> Self {
        Self(label: label)
    }
}

extension PathMethodParameter where Self == AnyPathMethodParameter<Int32> {
    /// Generic path method parameter descriptor instance using `Int32` value type.
    @inlinable
    nonisolated
    public static func int32(label: String) -> Self {
        Self(label: label)
    }
}

extension PathMethodParameter where Self == AnyPathMethodParameter<Int64> {
    /// Generic path method parameter descriptor instance using `Int64` value type.
    @inlinable
    nonisolated
    public static func int64(label: String) -> Self {
        Self(label: label)
    }
}

extension PathMethodParameter where Self == AnyPathMethodParameter<UInt> {
    /// Generic path method parameter descriptor instance using `UInt` value type.
    @inlinable
    nonisolated
    public static func uInt(label: String) -> Self {
        Self(label: label)
    }
}

extension PathMethodParameter where Self == AnyPathMethodParameter<UInt8> {
    /// Generic path method parameter descriptor instance using `UInt8` value type.
    @inlinable
    nonisolated
    public static func uInt8(label: String) -> Self {
        Self(label: label)
    }
}

extension PathMethodParameter where Self == AnyPathMethodParameter<UInt16> {
    /// Generic path method parameter descriptor instance using `UInt16` value type.
    @inlinable
    nonisolated
    public static func uInt16(label: String) -> Self {
        Self(label: label)
    }
}

extension PathMethodParameter where Self == AnyPathMethodParameter<UInt32> {
    /// Generic path method parameter descriptor instance using `UInt32` value type.
    @inlinable
    nonisolated
    public static func uInt32(label: String) -> Self {
        Self(label: label)
    }
}

extension PathMethodParameter where Self == AnyPathMethodParameter<UInt64> {
    /// Generic path method parameter descriptor instance using `UInt64` value type.
    @inlinable
    nonisolated
    public static func uInt64(label: String) -> Self {
        Self(label: label)
    }
}

// MARK: - Static Constructors: Float

extension PathMethodParameter where Self == AnyPathMethodParameter<Double> {
    /// Generic path method parameter descriptor instance using `Double` value type.
    @inlinable
    nonisolated
    public static func double(label: String) -> Self {
        Self(label: label)
    }
}

extension PathMethodParameter where Self == AnyPathMethodParameter<Float> {
    /// Generic path method parameter descriptor instance using `Float` value type.
    @inlinable
    nonisolated
    public static func float(label: String) -> Self {
        Self(label: label)
    }
}

// MARK: - Static Constructors: String

extension PathMethodParameter where Self == AnyPathMethodParameter<String> {
    /// Generic path method parameter descriptor instance using `String` value type.
    @inlinable
    nonisolated
    public static func string(label: String) -> Self {
        Self(label: label)
    }
}
