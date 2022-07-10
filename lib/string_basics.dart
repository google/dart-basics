// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'src/slice_indices.dart';

/// Utility extension methods for the native [String] class.
extension StringBasics on String {
  /// Returns a value according to the contract for [Comparator] indicating
  /// the ordering between [this] and [other], ignoring letter case.
  ///
  /// Example:
  /// ```dart
  /// 'ABC'.compareToIgnoringCase('abd'); // negative value
  /// 'ABC'.compareToIgnoringCase('abc'); // zero
  /// 'ABC'.compareToIgnoringCase('abb'); // positive value
  /// ```
  ///
  /// NOTE: This implementation relies on [String].`toLowerCase`, which is not
  /// locale aware. Therefore, this method is likely to exhibit unexpected
  /// behavior for non-ASCII characters.
  int compareToIgnoringCase(String other) =>
      this.toLowerCase().compareTo(other.toLowerCase());

  /// Returns `true` if [this] is empty or consists solely of whitespace
  /// characters as defined by [String.trim].
  bool get isBlank => this.trim().isEmpty;

  /// Returns `true` if [this] is not empty and does not consist solely of
  /// whitespace characters as defined by [String.trim].
  bool get isNotBlank => this.trim().isNotEmpty;

  /// Returns a copy of [this] with [prefix] removed if it is present.
  ///
  /// If [this] does not start with [prefix], returns [this].
  ///
  /// Example:
  /// ```dart
  /// var string = 'abc';
  /// string.withoutPrefix('ab'); // 'c'
  /// string.withoutPrefix('z'); // 'abc'
  /// ```
  String withoutPrefix(Pattern prefix) => this.startsWith(prefix)
      ? this.substring(prefix.allMatches(this).first.end)
      : this;

  /// Returns a copy of [this] with [suffix] removed if it is present.
  ///
  /// If [this] does not end with [suffix], returns [this].
  ///
  /// Example:
  /// ```dart
  /// var string = 'abc';
  /// string.withoutSuffix('bc'); // 'a';
  /// string.withoutSuffix('z'); // 'abc';
  /// ```
  String withoutSuffix(Pattern suffix) {
    // Can't use endsWith because that takes a String, not a Pattern.
    final matches = suffix.allMatches(this);
    return (matches.isEmpty || matches.last.end != this.length)
        ? this
        : this.substring(0, matches.last.start);
  }

  /// Returns a copy of [this] with [other] inserted starting at [index].
  ///
  /// Example:
  /// ```dart
  /// 'word'.insert('s', 0); // 'sword'
  /// 'word'.insert('ke', 3); // 'worked'
  /// 'word'.insert('y', 4); // 'wordy'
  /// ```
  String insert(String other, int index) => (StringBuffer()
        ..write(this.substring(0, index))
        ..write(other)
        ..write(this.substring(index)))
      .toString();

  /// Returns the concatenation of [other] and [this].
  ///
  /// Example:
  /// ```dart
  /// 'word'.prepend('key'); // 'keyword'
  /// ```
  String prepend(String other) => other + this;

  /// Divides string into everything before [pattern], [pattern], and everything
  /// after [pattern].
  ///
  /// Example:
  /// ```dart
  /// 'word'.partition('or'); // ['w', 'or', 'd']
  /// ```
  ///
  /// If [pattern] is not found, the entire string is treated as coming before
  /// [pattern].
  ///
  /// Example:
  /// ```dart
  /// 'word'.partition('z'); // ['word', '', '']
  /// ```
  List<String> partition(Pattern pattern) {
    final matches = pattern.allMatches(this);
    if (matches.isEmpty) return [this, '', ''];
    final matchStart = matches.first.start;
    final matchEnd = matches.first.end;
    return [
      this.substring(0, matchStart),
      this.substring(matchStart, matchEnd),
      this.substring(matchEnd)
    ];
  }

  /// Returns a new string containing the characters of [this] from [start]
  /// inclusive to [end] exclusive, skipping by [step].
  ///
  /// Example:
  /// ```dart
  /// 'word'.slice(start: 1, end: 3); // 'or'
  /// 'word'.slice(start: 1, end: 4, step: 2); // 'od'
  /// ```
  ///
  /// [start] defaults to the first character if [step] is positive and to the
  /// last character if [step] is negative. [end] does the opposite.
  ///
  /// Example:
  /// ```dart
  /// 'word'.slice(end: 2); // 'wo'
  /// 'word'.slice(start: 1); // 'ord'
  /// 'word'.slice(end: 1, step: -1); // 'dr'
  /// 'word'.slice(start: 2, step: -1); // 'row'
  /// ```
  ///
  /// If [start] or [end] is negative, it will be counted backwards from the
  /// last character of [this]. If [step] is negative, the characters will be
  /// returned in reverse order.
  ///
  /// Example:
  /// ```dart
  /// 'word'.slice(start: -2); // 'rd'
  /// 'word'.slice(end: -1); // 'wor'
  /// 'word'.slice(step: -1); // 'drow'
  /// ```
  ///
  /// Any out-of-range values for [start] or [end] will be truncated to the
  /// maximum in-range value in that direction.
  ///
  /// Example:
  /// ```dart
  /// 'word'.slice(start: -100); // 'word'
  /// 'word'.slice(end: 100); // 'word'
  /// ```
  ///
  /// Will return an empty string if [start] and [end] are equal, [start] is
  /// greater than [end] while [step] is positive, or [end] is greater than
  /// [start] while [step] is negative.
  ///
  /// Example:
  /// ```dart
  /// 'word'.slice(start: 1, end: -3); // ''
  /// 'word'.slice(start: 3, end: 1); // ''
  /// 'word'.slice(start: 1, end: 3, step: -1); // ''
  /// ```
  String slice({int? start, int? end, int step = 1}) {
    final indices = sliceIndices(start, end, step, this.length);
    if (indices == null) {
      return '';
    }

    final _start = indices.start;
    final _end = indices.end;
    final stringBuffer = StringBuffer();

    if (step > 0) {
      for (var i = _start; i < _end; i += step) {
        stringBuffer.write(this[i]);
      }
    } else {
      for (var i = _start; i > _end; i += step) {
        stringBuffer.write(this[i]);
      }
    }
    return stringBuffer.toString();
  }

  /// Returns [this] with characters in reverse order.
  ///
  /// Example:
  /// ```dart
  /// 'word'.reverse(); // 'drow'
  /// ```
  ///
  /// WARNING: This is the naive-est possible implementation, relying on native
  /// string indexing. Therefore, this method is almost guaranteed to exhibit
  /// unexpected behavior for non-ASCII characters.
  String reverse() {
    final stringBuffer = StringBuffer();
    for (var i = this.length - 1; i >= 0; i--) {
      stringBuffer.write(this[i]);
    }
    return stringBuffer.toString();
  }

  /// Returns a string with the first character in upper case.
  ///
  /// If the first character is not alphabetic then return the same string.
  /// If [this] is empty, returns and empty string.
  ///
  /// Example:
  /// ```dart
  /// final foo = 'bar';
  /// final baz = foo.capitalizeFirst(); // 'Bar'
  ///
  /// final foo1 = '1bar';
  /// final baz1 = foo1.capitalizeFirst(); // '1bar'
  ///
  /// final test = '';
  /// final result = test.capitalizeFirst(); // ''
  /// ```
  String capitalizeFirst() {
    if (this.isEmpty) return '';

    // trim this string first
    final trimmed = this.trimLeft();

    // convert the first character to upper case
    final firstCharacter = trimmed[0].toUpperCase();

    return trimmed.replaceRange(0, 1, firstCharacter);
  }
}

extension NullableStringBasics on String? {
  /// Returns `true` if [this] is null, empty, or consists solely of
  /// whitespace characters as defined by [String.trim].
  bool get isNullOrBlank => this?.trim().isEmpty ?? true;

  /// Returns `true` if [this] is not null, not empty, and does not consist
  /// solely of whitespace characters as defined by [String.trim].
  bool get isNotNullOrBlank => this?.trim().isNotEmpty ?? false;
}
