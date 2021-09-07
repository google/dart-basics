// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:basics/date_time_basics.dart';
import 'package:test/test.dart';

void main() {
  final utcTime = DateTime.utc(2020, 3, 27, 13, 40, 56);
  final utcTimeAfter = DateTime.utc(2020, 3, 27, 13, 40, 57);

  final localTime = utcTime.toLocal();

  group('comparison operators:', () {
    test('DateTime < DateTime works', () {
      expect(utcTime < utcTime, false);
      expect(utcTime < utcTimeAfter, true);
      expect(utcTimeAfter < utcTime, false);

      expect(localTime < utcTime, false);
      expect(localTime < utcTimeAfter, true);
    });

    test('DateTime > DateTime works', () {
      expect(utcTime > utcTime, false);
      expect(utcTime > utcTimeAfter, false);
      expect(utcTimeAfter > utcTime, true);

      expect(localTime > utcTime, false);
      expect(utcTimeAfter > localTime, true);
    });

    test('DateTime <= DateTime works', () {
      expect(utcTime <= utcTime, true);
      expect(utcTime <= utcTimeAfter, true);
      expect(utcTimeAfter <= utcTime, false);

      expect(localTime <= utcTime, true);
      expect(localTime <= utcTimeAfter, true);
    });

    test('DateTime >= DateTime works', () {
      expect(utcTime >= utcTime, true);
      expect(utcTime >= utcTimeAfter, false);
      expect(utcTimeAfter >= utcTime, true);

      expect(localTime >= utcTime, true);
      expect(utcTimeAfter >= localTime, true);
    });
  });

  group('arithmetic operators:', () {
    test('DateTime + Duration works', () {
      expect(utcTime + Duration(seconds: 1), utcTimeAfter);
      expect((localTime + Duration(seconds: 1)).toUtc(), utcTimeAfter);

      expect(utcTimeAfter + -Duration(seconds: 1), utcTime);
    });

    test('DateTime - DateTime works', () {
      expect(utcTimeAfter - utcTime, Duration(seconds: 1));
      expect(utcTime - utcTimeAfter, -Duration(seconds: 1));
      expect(utcTimeAfter - localTime, Duration(seconds: 1));
    });
  });

  group('isAtOrBefore', () {
    test('works as expected', () {
      expect(utcTime.isAtOrBefore(utcTime), true);
      expect(utcTime.isAtOrBefore(utcTimeAfter), true);
      expect(utcTimeAfter.isAtOrBefore(utcTime), false);

      expect(localTime.isAtOrBefore(utcTime), true);
      expect(localTime.isAtOrBefore(utcTimeAfter), true);
    });
  });

  group('isAtOrAfter', () {
    test('works as expected', () {
      expect(utcTime.isAtOrAfter(utcTime), true);
      expect(utcTime.isAtOrAfter(utcTimeAfter), false);
      expect(utcTimeAfter.isAtOrAfter(utcTime), true);

      expect(localTime.isAtOrAfter(utcTime), true);
      expect(utcTimeAfter.isAtOrAfter(localTime), true);
    });
  });

  group('copyWith:', () {
    test('Copies existing values', () {
      var copy = utcTime.copyWith();
      expect(utcTime, isNot(same(copy)));
      expect(utcTime, copy);

      copy = localTime.copyWith();
      expect(localTime, isNot(same(copy)));
      expect(localTime, copy);
    });

    test('Overrides existing values', () {
      final utcOverrides = DateTime.utc(2000, 1, 2, 3, 4, 5, 6, 7);
      final localOverrides = utcOverrides.toLocal();

      var copy = utcTime.copyWith(
        year: utcOverrides.year,
        month: utcOverrides.month,
        day: utcOverrides.day,
        hour: utcOverrides.hour,
        minute: utcOverrides.minute,
        second: utcOverrides.second,
        millisecond: utcOverrides.millisecond,
        microsecond: utcOverrides.microsecond,
      );
      expect(copy, utcOverrides);

      copy = localTime.copyWith(
        year: localOverrides.year,
        month: localOverrides.month,
        day: localOverrides.day,
        hour: localOverrides.hour,
        minute: localOverrides.minute,
        second: localOverrides.second,
        millisecond: localOverrides.millisecond,
        microsecond: localOverrides.microsecond,
      );
      expect(copy, localOverrides);
    });
  });

  group('addCalendarDays:', () {
    // Pick an hour that is likely to always be valid.
    final startDate = DateTime(2020, 1, 1, 12, 34, 56);

    const daysInYear = 366; // `startDate` is in a leap year.

    const paddingHours = Duration(hours: 6);

    test('Adds the correct number of days', () {
      for (var i = 0; i <= daysInYear; i += 1) {
        var futureDate = startDate.addCalendarDays(i);

        // [Duration.inDays] returns the number of whole days (as 24-hour
        // periods), rounded down.  Add a few hours before rounding down since
        // `futureDate - startDate` might be less than 24 hours during DST
        // changes.
        expect((futureDate - startDate + paddingHours).inDays, i);
      }
    });

    test('Preserves time of day', () {
      for (var i = 0; i <= daysInYear; i += 1) {
        var futureDate = startDate.addCalendarDays(i);
        expect(
          [futureDate.hour, futureDate.minute, futureDate.second],
          [startDate.hour, startDate.minute, startDate.second],
        );
      }

      // This test is unfortunately dependent on the local timezone and is not
      // meaningful if the local timezone does not observe daylight saving time.
    }, skip: !_observesDaylightSaving());
  });
}

/// Tries to empirically determine if the local timezone observes daylight
/// saving time changes.
///
/// We can't control the local timezone used by [DateTime] in tests, so we have
/// to guess.
bool _observesDaylightSaving() {
  final startDate = DateTime(2020, 1, 1, 12, 0);
  var localDate = startDate.copyWith();

  const oneDay = Duration(days: 1);
  while (localDate.year < startDate.year + 1) {
    localDate = localDate.add(oneDay);
    if (localDate.hour != startDate.hour ||
        localDate.minute != startDate.minute ||
        localDate.second != startDate.second) {
      return true;
    }
  }
  return false;
}
