// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// Utility extension methods for the native [Set] class.
extension SetBasics<E> on Set<E> {
  /// Returns `true` if [this] and [other] contain exactly the same elements.
  ///
  /// Example:
  /// ```dart
  /// var set = {'a', 'b', 'c'};
  /// set.isEqual({'b', 'a', 'c'}); // true
  /// set.isEqual({'b', 'a', 'f'}); // false
  /// set.isEqual({'a', 'b'}); // false
  /// set.isEqual({'a', 'b', 'c', 'd'}); // false
  /// ```
  bool isEqualTo(Set<Object> other) =>
      this.length == other.length &&
      this.length == this.intersection(other).length;

  /// Returns `true` if [this] and [other] have no elements in common.
  ///
  /// Example:
  /// ```dart
  /// var set = {'a', 'b', 'c'};
  /// set.isDisjoint({'d', 'e', 'f'}); // true
  /// set.isDisjoint({'d', 'e', 'b'}); // false
  /// ```
  bool isDisjointWith(Set<Object> other) => this.intersection(other).isEmpty;

  /// Returns `true` if [this] and [other] have at least one element in common.
  ///
  /// Example:
  /// ```dart
  /// var set = {'a', 'b', 'c'};
  /// set.isIntersecting({'d', 'e', 'b'}); // true
  /// set.isIntersecting({'d', 'e', 'f'}); // false
  /// ```
  bool isIntersectingWith(Set<Object> other) =>
      this.intersection(other).isNotEmpty;

  /// Returns `true` if every element of [this] is contained in [other].
  ///
  /// Example:
  /// ```dart
  /// var set = {'a', 'b', 'c'};
  /// set.isSubset({'a', 'b', 'c', 'd'}); // true
  /// set.isSubset({'a', 'b', 'c'}); // true
  /// set.isSubset({'a', 'b', 'f'}); // false
  /// ```
  bool isSubsetOf(Set<Object> other) =>
      this.length <= other.length && other.containsAll(this);

  /// Returns `true` if every element of [other] is contained in [this].
  ///
  /// ```dart
  /// var set = {'a', 'b', 'c'};
  /// set.isSuperset({'a', 'b'}); // true
  /// set.isSuperset({'a', 'b', 'c'}); // true
  /// set.isSuperset({'a', 'b', 'f'}); // false
  /// ```
  bool isSupersetOf(Set<Object> other) =>
      this.length >= other.length && this.containsAll(other);

  /// Returns `true` if every element of [this] is contained in [other] and at
  /// least one element of [other] is not contained in [this].
  ///
  /// Example:
  /// ```dart
  /// var set = {'a', 'b', 'c'};
  /// set.isStrictSubset({'a', 'b', 'c', 'd'}); // true
  /// set.isStrictSubset({'a', 'b', 'c'}); // false
  /// set.isStrictSubset({'a', 'b', 'f'}); // false
  /// ```
  bool isStrictSubsetOf(Set<Object> other) =>
      this.length < other.length && other.containsAll(this);

  /// Returns `true` if every element of [other] is contained in [this] and at
  /// least one element of [this] is not contained in [other].
  ///
  /// ```dart
  /// var set = {'a', 'b', 'c'};
  /// set.isStrictSuperset({'a', 'b'}); // true
  /// set.isStrictSuperset({'a', 'b', 'c'}); // false
  /// set.isStrictSuperset({'a', 'b', 'f'}); // false
  /// ```
  bool isStrictSupersetOf(Set<Object> other) =>
      this.length > other.length && this.containsAll(other);

  /// Returns a map grouping all elements of [this] with the same value for
  /// [classifier].
  ///
  /// Example:
  /// ```dart
  /// {'aaa', 'bbb', 'cc', 'a', 'bb'}.classify<int>((e) => e.length);
  /// // Returns {
  /// //   1: {'a'},
  /// //   2: {'cc', 'bb'},
  /// //   3: {'aaa', 'bbb'}
  /// // }
  /// ```
  Map<K, Set<E>> classify<K>(K classifier(E element)) {
    final groups = <K, Set<E>>{};
    for (var e in this) {
      groups.putIfAbsent(classifier(e), () => <E>{}).add(e);
    }
    return groups;
  }
}
