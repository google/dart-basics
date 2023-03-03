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

  test('calendarDayTo works', () {
    expect(DateTime(2020, 12, 31).calendarDaysTill(2021, 1, 1), 1);
    expect(DateTime(2020, 12, 31, 23, 59).calendarDaysTill(2021, 1, 1), 1);
    expect(DateTime(2021, 1, 1).calendarDaysTill(2020, 12, 31), -1);

    expect(DateTime(2021, 3, 1).calendarDaysTill(2021, 5, 1), 31 + 30);
    expect(DateTime(2021, 10, 1).calendarDaysTill(2021, 12, 1), 31 + 30);

    expect(DateTime.utc(2020, 12, 31).calendarDaysTill(2021, 1, 1), 1);
    expect(DateTime.utc(2020, 12, 31, 23, 59).calendarDaysTill(2021, 1, 1), 1);
    expect(DateTime.utc(2021, 1, 1).calendarDaysTill(2020, 12, 31), -1);

    expect(DateTime.utc(2021, 3, 1).calendarDaysTill(2021, 5, 1), 31 + 30);
    expect(DateTime.utc(2021, 10, 1).calendarDaysTill(2021, 12, 1), 31 + 30);
  });

  group('addCalendarDays:', () {
    // Pick an hour that is likely to always be valid.
    final startDate = DateTime(2020, 1, 1, 12, 34, 56);

    const daysInYear = 366; // `startDate` is in a leap year.

    test('Adds the correct number of days', () {
      for (var i = 0; i <= daysInYear; i += 1) {
        var futureDate = startDate.addCalendarDays(i);
        expect(
          startDate.calendarDaysTill(
              futureDate.year, futureDate.month, futureDate.day),
          i,
        );
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
