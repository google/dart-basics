// Copyright (c) 2022, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

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
T max<T extends Comparable<Object>>(T a, T b) => (a >= b) ? a : b;

/// Returns the lesser of two [Comparable] objects.
T min<T extends Comparable<Object>>(T a, T b) => (a <= b) ? a : b;
