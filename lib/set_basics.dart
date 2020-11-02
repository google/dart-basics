// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:math' as math;

/// Utility extension methods for the native [Set] class.
extension SetBasics<E> on Set<E> {
  /// Returns `true` if [this] and [other] contain exactly the same elements.
  ///
  /// Example:
  /// ```dart
  /// var set = {'a', 'b', 'c'};
  /// set.isEqualTo({'b', 'a', 'c'}); // true
  /// set.isEqualTo({'b', 'a', 'f'}); // false
  /// set.isEqualTo({'a', 'b'}); // false
  /// set.isEqualTo({'a', 'b', 'c', 'd'}); // false
  /// ```
  bool isEqualTo(Set<Object> other) =>
      this.length == other.length && this.containsAll(other);

  /// Returns `true` if [this] and [other] have no elements in common.
  ///
  /// Example:
  /// ```dart
  /// var set = {'a', 'b', 'c'};
  /// set.isDisjointWith({'d', 'e', 'f'}); // true
  /// set.isDisjointWith({'d', 'e', 'b'}); // false
  /// ```
  bool isDisjointWith(Set<Object> other) => this.intersection(other).isEmpty;

  /// Returns `true` if [this] and [other] have at least one element in common.
  ///
  /// Example:
  /// ```dart
  /// var set = {'a', 'b', 'c'};
  /// set.isIntersectingWith({'d', 'e', 'b'}); // true
  /// set.isIntersectingWith({'d', 'e', 'f'}); // false
  /// ```
  bool isIntersectingWith(Set<Object> other) =>
      this.intersection(other).isNotEmpty;

  /// Returns `true` if every element of [this] is contained in [other].
  ///
  /// Example:
  /// ```dart
  /// var set = {'a', 'b', 'c'};
  /// set.isSubsetOf({'a', 'b', 'c', 'd'}); // true
  /// set.isSubsetOf({'a', 'b', 'c'}); // true
  /// set.isSubsetOf({'a', 'b', 'f'}); // false
  /// ```
  bool isSubsetOf(Set<Object> other) =>
      this.length <= other.length && other.containsAll(this);

  /// Returns `true` if every element of [other] is contained in [this].
  ///
  /// ```dart
  /// var set = {'a', 'b', 'c'};
  /// set.isSupersetOf({'a', 'b'}); // true
  /// set.isSupersetOf({'a', 'b', 'c'}); // true
  /// set.isSupersetOf({'a', 'b', 'f'}); // false
  /// ```
  bool isSupersetOf(Set<Object> other) =>
      this.length >= other.length && this.containsAll(other);

  /// Returns `true` if every element of [this] is contained in [other] and at
  /// least one element of [other] is not contained in [this].
  ///
  /// Example:
  /// ```dart
  /// var set = {'a', 'b', 'c'};
  /// set.isStrictSubsetOf({'a', 'b', 'c', 'd'}); // true
  /// set.isStrictSubsetOf({'a', 'b', 'c'}); // false
  /// set.isStrictSubsetOf({'a', 'b', 'f'}); // false
  /// ```
  bool isStrictSubsetOf(Set<Object> other) =>
      this.length < other.length && other.containsAll(this);

  /// Returns `true` if every element of [other] is contained in [this] and at
  /// least one element of [this] is not contained in [other].
  ///
  /// ```dart
  /// var set = {'a', 'b', 'c'};
  /// set.isStrictSupersetOf({'a', 'b'}); // true
  /// set.isStrictSupersetOf({'a', 'b', 'c'}); // false
  /// set.isStrictSupersetOf({'a', 'b', 'f'}); // false
  /// ```
  bool isStrictSupersetOf(Set<Object> other) =>
      this.length > other.length && this.containsAll(other);

  /// Removes a random element of [this] and returns it.
  ///
  /// Returns [null] if [this] is empty.
  E? takeRandom() {
    if (this.isEmpty) return null;
    final element = this.elementAt(math.Random().nextInt(this.length));
    this.remove(element);
    return element;
  }

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
