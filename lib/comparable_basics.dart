// Copyright (c) 2022, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:math' as math show min, max;

/// Utility extension methods for the [Comparable] class.
extension ComparableBasics<T> on Comparable<T> {
  /// Returns true if [this] should be ordered strictly before [other].
  bool operator <(T other) => compareTo(other) < 0;

  /// Returns true if [this] should be ordered strictly after [other].
  bool operator >(T other) => compareTo(other) > 0;

  /// Returns true if [this] should be ordered before or with [other].
  bool operator <=(T other) => compareTo(other) <= 0;

  /// Returns true if [this] should be ordered after or with [other].
  bool operator >=(T other) => compareTo(other) >= 0;
}

/// Returns the greater of two [Comparable] objects.
///
/// For [num] values, behaves identically to [math.max].
///
/// If the arguments compare equal, then it is unspecified which of the two
/// arguments is returned.
T max<T extends Comparable<Object>>(T a, T b) {
  if (a is num) {
    return math.max(a, b as num) as T;
  }
  return (a >= b) ? a : b;
}

/// Returns the lesser of two [Comparable] objects.
///
/// For [num] values, behaves identically to [math.min].
///
/// If the arguments compare equal, then it is unspecified which of the two
/// arguments is returned.
T min<T extends Comparable<Object>>(T a, T b) {
  if (a is num) {
    return math.min(a, b as num) as T;
  }
  return (a <= b) ? a : b;
}
