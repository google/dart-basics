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
}
