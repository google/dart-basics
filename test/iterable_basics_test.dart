// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:basics/basics.dart';
import 'package:test/test.dart';

void main() {
  group('none', () {
    test('returns true when no elements satisfy test', () {
      final nums = [1, 4, 8, 3];
      final result = nums.none((n) => n < 0);
      expect(result, isTrue);
    });

    test('returns false when any element satisfies test', () {
      final strings = ['aa', 'bb', 'ccc', 'dd'];
      final result = strings.none((s) => s.length > 2);
      expect(result, isFalse);
    });

    test('returns true for an empty iterable', () {
      final empty = <Object>[];
      final result = empty.none((e) => e.toString() == 'foo');
      expect(result, isTrue);
    });
  });

  group('one', () {
    test('returns true when exactly one element satisfies test', () {
      final strings = ['aa', 'bb', 'ccc', 'dd'];
      final result = strings.one((s) => s.length == 3);
      expect(result, isTrue);
    });

    test('returns false when no elements satisfy test', () {
      final nums = [1, 4, 8, 3];
      final result = nums.one((n) => n < 0);
      expect(result, isFalse);
    });

    test('returns false when more than one element satisfies test', () {
      final nums = [1, 4, 8, 3];
      final result = nums.one((n) => n > 2);
      expect(result, isFalse);
    });

    test('returns false for an empty iterable', () {
      final empty = <Object>[];
      final result = empty.one((e) => e.toString() == 'foo');
      expect(result, isFalse);
    });
  });

  group('containsAny', () {
    test('returns true when exactly one element overlaps', () {
      final strings1 = ['a', 'b', 'c'];
      final strings2 = ['c', 'd', 'e'];

      expect(strings1.containsAny(strings2), isTrue);
      expect(strings2.containsAny(strings1), isTrue);
    });

    test('returns true when more than one element overlaps', () {
      final strings1 = ['a', 'b', 'c'];
      final strings2 = ['b', 'c', 'd'];

      expect(strings1.containsAny(strings2), isTrue);
      expect(strings2.containsAny(strings1), isTrue);
    });

    test('returns true when all elements overlap', () {
      final strings1 = ['a', 'b', 'c'];
      final strings2 = ['a', 'b', 'c'];

      expect(strings1.containsAny(strings2), isTrue);
      expect(strings2.containsAny(strings1), isTrue);
    });

    test('returns false when no elements match', () {
      final nums1 = [1, 2, 3];
      final nums2 = [4, 5, 6];

      expect(nums1.containsAny(nums2), isFalse);
      expect(nums2.containsAny(nums1), isFalse);
    });

    test('returns false for one empty iterable', () {
      final empty = <int>[];
      final nonEmpty = [1, 2, 3];

      expect(empty.containsAny(nonEmpty), isFalse);
      expect(nonEmpty.containsAny(empty), isFalse);
    });

    test('returns false for two empty iterables', () {
      final empty1 = <Object>[];
      final empty2 = <Object>[];

      expect(empty1.containsAny(empty2), isFalse);
      expect(empty2.containsAny(empty1), isFalse);
    });
  });

  group('containsAll', () {
    test('returns true when all elements match', () {
      final strings1 = ['a', 'b', 'c'];
      final strings2 = ['a', 'b', 'c'];

      expect(strings1.containsAll(strings2), isTrue);
      expect(strings2.containsAll(strings1), isTrue);
    });

    test('returns true when second list is a subset of the first', () {
      final strings1 = ['a', 'b', 'c', 'd', 'e'];
      final strings2 = ['a', 'b', 'c'];

      expect(strings1.containsAll(strings2), isTrue);
    });

    test('returns false when no elements match', () {
      final nums1 = [1, 2, 3];
      final nums2 = [4, 5, 6];

      expect(nums1.containsAll(nums2), isFalse);
    });

    test('returns false when only one element overlaps', () {
      final strings1 = ['a', 'b', 'c'];
      final strings2 = ['c', 'd', 'e'];

      expect(strings1.containsAll(strings2), isFalse);
    });

    test('returns true for empty iterable as argument', () {
      final empty = <int>[];
      final nonEmpty = [1, 2, 3];

      expect(nonEmpty.containsAll(empty), isTrue);
    });

    test('returns false when called on empty iterable', () {
      final empty = <int>[];
      final nonEmpty = [1, 2, 3];

      expect(empty.containsAll(nonEmpty), isFalse);
    });

    test('returns true for two empty iterables', () {
      final empty1 = <Object>[];
      final empty2 = <Object>[];

      expect(empty1.containsAll(empty2), isTrue);
    });

    test('collapses duplicates by default', () {
      final nums1 = [1, 2, 3];
      final nums2 = [1, 1, 1, 1, 1, 1, 2];

      expect(nums1.containsAll(nums2), isTrue);
    });

    test('does not collapse duplicates when collapseDuplicates is false', () {
      final nums1 = [1, 2, 3];
      final nums2 = [1, 1, 1, 1, 1, 1, 2];

      expect(nums1.containsAll(nums2, collapseDuplicates: false), isFalse);
    });

    test(
        'returns false when duplicates are not collapsed and other iterable '
        'contains more occurrences of an element than this iterable', () {
      final nums1 = [1, 2, 3, 4, 5];
      final nums2 = [1, 1, 1];

      expect(nums1.containsAll(nums2, collapseDuplicates: false), isFalse);
    });

    test('returns true when duplicates are not collapsed and have equal counts',
        () {
      final nums1 = [1, 1, 1, 2, 2, 3, 4, 5];
      final nums2 = [1, 1, 1, 2, 2, 3];

      expect(nums1.containsAll(nums2, collapseDuplicates: false), isTrue);
    });

    test(
        'returns false when duplicates are not collapsed and there are no '
        'overlapping elements', () {
      final nums1 = [1];
      final nums2 = [2];

      expect(nums1.containsAll(nums2, collapseDuplicates: false), isFalse);
    });
  });

  group('max', () {
    test('works with custom comparator', () {
      final strings = <String>['a', 'aaa', 'aa'];

      expect(
          strings.max((a, b) => a.length.compareTo(b.length))!, equals('aaa'));
    });

    test('works on sets', () {
      final strings = <String>{'a', 'aaa', 'aa'};

      expect(
          strings.max((a, b) => a.length.compareTo(b.length))!, equals('aaa'));
    });

    test('returns the first result when multiple elements match', () {
      final strings = <String>{'a', 'aaa', 'bbb'};

      expect(
          strings.max((a, b) => a.length.compareTo(b.length))!, equals('aaa'));
    });

    test('works on dynamic list with custom comparator', () {
      final items = [1, 'aaa', 2.0];

      expect(items.max((a, b) => _getItemSize(a).compareTo(_getItemSize(b)))!,
          equals('aaa'));

      items.add(5.0);
      expect(items.max((a, b) => _getItemSize(a).compareTo(_getItemSize(b)))!,
          equals(5.0));
    });

    test('returns null for empty iterable', () {
      final emptyInts = <int>[];
      final emptyStrings = <String>{};

      expect(emptyInts.max(), isNull);
      expect(emptyInts.max((a, b) => a.compareTo(b)), isNull);
      expect(emptyStrings.max((a, b) => a.length.compareTo(b.length)), isNull);
    });
  });

  group('max on Iterable of nums', () {
    test('returns largest int', () {
      final nums = <int>[1, 2, 3];

      expect(nums.max()!, equals(3));
    });

    test('returns largest double', () {
      final nums = <double>[1.0, 2.0, 3.0];

      expect(nums.max()!, equals(3.0));
    });

    test('returns largest num', () {
      final nums = <num>[1, 2.5, 3];

      expect(nums.max()!, equals(3));
    });

    test('returns smallest double with custom comparator', () {
      final nums = <double>[1.0, 2.5, 3.0];

      expect(nums.max((a, b) => b.compareTo(a))!, equals(1.0));
    });
  });

  group('min', () {
    test('works with custom comparator', () {
      final strings = <String>['a', 'aaa', 'aa'];

      expect(strings.min((a, b) => a.length.compareTo(b.length))!, equals('a'));
    });

    test('works on sets', () {
      final strings = <String>{'a', 'aaa', 'aa'};

      expect(strings.min((a, b) => a.length.compareTo(b.length))!, equals('a'));
    });

    test('returns the first result when multiple elements match', () {
      final strings = <String>{'a', 'aaa', 'b'};

      expect(strings.min((a, b) => a.length.compareTo(b.length))!, equals('a'));
    });

    test('works on dynamic list with custom comparator', () {
      final items = [1, 'aaa', 2.0];

      expect(items.min((a, b) => _getItemSize(a).compareTo(_getItemSize(b)))!,
          equals(1));

      items.add(0.5);
      expect(items.min((a, b) => _getItemSize(a).compareTo(_getItemSize(b)))!,
          equals(0.5));
    });

    test('returns null for empty iterable', () {
      final emptyInts = <int>[];
      final emptyStrings = <String>{};

      expect(emptyInts.min(), isNull);
      expect(emptyInts.min((a, b) => a.compareTo(b)), isNull);
      expect(emptyStrings.min((a, b) => a.length.compareTo(b.length)), isNull);
    });
  });

  group('min on Iterable of nums', () {
    test('returns smallest int', () {
      final nums = <int>[1, 2, 3];

      expect(nums.min()!, equals(1));
    });

    test('returns smallest double', () {
      final nums = <double>[1.0, 2.0, 3.0];

      expect(nums.min()!, equals(1.0));
    });

    test('returns smallest num', () {
      final nums = <num>[1, 2.5, 3];

      expect(nums.min()!, equals(1));
    });

    test('returns largest double with custom comparator', () {
      final nums = <double>[1.0, 2.5, 3.0];

      expect(nums.min((a, b) => b.compareTo(a))!, equals(3.0));
    });
  });

  group('maxBy', () {
    test('returns the max value according to provided sort key', () {
      final list = [3, 222, 11];
      expect(list.maxBy((e) => e.toString().length)!, 222);
      expect(list.maxBy((e) => e.toString())!, 3);
    });

    test('works on sets', () {
      final values = {3, 222, 11};
      expect(values.maxBy((e) => e.toString().length)!, 222);
      expect(values.maxBy((e) => e.toString())!, 3);
    });

    test('returns null for empty iterable', () {
      final emptyInts = <int>[];
      final emptyStrings = <String>{};

      expect(emptyInts.maxBy((a) => a.toString().length), isNull);
      expect(emptyStrings.maxBy((a) => a.length), isNull);
    });

    test('does not calculate any sort key more than once', () {
      final values = [3, 222, 3, 15, 18];

      final callCounts = <int, int>{};
      int recordCallAndReturn(int e) {
        callCounts.update(e, (value) => value++, ifAbsent: () => 1);
        return e;
      }

      final result = values.maxBy((e) => recordCallAndReturn(e));

      expect(result, 222);
      expect(callCounts.length, values.toSet().length);
      expect(callCounts.keys.toSet(), values.toSet());
      expect(callCounts.values.every((e) => e == 1), isTrue);
    });
  });

  group('minBy', () {
    test('returns the min value according to provided sort key', () {
      final list = [3, 222, 11];
      expect(list.minBy((e) => e.toString().length)!, 3);
      expect(list.minBy((e) => e.toString())!, 11);
    });

    test('works on sets', () {
      final values = {3, 222, 11};
      expect(values.minBy((e) => e.toString().length)!, 3);
      expect(values.minBy((e) => e.toString())!, 11);
    });

    test('returns null for empty iterable', () {
      final emptyInts = <int>[];
      final emptyStrings = <String>{};

      expect(emptyInts.minBy((a) => a.toString().length), isNull);
      expect(emptyStrings.minBy((a) => a.length), isNull);
    });

    test('does not calculate any sort key more than once', () {
      final values = [3, 222, 3, 15, 18];

      final callCounts = <int, int>{};
      int recordCallAndReturn(int e) {
        callCounts.update(e, (value) => value++, ifAbsent: () => 1);
        return e;
      }

      final result = values.minBy((e) => recordCallAndReturn(e));

      expect(result, 3);
      expect(callCounts.length, values.toSet().length);
      expect(callCounts.keys.toSet(), values.toSet());
      expect(callCounts.values.every((e) => e == 1), isTrue);
    });
  });

  group('sum', () {
    test('returns sum on list of numbers', () {
      final nums = [1.5, 2, 3];
      final ints = [2, 3, 4];

      expect(nums.sum(), 6.5);
      expect(nums.sum((n) => n * 2), 13);
      expect(ints.sum((n) => n * 0.5), 4.5);
    });

    test('returns 0 on empty lists', () {
      expect(<int>[].sum(), 0);
      expect(<double>[].sum(), 0);
      expect(<num>[].sum((n) => n * 2), 0);
      expect(<String>[].sum((s) => s.length), 0);
      expect(<int>[].sum((n) => n * 2), 0);
    });

    test('returns sum of custom addend', () {
      final strings = ['a', 'aa', 'aaa'];

      expect(strings.sum((s) => s.length), 6);
    });

    test('works on sets', () {
      final strings = {'a', 'aa', 'aaa'};

      expect(strings.sum((s) => s.length), 6);
    });

    test('works on dynamic list with custom addend', () {
      final items = [1, 'aaa', 2.0];

      expect(items.sum((a) => _getItemSize(a)), equals(6));

      items.add(0.5);
      expect(items.sum((a) => _getItemSize(a)), equals(6.5));
    });
  });

  group('getRandom', () {
    test('returns null for an empty iterable', () {
      expect(<int>[].getRandom(), isNull);
    });

    test('returns the only value of an iterable of length 1', () {
      expect(['a'].getRandom(), 'a');
    });

    test('returns a fixed element when a seed is provided', () {
      expect(['a', 'b', 'c', 'd'].getRandom(seed: 45), 'c');
    });
  });

  group('getRange', () {
    test('returns a range from an iterable', () {
      final values = {3, 8, 12, 4, 1};
      expect(values.getRange(2, 4), [12, 4]);
      expect(values.getRange(0, 2), [3, 8]);
      expect(values.getRange(3, 5), [4, 1]);
      expect(values.getRange(3, 3), <int>[]);
      expect(values.getRange(5, 5), <int>[]);
    });

    test('matches the behavior of List#getRange', () {
      final iterableValues = {3, 8, 12, 4, 1};
      final listValues = [3, 8, 12, 4, 1];
      expect(iterableValues.getRange(2, 4), listValues.getRange(2, 4));
      expect(iterableValues.getRange(0, 2), listValues.getRange(0, 2));
      expect(iterableValues.getRange(3, 5), listValues.getRange(3, 5));
      expect(iterableValues.getRange(3, 3), listValues.getRange(3, 3));
      expect(iterableValues.getRange(5, 5), listValues.getRange(5, 5));
    });

    test('throws error when start > number of elements', () {
      final values = {3, 8, 12, 4, 1};
      expect(() => values.getRange(6, 7), throwsRangeError);
    });

    test('matches List#getRange when start > number of elements', () {
      final iterableValues = {3, 8, 12, 4, 1};
      final listValues = [3, 8, 12, 4, 1];
      final iterableError = _getRangeError(() => iterableValues.getRange(6, 7));
      final listError = _getRangeError(() => listValues.getRange(6, 7));
      _expectRangeErrorMatches(iterableError, listError);
    });

    test('throws error when end > number of elements', () {
      final values = {3, 8, 12, 4, 1};
      expect(() => values.getRange(4, 8), throwsRangeError);
    });

    test('matches List#getRange when end > number of elements', () {
      final iterableValues = {3, 8, 12, 4, 1};
      final listValues = [3, 8, 12, 4, 1];
      final iterableError = _getRangeError(() => iterableValues.getRange(4, 8));
      final listError = _getRangeError(() => listValues.getRange(4, 8));
      _expectRangeErrorMatches(iterableError, listError);
    });
  });
}

num _getItemSize(dynamic item) {
  if (item is num) return item;
  if (item is String) return item.length;
  throw UnimplementedError();
}

RangeError _getRangeError(Iterable<Object?> Function() f) {
  try {
    f();
  } on RangeError catch (e) {
    return e;
  }
  throw AssertionError("Expected RangeError but none was thrown");
}

void _expectRangeErrorMatches(RangeError actual, RangeError expected) {
  expect(actual.start, expected.start);
  expect(actual.end, expected.end);
  expect(actual.name, expected.name);
  expect(actual.message, expected.message);
}
