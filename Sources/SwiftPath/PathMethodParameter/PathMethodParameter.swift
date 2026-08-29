//
//  PathMethodParameter.swift
//  SwiftPath
//

/// A parameter descriptor used in a parameterized path.
///
/// A parameter descriptor defines both a label (key/value key name) and a concrete value type.
///
/// Parameters may be converted between `Value` and other concrete types by implementing:
///
/// - a type conforming to the `ParseStrategy` protocol whose `ParseOutput` is `Value`
/// - a type conforming to the `FormatStyle` protocol whose `FormatInput` is `Value`
///
/// The ``PathMethodParameter/parse(_:strategy:)`` and ``PathMethodParameter/format(_:format:)``
/// methods can then be passed a value and an instance of a parse strategy or format style respectively
/// to convert the value between concrete types.
public protocol PathMethodParameter: Sendable {
    /// The canonical concrete value type of the parameter.
    associatedtype Value

    /// The parameter's label (key name) when used in key/value dictionaries.
    ///
    /// This property should be stable and not localized (English-only).
    var label: String { get }
}

extension PathMethodParameter {
    /// Conditionally casts any value to `Value`.
    /// Throws an error if the type of `value` is not `Value`.
    public func cast(_ value: Any) throws -> Value {
        guard let castValue = value as? Value else { throw PathMethodParametersParseError.invalidParameters }
        return castValue
    }
}

// MARK: - Required & Optional Value Array Casting

/// Conditionally casts values in an ordered array and returns strongly-typed tuple of cast values.
/// If any value(s) cannot be cast or there are too few/many values, an error is thrown.
@available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
public func cast<each RP: PathMethodParameter, each OP: PathMethodParameter>(
    values: some RandomAccessCollection,
    required: (repeat each RP),
    optional: (repeat each OP)
) throws -> (repeat (each RP).Value, repeat (each OP).Value?) {
    var counter = 0
    func castRequiredValue<ReqParam: PathMethodParameter>(_ param: ReqParam) throws -> ReqParam.Value {
        let index = values.index(values.startIndex, offsetBy: counter)
        guard values.indices.contains(index) else { throw PathMethodParametersParseError.invalidParameters }
        let value = values[index]
        let cast = try param.cast(value)
        counter += 1
        return cast
    }
    func castOptionalValue<ReqParam: PathMethodParameter>(_ param: ReqParam) throws -> ReqParam.Value? {
        let index = values.index(values.startIndex, offsetBy: counter)
        guard values.indices.contains(index) else { return nil }
        let value = values[index]
        let cast = try param.cast(value)
        counter += 1
        return cast
    }

    let reqCast = (repeat try castRequiredValue(each required))
    let optCast = (repeat try castOptionalValue(each optional))

    guard values.count <= counter else { throw PathMethodParametersParseError.invalidParameters }

    return (repeat each reqCast, repeat each optCast)
}
