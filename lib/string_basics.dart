// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'src/slice_indices.dart';

/// Utility extension methods for the native [String] class.
extension StringBasics on String {
  /// Returns a new string containing the characters of [this] from [start]
  /// inclusive to [end] exclusive, skipping by [step].
  ///
  /// Example:
  /// ```dart
  /// 'word'.slice(start: 1, end: 3); // 'or'
  /// 'word'.slice(start: 1, end: 4, step: 2); // 'od'
  /// ```
  ///
  /// [start] defaults to the first character if [step] is positive and to the
  /// last character if [step] is negative. [end] does the opposite.
  ///
  /// Example:
  /// ```dart
  /// 'word'.slice(end: 2); // 'wo'
  /// 'word'.slice(start: 1); // 'ord'
  /// 'word'.slice(end: 1, step: -1); // 'dr'
  /// 'word'.slice(start: 2, step: -1); // 'row'
  /// ```
  ///
  /// If [start] or [end] is negative, it will be counted backwards from the
  /// last character of [this]. If [step] is negative, the characters will be
  /// returned in reverse order.
  ///
  /// Example:
  /// ```dart
  /// 'word'.slice(start: -2); // 'rd'
  /// 'word'.slice(end: -1); // 'wor'
  /// 'word'.slice(step: -1); // 'drow'
  /// ```
  ///
  /// Any out-of-range values for [start] or [end] will be truncated to the
  /// maximum in-range value in that direction.
  ///
  /// Example:
  /// ```dart
  /// 'word'.slice(start: -100); // 'word'
  /// 'word'.slice(end: 100); // 'word'
  /// ```
  ///
  /// Will return an empty string if [start] and [end] are equal, [start] is
  /// greater than [end] while [step] is positive, or [end] is greater than
  /// [start] while [step] is negative.
  ///
  /// Example:
  /// ```dart
  /// 'word'.slice(start: 1, end: -3); // ''
  /// 'word'.slice(start: 3, end: 1); // ''
  /// 'word'.slice(start: 1, end: 3, step: -1); // ''
  /// ```
  String slice({int start, int end, int step = 1}) {
    final indices = sliceIndices(start, end, step, this.length);
    if (indices.isNotPresent) {
      return '';
    }

    final _start = indices.value.start;
    final _end = indices.value.end;
    final stringBuffer = StringBuffer();

    if (step > 0) {
      for (var i = _start; i < _end; i += step) {
        stringBuffer.write(this[i]);
      }
    } else {
      for (var i = _start; i > _end; i += step) {
        stringBuffer.write(this[i]);
      }
    }
    return stringBuffer.toString();
  }
}
