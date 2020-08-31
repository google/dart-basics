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
      final empty = [];
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
      final empty = [];
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
      final empty1 = [];
      final empty2 = [];

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
      final empty1 = [];
      final empty2 = [];

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
  });

  group('sum', () {
    test('returns sum on list of numbers', () {
      final nums = [1.5, 2, 3];

      expect(nums.sum(), 6.5);
      expect(nums.sum((n) => n * 2), 13);
    });

    test('returns 0 on empty lists', () {
      expect(<num>[].sum(), 0);
      expect(<num>[].sum((n) => n * 2), 0);
      expect(<String>[].sum((s) => s.length), 0);
      expect([].sum((n) => n * 2), 0);
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
}

num _getItemSize(dynamic item) {
  if (item is num) return item;
  if (item is String) return item.length;
  throw UnimplementedError();
}
