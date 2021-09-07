// Copyright (c) 2020, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// Utility extension methods for the core [DateTime] class.
extension DateTimeBasics on DateTime {
  /// Returns true if [this] occurs strictly before [other], accounting for time
  /// zones.
  ///
  /// Alias for [DateTime.isBefore].
  bool operator <(DateTime other) => isBefore(other);

  /// Returns true if [this] occurs strictly after [other], accounting for time
  /// zones.
  ///
  /// Alias for [DateTime.isAfter].
  bool operator >(DateTime other) => isAfter(other);

  /// Returns true if [this] occurs at or before [other], accounting for time
  /// zones.
  ///
  /// Alias for [isAtOrBefore].
  bool operator <=(DateTime other) => isAtOrBefore(other);

  /// Returns true if [this] occurs at or after [other], accounting for time
  /// zones.
  ///
  /// Alias for [isAtOrAfter].
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

  /// Copies a [DateTime], overriding specified values.
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return this.isUtc
        ? DateTime.utc(
            year ?? this.year,
            month ?? this.month,
            day ?? this.day,
            hour ?? this.hour,
            minute ?? this.minute,
            second ?? this.second,
            millisecond ?? this.millisecond,
            microsecond ?? this.microsecond,
          )
        : DateTime(
            year ?? this.year,
            month ?? this.month,
            day ?? this.day,
            hour ?? this.hour,
            minute ?? this.minute,
            second ?? this.second,
            millisecond ?? this.millisecond,
            microsecond ?? this.microsecond,
          );
  }

  /// Adds a specified number of days to this [DateTime].
  ///
  /// Unlike `DateTime.add(Duration(days: numberOfDays))`, this adds calendar
  /// days and not 24-hour increments.  When possible, it therefore leaves the
  /// time of day unchanged if a DST change would occur during the time
  /// interval. (The returned time can still be different from the original if
  /// it's valid for the returned date.)
  DateTime addCalendarDays(int numberOfDays) =>
      copyWith(day: day + numberOfDays);
}
