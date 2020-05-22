// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:basics/basics.dart';
import 'package:test/test.dart';

void main() {
  group('range', () {
    test('returns iterable of provided length', () {
      expect(5.range.toList(), [0, 1, 2, 3, 4]);
    });

    test('returns empty iterable when called on 0', () {
      expect(0.range.isEmpty, isTrue);
    });

    test('returns empty iterable when called on negative numbers', () {
      expect((-5).range.isEmpty, isTrue);
    });
  });

  group('to', () {
    test('returns iterable from a lesser to a greater value', () {
      expect(3.to(6).toList(), [3, 4, 5]);
    });

    test('returns iterable from a greater to a lesser value', () {
      expect(6.to(4).toList(), [6, 5]);
    });

    test('returns iterable from a lesser to a greater value by step', () {
      expect(3.to(10, by: 3).toList(), [3, 6, 9]);
    });

    test('returns iterable from a greater to a lesser value by step', () {
      expect(8.to(2, by: 2).toList(), [8, 6, 4]);
    });

    test('works with a negative start', () {
      expect((-3).to(1).toList(), [-3, -2, -1, 0]);
    });

    test('works with a negative end', () {
      expect((1).to(-2).toList(), [1, 0, -1]);
    });

    test('works with a negative start and negative end', () {
      expect((-4).to(-1).toList(), [-4, -3, -2]);
    });

    test('returns an empty iterable when start and end are equal', () {
      expect(4.to(4).isEmpty, isTrue);
    });
  });

  group('$DateTime constructors', () {
    test('create proper durations with positive values', () {
      expect(5.days, Duration(days: 5));
      expect(5.hours, Duration(hours: 5));
      expect(5.minutes, Duration(minutes: 5));
      expect(5.seconds, Duration(seconds: 5));
      expect(5.milliseconds, Duration(milliseconds: 5));
      expect(5.microseconds, Duration(microseconds: 5));
    });

    test('create proper durations with 0 values', () {
      expect(0.days, Duration(days: 0));
      expect(0.hours, Duration(hours: 0));
      expect(0.minutes, Duration(minutes: 0));
      expect(0.seconds, Duration(seconds: 0));
      expect(0.milliseconds, Duration(milliseconds: 0));
      expect(0.microseconds, Duration(microseconds: 0));
    });

    test('create proper durations with negative values', () {
      expect((-5).days, Duration(days: -5));
      expect((-5).hours, Duration(hours: -5));
      expect((-5).minutes, Duration(minutes: -5));
      expect((-5).seconds, Duration(seconds: -5));
      expect((-5).milliseconds, Duration(milliseconds: -5));
      expect((-5).microseconds, Duration(microseconds: -5));
    });
  });
}
