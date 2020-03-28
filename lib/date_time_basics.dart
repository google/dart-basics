// Copyright (c) 2020, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// Utility extension methods for the core [DateTime] class.
extension DateTimeBasics on DateTime {
  /// Returns true if [this] occurs strictly before [other].
  bool operator <(DateTime other) => compareTo(other) < 0;

  /// Returns true if [this] occurs strictly after [other].
  bool operator >(DateTime other) => compareTo(other) > 0;

  /// Returns true if [this] occurs on or before [other].
  bool operator <=(DateTime other) => compareTo(other) <= 0;

  /// Returns true if [this] occurs on or after [other].
  bool operator >=(DateTime other) => compareTo(other) >= 0;

  /// Returns a new [DateTime] instance with [duration] added to [this].
  ///
  /// See [DateTime.add].
  DateTime operator +(Duration duration) => this.add(duration);

  /// Returns the [Duration] between [this] and [other].
  ///
  /// The returned [Duration] will be negative if [other] occurs after [this].
  ///
  /// See [DateTime.difference].
  Duration operator -(DateTime other) => this.difference(other);
}
