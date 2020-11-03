// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// Utility extension methods for the native [Map] class.
extension MapBasics<K, V> on Map<K, V> {
  /// A type-checked version of [operator []] that additionally supports
  /// returning a default value.
  ///
  /// Returns [defaultValue] if the key is not found.  This is slightly
  /// different from `map[key] ?? defaultValue` if the [Map] stores `null`
  /// values.
  //
  // Remove if implemented upstream:
  // https://github.com/dart-lang/sdk/issues/37392
  V? get(K key, {V? defaultValue}) =>
      this.containsKey(key) ? this[key] : defaultValue;

  /// Returns a new [Map] containing all the entries of [this] for which the key
  /// satisfies [test].
  ///
  /// Example:
  /// ```dart
  /// var map = {'a': 1, 'bb': 2, 'ccc': 3}
  /// map.whereKey((key) => key.length > 1); // {'bb': 2, 'ccc': 3}
  /// ```
  Map<K, V> whereKey(bool Function(K) test) =>
      // Entries do not need to be cloned because they are const.
      Map.fromEntries(this.entries.where((entry) => test(entry.key)));

  /// Returns a new [Map] containing all the entries of [this] for which the
  /// value satisfies [test].
  ///
  /// Example:
  /// ```dart
  /// var map = {'a': 1, 'b': 2, 'c': 3};
  /// map.whereValue((value) => value > 1); // {'b': 2, 'c': 3}
  /// ```
  Map<K, V> whereValue(bool Function(V) test) =>
      // Entries do not need to be cloned because they are const.
      Map.fromEntries(this.entries.where((entry) => test(entry.value)));

  /// Returns a new [Map] where each entry is inverted, with the key becoming
  /// the value and the value becoming the key.
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
  Map<V, K> invert() => Map.fromEntries(
      this.entries.map((entry) => MapEntry(entry.value, entry.key)));
}
