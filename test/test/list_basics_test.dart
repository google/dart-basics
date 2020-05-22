// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:basics/basics.dart';
import 'package:test/test.dart';

void main() {
  group('slice', () {
    test('returns the elements from start inclusive', () {
      final list = [1, 2, 3, 4];
      expect(list.slice(start: 1), [2, 3, 4]);
      expect(list.slice(start: 2, step: -2), [3, 1]);
    });

    test('returns the elements until end exclusive', () {
      final list = [1, 2, 3, 4, 5];
      expect(list.slice(end: 2), [1, 2]);
      expect(list.slice(end: 1, step: -1), [5, 4, 3]);
    });

    test('returns the elements between start and end', () {
      final list = [1, 2, 3, 4];
      expect(list.slice(start: 1, end: 3), [2, 3]);
    });

    test('skips elements by step', () {
      final list = [1, 2, 3, 4];
      expect(list.slice(step: 2), [1, 3]);
    });

    test('returns the elements between start and end by step', () {
      final list = [1, 2, 3, 4];
      expect(list.slice(start: 1, end: 4, step: 2), [2, 4]);
    });

    test('accepts steps that do not evenly divide the total number of elements',
        () {
      final list = [1, 2, 3, 4];
      expect(list.slice(step: 3), [1, 4]);
    });

    test('returns elements in reverse order when step is negative', () {
      final list = [1, 2, 3];
      expect(list.slice(step: -1), [3, 2, 1]);
    });

    test('counts a negative start index from the end of the list', () {
      final list = [1, 2, 3, 4];
      expect(list.slice(start: -2), [3, 4]);
    });

    test('counts a negative end index from the end of the list', () {
      final list = [1, 2, 3, 4, 5];
      expect(list.slice(end: -2), [1, 2, 3]);
    });

    test(
        'starts from the final element if start is greater than the length '
        'of the list', () {
      final list = [1, 2, 3, 4];
      expect(list.slice(start: 100, end: 1), []);
      expect(list.slice(start: 100, end: 1, step: -1), [4, 3]);
    });

    test(
        'ends with the final element if end is greater than the length of the '
        'list', () {
      final list = [1, 2, 3, 4, 5];
      expect(list.slice(start: 2, end: 100), [3, 4, 5]);
    });

    test(
        'starts from the first element if start is less than the negative '
        'length of the list', () {
      final list = [1, 2, 3];
      expect(list.slice(start: -100, end: 3), [1, 2, 3]);
    });

    test(
        'ends with the first element if end is less than the negative length '
        'of the list', () {
      final list = [1, 2, 3, 4];
      expect(list.slice(start: 2, end: -100), []);
      expect(list.slice(start: 2, end: -100, step: -1), [3, 2, 1]);
    });

    test('returns an empty list if start and end are equal', () {
      final list = [1, 2, 3, 4, 5];
      expect(list.slice(start: 2, end: 2), []);
      expect(list.slice(start: -2, end: -2), []);
    });

    test(
        'returns an empty list if start and end are not equal but correspond '
        'to the same element', () {
      final list = [1, 2, 3, 4];
      expect(list.slice(start: 1, end: -3), []);
      expect(list.slice(start: 2, end: -2), []);
    });

    test(
        'returns an empty list if start (or its equivalent index) is greater '
        'than end (or its equivalent index) and step is positive', () {
      final list = [1, 2, 3, 4];
      expect(list.slice(start: 3, end: 1), []);
      expect(list.slice(start: -1, end: 1), []);
      expect(list.slice(start: 3, end: -3), []);
      expect(list.slice(start: -1, end: -3), []);
      expect(list.slice(start: 3, end: -100), []);
    });

    test(
        'returns an empty list if start (or its equivalent index) is less than '
        'end (or its equivalent index) and step is negative', () {
      final list = [1, 2, 3, 4];
      expect(list.slice(start: 1, end: 3, step: -1), []);
      expect(list.slice(start: -3, end: 3, step: -1), []);
      expect(list.slice(start: 1, end: -1, step: -1), []);
      expect(list.slice(start: -3, end: -1, step: -1), []);
      expect(list.slice(start: 1, end: 100, step: -1), []);
    });

    test('behaves predictably when the bounds are increased in any direction',
        () {
      final list = [1, 2, 3, 4];

      expect(list.slice(start: 0, end: 0), []);
      expect(list.slice(start: 0, end: 1), [1]);
      expect(list.slice(start: 0, end: 2), [1, 2]);
      expect(list.slice(start: 0, end: 3), [1, 2, 3]);
      expect(list.slice(start: 0, end: 4), [1, 2, 3, 4]);
      expect(list.slice(start: 0, end: 5), [1, 2, 3, 4]);

      expect(list.slice(start: 0, end: -5), []);
      expect(list.slice(start: 0, end: -4), []);
      expect(list.slice(start: 0, end: -3), [1]);
      expect(list.slice(start: 0, end: -2), [1, 2]);
      expect(list.slice(start: 0, end: -1), [1, 2, 3]);

      expect(list.slice(start: 5, end: 4), []);
      expect(list.slice(start: 4, end: 4), []);
      expect(list.slice(start: 3, end: 4), [4]);
      expect(list.slice(start: 2, end: 4), [3, 4]);
      expect(list.slice(start: 1, end: 4), [2, 3, 4]);

      expect(list.slice(start: -1, end: 4), [4]);
      expect(list.slice(start: -2, end: 4), [3, 4]);
      expect(list.slice(start: -3, end: 4), [2, 3, 4]);
      expect(list.slice(start: -4, end: 4), [1, 2, 3, 4]);
      expect(list.slice(start: -5, end: 4), [1, 2, 3, 4]);

      expect(list.slice(start: 3, end: 3, step: -1), []);
      expect(list.slice(start: 3, end: 2, step: -1), [4]);
      expect(list.slice(start: 3, end: 1, step: -1), [4, 3]);
      expect(list.slice(start: 3, end: 0, step: -1), [4, 3, 2]);

      expect(list.slice(start: 3, end: -1, step: -1), []);
      expect(list.slice(start: 3, end: -2, step: -1), [4]);
      expect(list.slice(start: 3, end: -3, step: -1), [4, 3]);
      expect(list.slice(start: 3, end: -4, step: -1), [4, 3, 2]);
      expect(list.slice(start: 3, end: -5, step: -1), [4, 3, 2, 1]);

      expect(list.slice(start: 0, end: 0, step: -1), []);
      expect(list.slice(start: 1, end: 0, step: -1), [2]);
      expect(list.slice(start: 2, end: 0, step: -1), [3, 2]);
      expect(list.slice(start: 3, end: 0, step: -1), [4, 3, 2]);
      expect(list.slice(start: 4, end: 0, step: -1), [4, 3, 2]);
      expect(list.slice(start: 5, end: 0, step: -1), [4, 3, 2]);

      expect(list.slice(start: -1, end: 0, step: -1), [4, 3, 2]);
      expect(list.slice(start: -2, end: 0, step: -1), [3, 2]);
      expect(list.slice(start: -3, end: 0, step: -1), [2]);
      expect(list.slice(start: -4, end: 0, step: -1), []);

      expect(list.slice(start: -1, end: -5, step: -1), [4, 3, 2, 1]);
      expect(list.slice(start: -2, end: -5, step: -1), [3, 2, 1]);
      expect(list.slice(start: -3, end: -5, step: -1), [2, 1]);
      expect(list.slice(start: -4, end: -5, step: -1), [1]);
      expect(list.slice(start: -5, end: -5, step: -1), []);
    });
  });

  group('sortedCopy', () {
    test('copies and sorts the list', () {
      final original = [2, 3, 1];
      final sortedCopy = original.sortedCopy();
      expect(original, [2, 3, 1]);
      expect(sortedCopy, [1, 2, 3]);
    });
  });

  group('sortBy', () {
    test('sorts by provided sort key', () {
      final listA = [3, 222, 11];
      final listB = [3, 222, 11];

      listA.sortBy((e) => e.toString().length);
      listB.sortBy((e) => e.toString());

      expect(listA, [3, 11, 222]);
      expect(listB, [11, 222, 3]);
    });
  });

  group('sortedCopyBy', () {
    test('copies and sorts the list by provided sort key', () {
      final original = [3, 222, 11];
      final sortedCopy = original.sortedCopyBy((e) => e.toString());
      expect(original, [3, 222, 11]);
      expect(sortedCopy, [11, 222, 3]);
    });
  });
}
