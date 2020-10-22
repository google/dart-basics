// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// Utility extension methods for the native [Object] class.
extension ObjectBasics on Object? {
  /// Returns `true` if [this] is `null`.
  ///
  /// Example:
  /// ```dart
  /// int? a;
  /// a.isNull; // true
  /// int? b = 1;
  /// b.isNull; // false
  /// ```
  bool get isNull => this.runtimeType == Null;

  /// Returns `true` if [this] is not `null`.
  ///
  /// Example:
  /// ```dart
  /// int? a = 1;
  /// a.isNotNull; // true
  /// int? b;
  /// b.isNotNull; // false
  /// ```
  bool get isNotNull => !isNull;
}
