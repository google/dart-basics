// Copyright (c) 2020, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// Utility extension methods for the core [DateTime] class.
extension DateTimeBasics on DateTime {
  /// Returns true if [this] occurs strictly before [other], accounting for time
  /// zones.
  ///
  /// Alias for [DateTime.isBefore].
  ///
  /// Note that attempting to use this operator with [DateTime.==] will likely
  /// give undesirable results. This operator compares moments (i.e. with time
  /// zone taken into account), while [DateTime.==] compares field values (i.e.
  /// two [DateTime]s representing the same moment in different time zones will
  /// be treated as not equal). To check moment equality with time zone taken
  /// into account, use [DateTime.isAtSameMomentAs] rather than [DateTime.==].
  bool operator <(DateTime other) => isBefore(other);

  /// Returns true if [this] occurs strictly after [other], accounting for time
  /// zones.
  ///
  /// Alias for [DateTime.isAfter].
  ///
  /// Note that attempting to use this operator with [DateTime.==] will likely
  /// give undesirable results. This operator compares moments (i.e. with time
  /// zone taken into account), while [DateTime.==] compares field values (i.e.
  /// two [DateTime]s representing the same moment in different time zones will
  /// be treated as not equal). To check moment equality with time zone taken
  /// into account, use [DateTime.isAtSameMomentAs] rather than [DateTime.==].
  bool operator >(DateTime other) => isAfter(other);

  /// Returns true if [this] occurs at or before [other], accounting for time
  /// zones.
  ///
  /// Alias for [isAtOrBefore].
  ///
  /// Note that attempting to use this operator with [DateTime.==] will likely
  /// give undesirable results. This operator compares moments (i.e. with time
  /// zone taken into account), while [DateTime.==] compares field values (i.e.
  /// two [DateTime]s representing the same moment in different time zones will
  /// be treated as not equal). To check moment equality with time zone taken
  /// into account, use [DateTime.isAtSameMomentAs] rather than [DateTime.==].
  bool operator <=(DateTime other) => isAtOrBefore(other);

  /// Returns true if [this] occurs at or after [other], accounting for time
  /// zones.
  ///
  /// Alias for [isAtOrAfter].
  ///
  /// Note that attempting to use this operator with [DateTime.==] will likely
  /// give undesirable results. This operator compares moments (i.e. with time
  /// zone taken into account), while [DateTime.==] compares field values (i.e.
  /// two [DateTime]s representing the same moment in different time zones will
  /// be treated as not equal). To check moment equality with time zone taken
  /// into account, use [DateTime.isAtSameMomentAs] rather than [DateTime.==].
  bool operator >=(DateTime other) => isAtOrAfter(other);

  /// Returns a new [DateTime] instance with [duration] added to [this].
  ///
  /// Alias for [DateTime.add].
  DateTime operator +(Duration duration) => add(duration);

  /// Returns the [Duration] between [this] and [other].
  ///
  /// The returned [Duration] will be negative if [other] occurs after [this].
  ///
  /// Alias for [DateTime.difference].
  Duration operator -(DateTime other) => difference(other);

  /// Returns true if [this] occurs at or before [other], accounting for time
  /// zones.
  ///
  /// Delegates to [DateTime]'s built-in comparison methods and therefore obeys
  /// the same contract.
  bool isAtOrBefore(DateTime other) =>
      isAtSameMomentAs(other) || isBefore(other);

  /// Returns true if [this] occurs at or after [other], accounting for time
  /// zones.
  ///
  /// Delegates to [DateTime]'s built-in comparison methods and therefore obeys
  /// the same contract.
  bool isAtOrAfter(DateTime other) => isAtSameMomentAs(other) || isAfter(other);
}
