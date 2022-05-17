// Copyright (c) 2022, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:basics/comparable_basics.dart';
import 'package:test/test.dart';

void main() {
  group('Comparable', () {
    var date1 = _Wrapped(DateTime.now());
    var date2 = _Wrapped(date1.value.add(const Duration(seconds: 1)));
    var s1 = _Wrapped('aardvark');
    var s2 = _Wrapped('zebra');

    test('ComparisonOperators extension', () {
      expect('aardvark' < 'zebra', true);

      expect(date1 < date2, true);

      expect(s1 < s2, true);
      expect(s2 < s1, false);
      expect(s1 > s2, false);
      expect(s2 > s1, true);

      expect(s1 <= s2, true);
      expect(s2 <= s1, false);
      expect(s1 >= s2, false);
      expect(s2 >= s1, true);

      expect(s1 <= s1, true);
      expect(s1 >= s1, true);
    });

    test('min/max', () {
      expect(max(date1, date2), date2);
      expect(max(date2, date1), date2);

      expect(min(date1, date2), date1);
      expect(min(date2, date1), date1);

      // [int] and [double] (and combinations of them) can be potentially tricky
      // because their inheritance tree requires both of them to implement
      // `Comparable<num>` instead of `Comparable<int>` and `Comparable<double>`
      // respectively.
      var i = 3;
      var d = 3.1415;
      expect(max(i, d), d);
      expect(max(d, i), d);
      expect(min(i, d), i);
      expect(min(d, i), i);

      expect(max(i, i), i);
      expect(min(i, i), i);
      expect(max(d, d), d);
      expect(min(d, d), d);
    });
  });
}

/// A wrapper class that provides a [Comparable.compareTo] implementation and
/// that explicitly does not provide its own comparison operators.
///
/// Used to test the [ComparisonOperators] extension.  We intentionally avoid
/// using `T` directly in case it has its own comparison operators.
class _Wrapped<T extends Comparable<Object>> implements Comparable<_Wrapped<T>> {
  _Wrapped(this.value);

  final T value;

  @override
  int compareTo(_Wrapped<T> other) => value.compareTo(other.value);
}
