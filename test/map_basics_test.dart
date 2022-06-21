// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:basics/basics.dart';
import 'package:test/test.dart';

void main() {
  group('get', () {
    test('returns the value for a found key', () {
      final map = {'a': 1, 'b': 2, 'c': null};
      expect(map.get('a'), 1);
      expect(map.get('a', defaultValue: 0), 1);

      expect(map.get('c'), null);
      expect(map.get('c', defaultValue: 0), null);
    });

    test('returns the default value if no key found', () {
      final map = {'a': 1, 'b': 2, 'c': null};
      expect(map.get('d'), null);
      expect(map.get('d', defaultValue: 0), 0);
    });
  });

  group('whereKey', () {
    test('returns all entries with key satisfying test', () {
      final map = {'a': 1, 'bb': 2, 'ccc': 3};
      expect(map.whereKey((key) => key.length > 1), {'bb': 2, 'ccc': 3});
    });
  });

  group('whereValue', () {
    test('returns all entries with value satisfying test', () {
      final map = {'a': 1, 'b': 2, 'c': 3};
      expect(map.whereValue((value) => value > 1), {'b': 2, 'c': 3});
    });
  });

  group('invert', () {
    test('inverts each entry', () {
      final map = {'a': 1, 'b': 2, 'c': 3};
      expect(map.invert(), {1: 'a', 2: 'b', 3: 'c'});
    });

    test('works with duplicate values', () {
      final map = {'a': 1, 'b': 2, 'c': 2};
      final inverted = map.invert();

      expect(inverted.entries.length, 2);
      expect(inverted[1], 'a');
      // Value for key 2 is dependent on iteration order and cannot be
      // guaranteed.
      expect(inverted.containsKey(2), isTrue);
    });

    test('works with null values', () {
      final map = {'a': 1, 'b': null};
      expect(map.invert(), {1: 'a', null: 'b'});
    });

    test('returns an empty map when called on an empty map', () {
      final map = <Object, Object>{};
      expect(map.invert(), <Object, Object>{});
    });
  });
}
