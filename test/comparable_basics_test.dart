// Copyright (c) 2022, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:basics/comparable_basics.dart';
import 'package:test/test.dart';

void main() {
  var date1 = _HideComparisonOperators(DateTime.now());
  var date2 =
      _HideComparisonOperators(date1.value.add(const Duration(seconds: 1)));
  var s1 = _HideComparisonOperators('aardvark');
  var s2 = _HideComparisonOperators('zebra');

  test('comparison operators work', () {
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

  test('min/max work', () {
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

  test("min/max behave like dart:math's min/max", () {
    expect(min(-0.0, 0.0), math.min(-0.0, 0.0));
    expect(min(0.0, -0.0), math.min(0.0, -0.0));
    expect(max(-0.0, 0.0), math.max(-0.0, 0.0));
    expect(max(0.0, -0.0), math.max(0.0, -0.0));

    expect(
      min(double.nan, 0.0),
      _matchesDouble(math.min(double.nan, 0.0)),
    );
    expect(
      min(0.0, double.nan),
      _matchesDouble(math.min(0.0, double.nan)),
    );
    expect(
      min(double.nan, double.nan),
      _matchesDouble(math.min(double.nan, double.nan)),
    );
    expect(
      max(double.nan, 0.0),
      _matchesDouble(math.max(double.nan, 0.0)),
    );
    expect(
      max(0.0, double.nan),
      _matchesDouble(math.max(0.0, double.nan)),
    );
    expect(
      max(double.nan, double.nan),
      _matchesDouble(math.max(double.nan, double.nan)),
    );
  });

  test('_matchesDouble works', () {
    expect(_matchesDouble(0.5).matches(0.5, {}), true);
    expect(_matchesDouble(0.5).matches(0.0, {}), false);
    expect(_matchesDouble(double.nan).matches(double.nan, {}), true);
    expect(_matchesDouble(0.0).matches(double.nan, {}), false);
    expect(_matchesDouble(double.nan).matches(0.0, {}), false);
  });
}

/// A wrapper class that provides a [Comparable.compareTo] implementation but
/// that explicitly does not provide its own comparison operators.
///
/// Used to test the [ComparableBasics] extension.  We intentionally avoid
/// using `T` directly in case it has its own comparison operators.
class _HideComparisonOperators<T extends Comparable<Object>>
    implements Comparable<_HideComparisonOperators<T>> {
  _HideComparisonOperators(this.value);

  final T value;

  @override
  int compareTo(_HideComparisonOperators<T> other) =>
      value.compareTo(other.value);
}

/// Returns a [Matcher] for [double] equality that, unlike [equals]. considers
/// NaN values to be equal to other NaN values.
Matcher _matchesDouble(double expectedValue) {
  bool matchesDoubleInternal(double actualValue) =>
      (expectedValue == actualValue) ||
      (expectedValue.isNaN && actualValue.isNaN);

  return predicate(matchesDoubleInternal, '<$expectedValue>');
}
