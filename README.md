# SwiftPath

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Forchetect%2Fswift-path%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/orchetect/swift-path) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Forchetect%2Fswift-path%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/orchetect/swift-path) [![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/orchetect/swift-path/blob/main/LICENSE)

Protocols and supporting types for creating composable path types in Swift.

- `Path` family of protocols to define path types
- `PathComponent` family of protocols designed to help serialize and deserialize path types
- `PathMethod` family of protocols to define path method components
- `PethMethodParameter` and `PethMethodParameters` family of protocols to define parameters of path methods
- `PathMethodParameterValues` family of protocols to define value types and parsing/formatting of path method parameters

The components are adaptable to be applicable to a wide variety of path formats (file path, URL, OSC address, etc.).

> [!NOTE]
>
> 🚧 This repository is under construction.

## Package Traits

Package traits are opt-in and are disabled by default.

Available package traits:

| Trait Name | Description                                                  |
| ---------- | ------------------------------------------------------------ |
| `osc`      | OSC (Open Sound Control) related protocols and types that extend path and parameter types. This trait implicitly adds the [SwiftOSC Core](https://github.com/orchetect/swift-osc-core) dependency. |

## Documentation

No separate documentation is provided at this time.

## Author

Coded by a bunch of 🐹 hamsters in a trenchcoat that calls itself [@orchetect](https://github.com/orchetect).

## License

Licensed under the MIT license. See [LICENSE](https://github.com/orchetect/swift-path/blob/main/LICENSE) for details.

## Sponsoring

If you enjoy using this library and want to contribute to open-source financially, GitHub sponsorship is much appreciated. Feedback and code contributions are also welcome.

## Community & Support

Please do not email maintainers for technical support. Several options are available for issues and questions:

- If an issue is a verifiable bug with reproducible steps it may be posted in [Issues](https://github.com/orchetect/swift-path/issues).
- Questions and feature ideas can be posted to [Discussions](https://github.com/orchetect/swift-path/discussions).

## Contributions

Contributions are welcome. Posting in [Discussions](https://github.com/orchetect/swift-path/discussions) first prior to new submitting PRs for features or modifications is encouraged.

## Code Quality & AI Contribution Policy

In an effort to maintain a consistent level of code quality and safety, this repository was built by hand and is maintained without the use of AI code generation.

AI-assisted contributions are welcome, but must remain modest in scope, maintain the same degree of quality and care, and be thoroughly vetted before acceptance.
