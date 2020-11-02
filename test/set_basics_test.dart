// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:basics/basics.dart';
import 'package:test/test.dart';

void main() {
  group('isEqualTo', () {
    test('returns true if both sets contain the same elements', () {
      final values = {'a', 'b', 'c'};
      expect(values.isEqualTo({'c', 'b', 'a'}), isTrue);
    });

    test('returns false if this set is a strict subset of other set', () {
      final values = {'a', 'b', 'c'};
      expect(values.isEqualTo({'c', 'b', 'a', 'd'}), isFalse);
    });

    test('returns false if this set is a strict superset of other set', () {
      final values = {'a', 'b', 'c'};
      expect(values.isEqualTo({'c', 'b'}), isFalse);
    });

    test('returns false if other set contains elements not in this set', () {
      final values = {'a', 'b', 'c'};
      expect(values.isEqualTo({'c', 'b', 'f'}), isFalse);
    });

    test('returns false if this set is empty and other set is not', () {
      final values = <String>{};
      expect(values.isEqualTo({'c', 'b', 'a'}), isFalse);
    });

    test('returns false if other set is empty and this set is not', () {
      final values = {'a', 'b', 'c'};
      expect(values.isEqualTo(<String>{}), isFalse);
    });

    test('returns true if both sets are empty', () {
      final values = <String>{};
      expect(values.isEqualTo(<String>{}), isTrue);
    });
  });

  group('isDisjointWith', () {
    test('returns true if both sets have no elements in common', () {
      final values = {'a', 'b', 'c'};
      expect(values.isDisjointWith({'d', 'e', 'f'}), isTrue);
    });

    test('returns false if both sets have any elements in common', () {
      final values = {'a', 'b', 'c'};
      expect(values.isDisjointWith({'d', 'e', 'c'}), isFalse);
    });

    test('returns true if either set or both sets are empty', () {
      final empty = <String>{};
      final nonEmpty = {'a', 'b', 'c'};
      expect(empty.isDisjointWith(nonEmpty), isTrue);
      expect(nonEmpty.isDisjointWith(empty), isTrue);
      expect(empty.isDisjointWith(<String>{}), isTrue);
    });
  });

  group('isIntersectingWith', () {
    test('returns true if both sets have any elements in common', () {
      final values = {'a', 'b', 'c'};
      expect(values.isIntersectingWith({'d', 'e', 'c'}), isTrue);
    });

    test('returns false if both sets have no elements in common', () {
      final values = {'a', 'b', 'c'};
      expect(values.isIntersectingWith({'d', 'e', 'f'}), isFalse);
    });

    test('returns false if either set or both sets are empty', () {
      final empty = <String>{};
      final nonEmpty = {'a', 'b', 'c'};
      expect(empty.isIntersectingWith(nonEmpty), isFalse);
      expect(nonEmpty.isIntersectingWith(empty), isFalse);
      expect(empty.isIntersectingWith(<String>{}), isFalse);
    });
  });

  group('isSubsetOf', () {
    test('returns true if every element of this set is contained in other set',
        () {
      final values = {'a', 'b', 'c'};
      expect(values.isSubsetOf({'a', 'b', 'c', 'd'}), isTrue);
    });

    test('returns true if both sets are equal', () {
      final values = {'a', 'b', 'c'};
      expect(values.isSubsetOf({'a', 'b', 'c'}), isTrue);
    });

    test(
        'returns false if any element of this set is not contained in other '
        'set', () {
      final values = {'a', 'b', 'c'};
      expect(values.isSubsetOf({'a', 'b', 'f'}), isFalse);
    });

    test('returns true if this set is empty and other set is not', () {
      final values = <String>{};
      expect(values.isSubsetOf({'a', 'b', 'f'}), isTrue);
    });

    test('returns false if other set is empty and this set is not', () {
      final values = {'a', 'b', 'c'};
      expect(values.isSubsetOf(<String>{}), isFalse);
    });

    test('returns true if both sets are empty', () {
      final values = <String>{};
      expect(values.isSubsetOf(<String>{}), isTrue);
    });
  });

  group('isSupersetOf', () {
    test('returns true if every element of other set is contained in this set',
        () {
      final values = {'a', 'b', 'c'};
      expect(values.isSupersetOf({'b', 'c'}), isTrue);
    });

    test('returns true if both sets are equal', () {
      final values = {'a', 'b', 'c'};
      expect(values.isSupersetOf({'a', 'b', 'c'}), isTrue);
    });

    test(
        'returns false if any element of other set is not contained in this '
        'set', () {
      final values = {'a', 'b', 'c'};
      expect(values.isSupersetOf({'a', 'b', 'f'}), isFalse);
    });

    test('returns false if this set is empty and other set is not', () {
      final values = <String>{};
      expect(values.isSupersetOf({'a', 'b', 'f'}), isFalse);
    });

    test('returns true if other set is empty and this set is not', () {
      final values = {'a', 'b', 'c'};
      expect(values.isSupersetOf(<String>{}), isTrue);
    });

    test('returns true if both sets are empty', () {
      final values = <String>{};
      expect(values.isSupersetOf(<String>{}), isTrue);
    });
  });

  group('isStrictSubsetOf', () {
    test('returns true if every element of this set is contained in other set',
        () {
      final values = {'a', 'b', 'c'};
      expect(values.isStrictSubsetOf({'a', 'b', 'c', 'd'}), isTrue);
    });

    test('returns false if both sets are equal', () {
      final values = {'a', 'b', 'c'};
      expect(values.isStrictSubsetOf({'a', 'b', 'c'}), isFalse);
    });

    test(
        'returns false if any element of this set is not contained in other '
        'set', () {
      final values = {'a', 'b', 'c'};
      expect(values.isStrictSubsetOf({'a', 'b', 'f'}), isFalse);
    });

    test('returns true if this set is empty and other set is not', () {
      final values = <String>{};
      expect(values.isStrictSubsetOf({'a', 'b', 'f'}), isTrue);
    });

    test('returns false if other set is empty and this set is not', () {
      final values = {'a', 'b', 'c'};
      expect(values.isStrictSubsetOf(<String>{}), isFalse);
    });

    test('returns false if both sets are empty', () {
      final values = <String>{};
      expect(values.isStrictSubsetOf(<String>{}), isFalse);
    });
  });

  group('isStrictSupersetOf', () {
    test('returns true if every element of other set is contained in this set',
        () {
      final values = {'a', 'b', 'c'};
      expect(values.isStrictSupersetOf({'b', 'c'}), isTrue);
    });

    test('returns false if both sets are equal', () {
      final values = {'a', 'b', 'c'};
      expect(values.isStrictSupersetOf({'a', 'b', 'c'}), isFalse);
    });

    test(
        'returns false if any element of other set is not contained in this '
        'set', () {
      final values = {'a', 'b', 'c'};
      expect(values.isStrictSupersetOf({'a', 'b', 'f'}), isFalse);
    });

    test('returns false if this set is empty and other set is not', () {
      final values = <String>{};
      expect(values.isStrictSupersetOf({'a', 'b', 'f'}), isFalse);
    });

    test('returns true if other set is empty and this set is not', () {
      final values = {'a', 'b', 'c'};
      expect(values.isStrictSupersetOf(<String>{}), isTrue);
    });

    test('returns false if both sets are empty', () {
      final values = <String>{};
      expect(values.isStrictSupersetOf(<String>{}), isFalse);
    });
  });

  group('takeRandom', () {
    test('returns null for an empty set', () {
      expect(<String>{}.takeRandom(), isNull);
    });

    test('removes the only element of a set of length 1', () {
      final values = {'a'};
      expect(values.takeRandom(), 'a');
      expect(values, isEmpty);
    });
  });

  group('classify', () {
    test('groups values by provided classifier', () {
      final values = {'aaa', 'bbb', 'cc', 'a', 'bb'};
      final groups = values.classify<int>((e) => e.length);

      expect(groups.entries.length, 3);
      expect(groups[1], {'a'});
      expect(groups[2], {'cc', 'bb'});
      expect(groups[3], {'aaa', 'bbb'});
    });

    test('returns an empty map if called on an empty set', () {
      final values = <String>{};
      expect(values.classify<int>((e) => e.length), <int, Set<String>>{});
    });
  });
}
