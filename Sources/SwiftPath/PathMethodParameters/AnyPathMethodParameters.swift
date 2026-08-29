//
//  AnyPathMethodParameters.swift
//  SwiftPath
//

/// A structure containing one or more path method parameter descriptors allowing both strongly-typed
/// access and anonymized iteration at runtime.
@available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
public struct AnyPathMethodParameters<each P: PathMethodParameter> {
    /// Strongly-typed tuple of parameter(s).
    public typealias Parameters = (repeat each P)

    /// Strongly-typed tuple of parameter(s).
    public let parameters: Parameters

    /// Parameters stored as a type-erased array allowing for anonymized iteration over parameters at
    /// runtime.
    public let anyParameters: [any PathMethodParameter]

    public init(parameters: Parameters) {
        self.parameters = parameters

        var anyParameters: [any PathMethodParameter] = []
        for parameter in repeat each parameters {
            anyParameters.append(parameter)
        }

        self.anyParameters = anyParameters
    }
}

@available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
extension AnyPathMethodParameters: Sendable { }

@available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
extension AnyPathMethodParameters: PathMethodParameters { }

// MARK: - Value Array Cast Methods

@available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
extension AnyPathMethodParameters {
    /// Conditionally casts values in an ordered array and returns strongly-typed tuple of cast values.
    public func cast(values: some RandomAccessCollection) throws -> (repeat (each P).Value) {
        guard values.count == count else { throw PathMethodParametersParseError.invalidParameters }

        var counter = 0
        func castValue<ReqParam: PathMethodParameter>(_ param: ReqParam) throws -> ReqParam.Value {
            let index = values.index(values.startIndex, offsetBy: counter)
            guard values.indices.contains(index) else { throw PathMethodParametersParseError.invalidParameters }
            let value = values[index]
            let cast = try param.cast(value)
            counter += 1
            return cast
        }

        let tuple = (repeat try castValue(each parameters))
        return tuple
    }

    /// Conditionally casts values in an ordered array and returns strongly-typed tuple of cast Optional values.
    ///
    /// Values are progressively evaluated. If a value is not present, its return value will be `nil`.
    /// If a value is present but is of the wrong type, an error is thrown.
    public func castOptional(values: some RandomAccessCollection) throws -> (repeat (each P).Value?) {
        guard values.count <= count else { throw PathMethodParametersParseError.invalidParameters }

        var counter = 0
        func castValue<ReqParam: PathMethodParameter>(_ param: ReqParam) throws -> ReqParam.Value? {
            let index = values.index(values.startIndex, offsetBy: counter)
            guard values.indices.contains(index) else { return nil }
            let value = values[index]
            let cast = try param.cast(value)
            counter += 1
            return cast
        }

        return (repeat try castValue(each parameters))
    }
}
