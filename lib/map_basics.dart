// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// Utility extension methods for the native [Map] class.
extension MapBasics<K, V> on Map<K, V> {
  /// Returns a new Map where each entry is inverted, with the key becoming the
  /// value and the value becoming the key.
  ///
  /// Example:
  /// ```dart
  /// var map = {'a': 1, 'b': 2, 'c': 3};
  /// map.invert(); // {1: 'a', 2: 'b', 3: 'c'}
  /// ```
  ///
  /// As Map does not guarantee an order of iteration over entries, this method
  /// does not guarantee which key will be preserved as the value in the case
  /// where more than one key is associated with the same value.
  ///
  /// Example:
  /// ```dart
  /// var map = {'a': 1, 'b': 2, 'c': 2};
  /// map.invert(); // May return {1: 'a', 2: 'b'} or {1: 'a', 2: 'c'}.
  /// ```
  Map<V, K> invert() {
    final inverted = <V, K>{};
    for (var entry in this.entries) {
      inverted[entry.value] = entry.key;
    }
    return inverted;
  }
}
