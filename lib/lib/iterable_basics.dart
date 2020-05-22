// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:math' as math;
import 'package:quiver/core.dart';

/// Utility extension methods for the native [Iterable] class.
extension IterableBasics<E> on Iterable<E> {
  /// Alias for [Iterable]`.every`.
  bool all(bool test(E element)) => this.every(test);

  /// Returns `true` if no element of [this] satisfies [test].
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].none((e) => e > 4); // true
  /// [1, 2, 3].none((e) => e > 2); // false
  /// ```
  bool none(bool test(E element)) => !this.any(test);

  /// Returns `true` if there is exactly one element of [this] which satisfies
  /// [test].
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].one((e) => e == 2); // 1 element satisfies. Returns true.
  /// [1, 2, 3].one((e) => e > 4); // No element satisfies. Returns false.
  /// [1, 2, 3].one((e) => e > 1); // >1 element satisfies. Returns false.
  /// ```
  bool one(bool test(E element)) {
    bool foundOne = false;
    for (var e in this) {
      if (test(e)) {
        if (foundOne) return false;
        foundOne = true;
      }
    }
    return foundOne;
  }

  /// Returns `true` if [this] contains at least one element also contained in
  /// [other].
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].containsAny([5, 2]); // true
  /// [1, 2, 3].containsAny([4, 5, 6]); // false
  /// ```
  bool containsAny(Iterable<E> other) => this.any(other.contains);

  /// Returns true if every element in [other] also exists in [this].
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].containsAll([1, 2]); // true
  /// [1, 2].containsAll([1, 2, 3]); // false
  /// ```
  ///
  /// If [collapseDuplicates] is true, only the presence of a value will be
  /// considered, not the number of times it occurs. If [collapseDuplicates] is
  /// false, the number of occurrences of a given value in [this] must be
  /// greater than or equal to the number of occurrences of that value in
  /// [other] for the result to be true.
  ///
  /// Example:
  /// ```
  /// [1, 2, 3].containsAll([1, 1, 1, 2]); // true
  /// [1, 2, 3].containsAll([1, 1, 1, 2], collapseDuplicates: false); // false
  /// [1, 1, 2, 3].containsAll([1, 1, 2], collapseDuplicates: false); // true
  /// ```
  bool containsAll(Iterable<E> other, {bool collapseDuplicates = true}) {
    if (other.isEmpty) return true;
    if (collapseDuplicates) {
      return Set<E>.from(this).containsAll(Set<E>.from(other));
    }

    final thisElementCounts = _elementCountsIn<E>(this);
    final otherElementCounts = _elementCountsIn<E>(other);

    for (final element in otherElementCounts.keys) {
      final countInThis = thisElementCounts[element] ?? 0;
      if (countInThis < otherElementCounts[element]) {
        return false;
      }
    }
    return true;
  }

  /// Returns an [Optional] with the greatest element of [this], as ordered by
  /// [compare], or [Optional.absent()] if [this] is empty.
  ///
  /// Example:
  /// ```dart
  /// ['a', 'aaa', 'aa']
  ///   .max((a, b) => a.length.compareTo(b.length)).value; // 'aaa'
  /// ```
  Optional<E> max(Comparator<E> compare) => this.isEmpty
      ? Optional.absent()
      : Optional.of(this.reduce(_generateCustomMaxFunction<E>(compare)));

  /// Returns an [Optional] with the smallest element of [this], as ordered by
  /// [compare], or [Optional.absent()] if [this] is empty.
  ///
  /// Example:
  /// ```dart
  /// ['a', 'aaa', 'aa']
  ///   .min((a, b) => a.length.compareTo(b.length)).value; // 'a'
  /// ```
  Optional<E> min(Comparator<E> compare) => this.isEmpty
      ? Optional.absent()
      : Optional.of(this.reduce(_generateCustomMinFunction<E>(compare)));

  /// Returns an [Optional] with the element of [this] with the greatest value
  /// for [sortyKey], or [Optional.absent()] if [this] is empty.
  ///
  /// Example:
  /// ```dart
  /// ['a', 'aaa', 'aa'].maxBy((e) => e.length).value; // 'aaa'
  /// ```
  Optional<E> maxBy(Comparable Function(E) sortKey) =>
      this.max((a, b) => sortKey(a).compareTo(sortKey(b)));

  /// Returns an [Optional] with the element of [this] with the least value for
  /// [sortyKey], or [Optional.absent()] if [this] is empty.
  ///
  /// Example:
  /// ```dart
  /// ['a', 'aaa', 'aa'].minBy((e) => e.length).value; // 'a'
  /// ```
  Optional<E> minBy(Comparable Function(E) sortKey) =>
      this.min((a, b) => sortKey(a).compareTo(sortKey(b)));

  /// Returns the sum of all the values in this iterable, as defined by
  /// [addend].
  ///
  /// Returns 0 if [this] is empty.
  ///
  /// Example:
  /// ```dart
  /// ['a', 'aa', 'aaa'].sum((s) => s.length); // 6.
  /// ```
  num sum(num Function(E) addend) {
    if (this.isEmpty) return 0;
    return this.fold(0, (prev, element) => prev + addend(element));
  }
}

/// Utility extension methods for [Iterable]s containing [num]s.
extension NumIterableBasics<E extends num> on Iterable<E> {
  /// Returns an [Optional] with the greatest number in [this], or
  /// [Optional.absent()] if [this] is empty.
  ///
  /// Example:
  /// ```dart
  /// [104, 3, 18].max().value; // 104
  /// ```
  ///
  /// If [compare] is provided, it will be used to order the elements.
  ///
  /// Example:
  /// ```dart
  /// [-47, 10, 2].max((a, b) =>
  ///     a.toString().length.compareTo(b.toString().length)).value; // -47
  /// ```
  Optional<E> max([Comparator<E> compare]) {
    if (this.isEmpty) return Optional.absent();
    return Optional.of(this.reduce(
      compare == null ? math.max : _generateCustomMaxFunction<E>(compare),
    ));
  }

  /// Returns an [Optional] with the least number in [this], or
  /// [Optional.absent()] if [this] is empty.
  ///
  /// Example:
  /// ```dart
  /// [104, 3, 18].min().value; // 3
  /// ```
  ///
  /// If [compare] is provided, it will be used to order the elements.
  ///
  /// Example:
  /// ```dart
  /// [-100, -200, 5].min((a, b) =>
  ///     a.toString().length.compareTo(b.toString().length)).value; // 5
  /// ```
  Optional<E> min([Comparator<E> compare]) {
    if (this.isEmpty) return Optional.absent();
    return Optional.of(this.reduce(
      compare == null ? math.min : _generateCustomMinFunction<E>(compare),
    ));
  }

  /// Returns the sum of all the values in this iterable.
  ///
  /// If [addend] is provided, it will be used to compute the value to be
  /// summed.
  ///
  /// Returns 0 if [this] is empty.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].sum(); // 6.
  /// [1, 2, 3].sum((i) => i * 3); // 18.
  /// [].sum() // 0.
  /// ```
  num sum([num Function(E) addend]) {
    if (this.isEmpty) return 0;
    return addend == null
        ? this.reduce((a, b) => a + b)
        : this.fold(0, (prev, element) => prev + addend(element));
  }
}

T Function(T, T) _generateCustomMaxFunction<T>(Comparator<T> compare) {
  T max(T a, T b) {
    if (compare(a, b) >= 0) return a;
    return b;
  }

  return max;
}

T Function(T, T) _generateCustomMinFunction<T>(Comparator<T> compare) {
  T min(T a, T b) {
    if (compare(a, b) <= 0) return a;
    return b;
  }

  return min;
}

Map<E, int> _elementCountsIn<E>(Iterable<E> iterable) {
  final counts = <E, int>{};
  for (final element in iterable) {
    final currentCount = counts[element] ?? 0;
    counts[element] = currentCount + 1;
  }
  return counts;
}
