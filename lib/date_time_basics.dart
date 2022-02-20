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
  ///
  /// A UTC [DateTime] will remain in UTC; a local [DateTime] will remain local.
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
    return (isUtc ? DateTime.utc : DateTime.new)(
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

  /// Returns the number of calendar days to the specified date.
  ///
  /// Returns a negative value if the specified date is in the past.  Ignores
  /// the time of day.
  ///
  /// Example:
  /// ```
  /// DateTime(2020, 12, 31).calendarDaysTo(2021, 1, 1); // 1
  /// DateTime(2020, 12, 31, 23, 59).calendarDaysTo(2021, 1, 1); // 1
  /// ```
  ///
  /// This function intentionally does not take a [DateTime] argument to:
  /// * More clearly indicate that it does not take time of day into account.
  /// * Avoid potential problems if one [DateTime] is in UTC and the other is
  ///   not.
  int calendarDaysTo(int year, int month, int day) {
    // Discard the time of day, and perform all calculations in UTC so that
    // Daylight Saving Time adjustments are not a factor.
    //
    // Note that this intentionally isn't the same as `toUtc()`; we instead
    // want to treat this `DateTime` object *as* a UTC `DateTime`.
    final startDay = DateTime.utc(this.year, this.month, this.day);
    final endDay = DateTime.utc(year, month, day);
    return (endDay - startDay).inDays;
  }
}
