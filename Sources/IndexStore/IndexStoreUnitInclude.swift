//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

public import IndexStoreCAPI

/// A `#include` (or equivalent like `#import`) directive that was processed while indexing a unit.
public struct IndexStoreUnitInclude: Sendable {
  @usableFromInline nonisolated(unsafe) let include: indexstore_unit_include_t
  @usableFromInline let library: IndexStoreLibrary

  @usableFromInline
  init(include: indexstore_unit_include_t, library: IndexStoreLibrary) {
    self.include = include
    self.library = library
  }

  /// The path of the source file that contains the `#include` directive.
  @inlinable
  public var sourcePath: IndexStoreStringRef {

    get {
      let stringRef = IndexStoreStringRef(library.api.unit_include_get_source_path(include))
      return stringRef
    }
  }

  /// The line in `sourcePath` at which the `#include` directive occurs.
  @inlinable
  public var line: Int {
    return Int(library.api.unit_include_get_source_line(include))
  }

  /// The path of the source file that is included.
  @inlinable
  public var targetPath: IndexStoreStringRef {

    get {
      let stringRef = IndexStoreStringRef(library.api.unit_include_get_target_path(include))
      return stringRef
    }
  }
}
