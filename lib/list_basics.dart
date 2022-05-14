// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'src/slice_indices.dart';
import 'src/sort_key_compare.dart';

/// Utility extension methods for the native [List] class.
extension ListBasics<E> on List<E> {
  /// Returns a new list containing the elements of [this] from [start]
  /// inclusive to [end] exclusive, skipping by [step].
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4].slice(start: 1, end: 3); // [2, 3]
  /// [1, 2, 3, 4].slice(start: 1, end: 4, step: 2); // [2, 4]
  /// ```
  ///
  /// [start] defaults to the first element if [step] is positive and to the
  /// last element if [step] is negative. [end] does the opposite.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4].slice(end: 2); // [1, 2]
  /// [1, 2, 3, 4].slice(start: 1); // [2, 3, 4]
  /// [1, 2, 3, 4].slice(end: 1, step: -1); // [4, 3]
  /// [1, 2, 3, 4].slice(start: 2, step: -1); // [3, 2, 1]
  /// ```
  ///
  /// If [start] or [end] is negative, it will be counted backwards from the
  /// last element of [this]. If [step] is negative, the elements will be
  /// returned in reverse order.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4].slice(start: -2); // [3, 4]
  /// [1, 2, 3, 4].slice(end: -1); // [1, 2, 3]
  /// [1, 2, 3, 4].slice(step: -1); // [4, 3, 2, 1]
  /// ```
  ///
  /// Any out-of-range values for [start] or [end] will be truncated to the
  /// maximum in-range value in that direction.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4].slice(start: -100); // [1, 2, 3, 4]
  /// [1, 2, 3, 4].slice(end: 100); // [1, 2, 3, 4]
  /// ```
  ///
  /// Will return an empty list if [start] and [end] are equal, [start] is
  /// greater than [end] while [step] is positive, or [end] is greater than
  /// [start] while [step] is negative.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4].slice(start: 1, end: -3); // []
  /// [1, 2, 3, 4].slice(start: 3, end: 1); // []
  /// [1, 2, 3, 4].slice(start: 1, end: 3, step: -1); // []
  /// ```
  List<E> slice({int? start, int? end, int step = 1}) {
    final indices = sliceIndices(start, end, step, this.length);
    if (indices == null) {
      return <E>[];
    }

    final _start = indices.start;
    final _end = indices.end;
    final slice = <E>[];

    if (step > 0) {
      for (var i = _start; i < _end; i += step) {
        slice.add(this[i]);
      }
    } else {
      for (var i = _start; i > _end; i += step) {
        slice.add(this[i]);
      }
    }
    return slice;
  }

  /// Returns a sorted copy of this list.
  List<E> sortedCopy() {
    return List<E>.of(this)..sort();
  }

  /// Sorts this list by the value returned by [sortKey] for each element.
  ///
  /// Example:
  /// ```dart
  /// var list = [-12, 3, 10];
  /// list.sortBy((e) => e.toString().length); // list is now [3, 10, -12].
  /// ```
  void sortBy(Comparable Function(E) sortKey) {
    final sortKeyCache = <E, Comparable>{};
    this.sort((a, b) => sortKeyCompare(a, b, sortKey, sortKeyCache));
  }

  /// Returns a copy of this list sorted by the value returned by [sortKey] for
  /// each element.
  ///
  /// Example:
  /// ```dart
  /// var list = [-12, 3, 10];
  /// var sorted = list.sortedCopyBy((e) => e.toString().length);
  /// // list is still [-12, 3, 10]. sorted is [3, 10, -12].
  /// ```
  List<E> sortedCopyBy(Comparable Function(E) sortKey) {
    return List<E>.of(this)..sortBy(sortKey);
  }

  /// Removes a random element of [this] and returns it.
  ///
  /// Returns [null] if [this] is empty.
  ///
  /// If [seed] is provided, will be used as the random seed for determining
  /// which element to select. (See [math.Random].)
  E? takeRandom({int? seed}) => this.isEmpty
      ? null
      : this.removeAt(math.Random(seed).nextInt(this.length));
}
