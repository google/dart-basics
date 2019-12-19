// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:basics/basics.dart';
import 'package:test/test.dart';

void main() {
  group('slice', () {
    test('returns the characters from start inclusive', () {
      final word = 'word';
      expect(word.slice(start: 1), 'ord');
      expect(word.slice(start: 2, step: -2), 'rw');
    });

    test('returns the characters until end exclusive', () {
      final word = 'stuff';
      expect(word.slice(end: 2), 'st');
      expect(word.slice(end: 1, step: -1), 'ffu');
    });

    test('returns the characters between start and end', () {
      final word = 'word';
      expect(word.slice(start: 1, end: 3), 'or');
    });

    test('skips characters by step', () {
      final word = 'word';
      expect(word.slice(step: 2), 'wr');
    });

    test('returns the characters between start and end by step', () {
      final word = 'word';
      expect(word.slice(start: 1, end: 4, step: 2), 'od');
    });

    test(
        'accepts steps that do not evenly divide the total number of '
        'characters', () {
      final word = 'word';
      expect(word.slice(step: 3), 'wd');
    });

    test('returns characters in reverse order when step is negative', () {
      final word = 'hat';
      expect(word.slice(step: -1), 'tah');
    });

    test('counts a negative start index from the end of the string', () {
      final word = 'word';
      expect(word.slice(start: -2), 'rd');
    });

    test('counts a negative end index from the end of the string', () {
      final word = 'stuff';
      expect(word.slice(end: -2), 'stu');
    });

    test(
        'starts from the final character if start is greater than the length '
        'of the string', () {
      final word = 'word';
      expect(word.slice(start: 100, end: 1), '');
      expect(word.slice(start: 100, end: 1, step: -1), 'dr');
    });

    test(
        'ends with the final character if end is greater than the length of '
        'the string', () {
      final word = 'stuff';
      expect(word.slice(start: 2, end: 100), 'uff');
    });

    test(
        'starts from the first character if start is less than the negative '
        'length of the string', () {
      final word = 'hat';
      expect(word.slice(start: -100, end: 3), 'hat');
    });

    test(
        'ends with the first character if end is less than the negative length '
        'of the string', () {
      final word = 'word';
      expect(word.slice(start: 2, end: -100), '');
      expect(word.slice(start: 2, end: -100, step: -1), 'row');
    });

    test('returns an empty string if start and end are equal', () {
      final word = 'stuff';
      expect(word.slice(start: 2, end: 2), '');
      expect(word.slice(start: -2, end: -2), '');
    });

    test(
        'returns an empty string if start and end are not equal but correspond '
        'to the same index', () {
      final word = 'word';
      expect(word.slice(start: 1, end: -3), '');
      expect(word.slice(start: 2, end: -2), '');
    });

    test(
        'returns an empty string if start (or its equivalent index) is greater '
        'than end (or its equivalent index) and step is positive', () {
      final word = 'word';
      expect(word.slice(start: 3, end: 1), '');
      expect(word.slice(start: -1, end: 1), '');
      expect(word.slice(start: 3, end: -3), '');
      expect(word.slice(start: -1, end: -3), '');
      expect(word.slice(start: 3, end: -100), '');
    });

    test(
        'returns an empty string if start (or its equivalent index) is less '
        'than end (or its equivalent index) and step is negative', () {
      final word = 'word';
      expect(word.slice(start: 1, end: 3, step: -1), '');
      expect(word.slice(start: -3, end: 3, step: -1), '');
      expect(word.slice(start: 1, end: -1, step: -1), '');
      expect(word.slice(start: -3, end: -1, step: -1), '');
      expect(word.slice(start: 1, end: 100, step: -1), '');
    });

    test('behaves predictably when the bounds are increased in any direction',
        () {
      final word = 'word';

      expect(word.slice(start: 0, end: 0), '');
      expect(word.slice(start: 0, end: 1), 'w');
      expect(word.slice(start: 0, end: 2), 'wo');
      expect(word.slice(start: 0, end: 3), 'wor');
      expect(word.slice(start: 0, end: 4), 'word');
      expect(word.slice(start: 0, end: 5), 'word');

      expect(word.slice(start: 0, end: -5), '');
      expect(word.slice(start: 0, end: -4), '');
      expect(word.slice(start: 0, end: -3), 'w');
      expect(word.slice(start: 0, end: -2), 'wo');
      expect(word.slice(start: 0, end: -1), 'wor');

      expect(word.slice(start: 5, end: 4), '');
      expect(word.slice(start: 4, end: 4), '');
      expect(word.slice(start: 3, end: 4), 'd');
      expect(word.slice(start: 2, end: 4), 'rd');
      expect(word.slice(start: 1, end: 4), 'ord');

      expect(word.slice(start: -1, end: 4), 'd');
      expect(word.slice(start: -2, end: 4), 'rd');
      expect(word.slice(start: -3, end: 4), 'ord');
      expect(word.slice(start: -4, end: 4), 'word');
      expect(word.slice(start: -5, end: 4), 'word');

      expect(word.slice(start: 3, end: 3, step: -1), '');
      expect(word.slice(start: 3, end: 2, step: -1), 'd');
      expect(word.slice(start: 3, end: 1, step: -1), 'dr');
      expect(word.slice(start: 3, end: 0, step: -1), 'dro');

      expect(word.slice(start: 3, end: -1, step: -1), '');
      expect(word.slice(start: 3, end: -2, step: -1), 'd');
      expect(word.slice(start: 3, end: -3, step: -1), 'dr');
      expect(word.slice(start: 3, end: -4, step: -1), 'dro');
      expect(word.slice(start: 3, end: -5, step: -1), 'drow');

      expect(word.slice(start: 0, end: 0, step: -1), '');
      expect(word.slice(start: 1, end: 0, step: -1), 'o');
      expect(word.slice(start: 2, end: 0, step: -1), 'ro');
      expect(word.slice(start: 3, end: 0, step: -1), 'dro');
      expect(word.slice(start: 4, end: 0, step: -1), 'dro');
      expect(word.slice(start: 5, end: 0, step: -1), 'dro');

      expect(word.slice(start: -1, end: 0, step: -1), 'dro');
      expect(word.slice(start: -2, end: 0, step: -1), 'ro');
      expect(word.slice(start: -3, end: 0, step: -1), 'o');
      expect(word.slice(start: -4, end: 0, step: -1), '');

      expect(word.slice(start: -1, end: -5, step: -1), 'drow');
      expect(word.slice(start: -2, end: -5, step: -1), 'row');
      expect(word.slice(start: -3, end: -5, step: -1), 'ow');
      expect(word.slice(start: -4, end: -5, step: -1), 'w');
      expect(word.slice(start: -5, end: -5, step: -1), '');
    });
  });
}
