//
//  PathMethodParameterValues.swift
//  SwiftPath
//

/// Conforms a type to be parseable from path method parameters and/or able to be formatted as path
/// method parameters.
///
/// Parse strategies and format styles can be used by also conforming to ``ParseablePathMethodParameterValues``
/// and/or ``FormattablePathMethodParameterValues``.
///
/// A type storing path method parameter values should not know or care about what `Path` type(s) are
/// using it. It should generally be an autonomous value type and reusable.
public protocol PathMethodParameterValues { }
