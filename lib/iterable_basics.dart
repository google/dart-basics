// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'src/sort_key_compare.dart';

/// Utility extension methods for the native [Iterable] class.
extension IterableBasics<E> on Iterable<E> {
  /// Alias for [Iterable]`.every`.
  bool all(bool Function(E) test) => this.every(test);

  /// Returns `true` if no element of [this] satisfies [test].
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].none((e) => e > 4); // true
  /// [1, 2, 3].none((e) => e > 2); // false
  /// ```
  bool none(bool Function(E) test) => !this.any(test);

  /// Returns `true` if there is exactly one element of [this] which satisfies
  /// [test].
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].one((e) => e == 2); // 1 element satisfies. Returns true.
  /// [1, 2, 3].one((e) => e > 4); // No element satisfies. Returns false.
  /// [1, 2, 3].one((e) => e > 1); // >1 element satisfies. Returns false.
  /// ```
  bool one(bool Function(E) test) {
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
      final countInOther = otherElementCounts[element] ?? 0;
      if (countInThis < countInOther) {
        return false;
      }
    }
    return true;
  }

  /// Returns the greatest element of [this] as ordered by [compare], or [null]
  /// if [this] is empty.
  ///
  /// Example:
  /// ```dart
  /// ['a', 'aaa', 'aa']
  ///   .max((a, b) => a.length.compareTo(b.length)).value; // 'aaa'
  /// ```
  E? max(Comparator<E> compare) =>
      this.isEmpty ? null : this.reduce(_generateCustomMaxFunction<E>(compare));

  /// Returns the smallest element of [this] as ordered by [compare], or [null]
  /// if [this] is empty.
  ///
  /// Example:
  /// ```dart
  /// ['a', 'aaa', 'aa']
  ///   .min((a, b) => a.length.compareTo(b.length)).value; // 'a'
  /// ```
  E? min(Comparator<E> compare) =>
      this.isEmpty ? null : this.reduce(_generateCustomMinFunction<E>(compare));

  /// Returns the element of [this] with the greatest value for [sortKey], or
  /// [null] if [this] is empty.
  ///
  /// This method is guaranteed to calculate [sortKey] only once for each
  /// element.
  ///
  /// Example:
  /// ```dart
  /// ['a', 'aaa', 'aa'].maxBy((e) => e.length).value; // 'aaa'
  /// ```
  E? maxBy(Comparable<dynamic> Function(E) sortKey) {
    final sortKeyCache = <E, Comparable<dynamic>>{};
    return this.max((a, b) => sortKeyCompare<E>(a, b, sortKey, sortKeyCache));
  }

  /// Returns the element of [this] with the least value for [sortKey], or
  /// [null] if [this] is empty.
  ///
  /// This method is guaranteed to calculate [sortKey] only once for each
  /// element.
  ///
  /// Example:
  /// ```dart
  /// ['a', 'aaa', 'aa'].minBy((e) => e.length).value; // 'a'
  /// ```
  E? minBy(Comparable<dynamic> Function(E) sortKey) {
    final sortKeyCache = <E, Comparable<dynamic>>{};
    return this.min((a, b) => sortKeyCompare<E>(a, b, sortKey, sortKeyCache));
  }

  /// Returns the sum of all the values in this iterable, as defined by
  /// [addend].
  ///
  /// Returns 0 if [this] is empty.
  ///
  /// Example:
  /// ```dart
  /// ['a', 'aa', 'aaa'].sum((s) => s.length); // 6
  /// ```
  num sum(num Function(E) addend) => this.isEmpty
      ? 0
      : this.fold(0, (prev, element) => prev + addend(element));

  /// Returns the average of all the values in this iterable, as defined by
  /// [addend].
  ///
  /// Returns 0 if [this] is empty.
  ///
  /// Example:
  /// ```dart
  /// ['a', 'aa', 'aaa'].average((s) => s.length); // 2
  /// ```
  num average(num Function(E) addend) {
    if (this.isEmpty) return 0;

    return this.sum(addend) / this.length;
  }

  /// Returns a random element of [this], or [null] if [this] is empty.
  ///
  /// If [seed] is provided, will be used as the random seed for determining
  /// which element to select. (See [math.Random].)
  E? getRandom({int? seed}) => this.isEmpty
      ? null
      : this.elementAt(math.Random(seed).nextInt(this.length));

  /// Returns an [Iterable] containing the first [end] elements of [this],
  /// excluding the first [start] elements.
  ///
  /// This method is a generalization of [List.getRange] to [Iterable]s,
  /// and obeys the same contract.
  ///
  /// Example:
  /// ```dart
  /// {3, 8, 12, 4, 1}.range(2, 4); // [12, 4]
  /// ```
  Iterable<E> getRange(int start, int end) {
    RangeError.checkValidRange(start, end, this.length);
    return this.skip(start).take(end - start);
  }
}

/// Utility extension methods for [Iterable]s containing [num]s.
extension NumIterableBasics<E extends num> on Iterable<E> {
  /// Returns the greatest number in [this], or [null] if [this] is empty.
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
  E? max([Comparator<E>? compare]) => this.isEmpty
      ? null
      : this.reduce(
          compare == null ? math.max : _generateCustomMaxFunction<E>(compare));

  /// Returns the least number in [this], or [null] if [this] is empty.
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
  E? min([Comparator<E>? compare]) => this.isEmpty
      ? null
      : this.reduce(
          compare == null ? math.min : _generateCustomMinFunction<E>(compare));

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
  /// [2, 3, 4].sum((i) => i * 0.5); // 4.5.
  /// [].sum() // 0.
  /// ```
  num sum([num Function(E)? addend]) {
    if (this.isEmpty) return 0;
    return addend == null
        ? this.reduce((a, b) => (a + b) as E)
        : this.fold(0, (prev, element) => prev + addend(element));
  }

  /// Returns the average of all the values in this iterable.
  ///
  /// If [addend] is provided, it will be used to compute the value to be
  /// averaged.
  ///
  /// Returns 0 if [this] is empty.
  ///
  /// Example:
  /// ```dart
  /// [2, 2, 4, 8].average(); // 4.
  /// [2, 2, 4, 8].average((i) => i + 1); // 5.
  /// [].average() // 0.
  /// ```
  num average([num Function(E)? addend]) {
    if (this.isEmpty) return 0;

    return this.sum(addend) / this.length;
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
