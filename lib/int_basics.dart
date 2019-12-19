// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// Utility extension methods for the native [int] class.
extension IntBasics on int {
  /// Returns an iterable from `0` up to but not including [this].
  ///
  /// Example:
  /// ```dart
  /// 5.range; // (0, 1, 2, 3, 4)
  /// ```
  Iterable<int> get range => Iterable<int>.generate(this);

  /// Returns an iterable from [this] inclusive to [end] exclusive.
  ///
  /// Example:
  /// ```dart
  /// 3.to(6); // (3, 4, 5)
  /// 2.to(-2); // (2, 1, 0, -1)
  /// ```
  ///
  /// If [by] is provided, it will be used as step size for iteration. [by] is
  /// always positive, even if the direction of iteration is decreasing.
  ///
  /// Example:
  /// ```dart
  /// 8.to(3, by: 2); // (8, 6, 4)
  /// ```
  Iterable<int> to(int end, {int by = 1}) {
    if (by < 1) {
      throw ArgumentError(
          'Invalid step size: $by. Step size must be greater than 0');
    }
    final count = ((end - this).abs() / by).ceil();
    // Explicit type declaration required for function argument.
    final int Function(int) generator = this >= end
        ? (index) => this - (by * index)
        : (index) => this + (by * index);
    return Iterable<int>.generate(count, generator);
  }

  /// Returns [Duration] of [this] in days.
  Duration get days => Duration(days: this);

  /// Returns [Duration] of [this] in hours.
  Duration get hours => Duration(hours: this);

  /// Returns [Duration] of [this] in minutes.
  Duration get minutes => Duration(minutes: this);

  /// Returns [Duration] of [this] in seconds.
  Duration get seconds => Duration(seconds: this);

  /// Returns [Duration] of [this] in milliseconds.
  Duration get milliseconds => Duration(milliseconds: this);

  /// Returns [Duration] of [this] in microseconds.
  Duration get microseconds => Duration(microseconds: this);
}
