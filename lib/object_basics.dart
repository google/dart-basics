// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// Utility extension methods for the native [Object] class.
///
/// NOTE: These extension methods will _not_ work on objects with a runtime type
/// of `dynamic`. This is a consequence of the implementation of static
/// extension methods in dart.
extension ObjectBasics on Object {
  /// Returns `true` if [this] is `null`.
  ///
  /// Example:
  /// ```dart
  /// int a;
  /// a.isNull; // true
  /// int b = 1;
  /// b.isNull; // false
  /// var c;
  /// c.isNull; // TypeError due to calling on runtime type `dynamic`.
  /// ```
  bool get isNull => this.runtimeType == Null;

  /// Returns `true` if [this] is not `null`.
  ///
  /// Example:
  /// ```dart
  /// int a = 1;
  /// a.isNotNull; // true
  /// int b;
  /// b.isNotNull; // false
  /// var c;
  /// c.isNotNull; // TypeError due to calling on runtime type `dynamic`.
  /// ```
  bool get isNotNull => !isNull;
}
