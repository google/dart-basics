// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:basics/basics.dart';
import 'package:test/test.dart';

void main() {
  group('compareToIgnoringCase', () {
    test('compares strings ignoring case', () {
      final string = 'ABC';
      expect(string.compareToIgnoringCase('abd') < 0, isTrue);
      expect(string.compareToIgnoringCase('abc'), 0);
      expect(string.compareToIgnoringCase('abb') > 0, isTrue);
    });
  });

  group('withoutPrefix', () {
    test('returns string without prefix if prefix is present', () {
      final string = 'abc';
      expect(string.withoutPrefix('ab'), 'c');
    });

    test('returns original string if prefix is not present', () {
      final string = 'abc';
      expect(string.withoutPrefix('z'), 'abc');
    });

    test('works with a regex', () {
      final string = 'aaaaaaaaabc';
      expect(string.withoutPrefix(RegExp(r'a+')), 'bc');
    });

    test('ignores matches not at the start of the string', () {
      final inMiddle = 'baaaaaaaaaaac';
      final atEnd = 'bcaaaaaaaaaaa';
      expect(inMiddle.withoutPrefix(RegExp(r'a+')), inMiddle);
      expect(atEnd.withoutPrefix(RegExp(r'a+')), atEnd);
    });
  });

  group('withoutSuffix', () {
    test('returns string without suffix if suffix is present', () {
      final string = 'abc';
      expect(string.withoutSuffix('c'), 'ab');
    });

    test('returns original string if suffix is not present', () {
      final string = 'abc';
      expect(string.withoutSuffix('z'), 'abc');
    });

    test('works with a regex', () {
      final string = 'abccccccccccccccc';
      expect(string.withoutSuffix(RegExp(r'c+')), 'ab');
    });

    test('ignores matches not at the end of the string', () {
      final atStart = 'aaaaaaaaaaaaabc';
      final inMiddle = 'baaaaaaaaaaac';
      expect(atStart.withoutSuffix(RegExp(r'a+')), atStart);
      expect(inMiddle.withoutSuffix(RegExp(r'a+')), inMiddle);
    });
  });

  group('insert', () {
    test('inserts provided string at provided index', () {
      final string = 'word';
      expect(string.insert('s', 0), 'sword');
      expect(string.insert('ke', 3), 'worked');
      expect(string.insert('y', 4), 'wordy');
    });

    test('works when called on an empty string', () {
      expect(''.insert('word', 0), 'word');
    });

    test('works when provided an empty string', () {
      expect('word'.insert('', 1), 'word');
    });
  });

  group('prepend', () {
    test('prepends other string to this string', () {
      final string = 'word';
      expect(string.prepend('key'), 'keyword');
    });
  });

  group('partition', () {
    test('partitions a string around the first occurrence of pattern', () {
      final string = 'word';
      expect(string.partition('or'), ['w', 'or', 'd']);
    });

    test('works when string starts with pattern', () {
      final string = 'word';
      expect(string.partition('wo'), ['', 'wo', 'rd']);
    });

    test('works when string ends with pattern', () {
      final string = 'word';
      expect(string.partition('rd'), ['wo', 'rd', '']);
    });

    test(
        'treats whole string as occurring before pattern if pattern is not '
        'found', () {
      final string = 'word';
      expect(string.partition('z'), ['word', '', '']);
    });

    test('works with a regex', () {
      final string = 'wooooooord';
      expect(string.partition(RegExp(r'o+r')), ['w', 'ooooooor', 'd']);
    });
  });

  group('slice', () {
    test('returns the characters from start inclusive', () {
      final string = 'word';
      expect(string.slice(start: 1), 'ord');
      expect(string.slice(start: 2, step: -2), 'rw');
    });

    test('returns the characters until end exclusive', () {
      final string = 'stuff';
      expect(string.slice(end: 2), 'st');
      expect(string.slice(end: 1, step: -1), 'ffu');
    });

    test('returns the characters between start and end', () {
      final string = 'word';
      expect(string.slice(start: 1, end: 3), 'or');
    });

    test('skips characters by step', () {
      final string = 'word';
      expect(string.slice(step: 2), 'wr');
    });

    test('returns the characters between start and end by step', () {
      final string = 'word';
      expect(string.slice(start: 1, end: 4, step: 2), 'od');
    });

    test(
        'accepts steps that do not evenly divide the total number of '
        'characters', () {
      final string = 'word';
      expect(string.slice(step: 3), 'wd');
    });

    test('returns characters in reverse order when step is negative', () {
      final string = 'hat';
      expect(string.slice(step: -1), 'tah');
    });

    test('counts a negative start index from the end of the string', () {
      final string = 'word';
      expect(string.slice(start: -2), 'rd');
    });

    test('counts a negative end index from the end of the string', () {
      final string = 'stuff';
      expect(string.slice(end: -2), 'stu');
    });

    test(
        'starts from the final character if start is greater than the length '
        'of the string', () {
      final string = 'word';
      expect(string.slice(start: 100, end: 1), '');
      expect(string.slice(start: 100, end: 1, step: -1), 'dr');
    });

    test(
        'ends with the final character if end is greater than the length of '
        'the string', () {
      final string = 'stuff';
      expect(string.slice(start: 2, end: 100), 'uff');
    });

    test(
        'starts from the first character if start is less than the negative '
        'length of the string', () {
      final string = 'hat';
      expect(string.slice(start: -100, end: 3), 'hat');
    });

    test(
        'ends with the first character if end is less than the negative length '
        'of the string', () {
      final string = 'word';
      expect(string.slice(start: 2, end: -100), '');
      expect(string.slice(start: 2, end: -100, step: -1), 'row');
    });

    test('returns an empty string if start and end are equal', () {
      final string = 'stuff';
      expect(string.slice(start: 2, end: 2), '');
      expect(string.slice(start: -2, end: -2), '');
    });

    test(
        'returns an empty string if start and end are not equal but correspond '
        'to the same index', () {
      final string = 'word';
      expect(string.slice(start: 1, end: -3), '');
      expect(string.slice(start: 2, end: -2), '');
    });

    test(
        'returns an empty string if start (or its equivalent index) is greater '
        'than end (or its equivalent index) and step is positive', () {
      final string = 'word';
      expect(string.slice(start: 3, end: 1), '');
      expect(string.slice(start: -1, end: 1), '');
      expect(string.slice(start: 3, end: -3), '');
      expect(string.slice(start: -1, end: -3), '');
      expect(string.slice(start: 3, end: -100), '');
    });

    test(
        'returns an empty string if start (or its equivalent index) is less '
        'than end (or its equivalent index) and step is negative', () {
      final string = 'word';
      expect(string.slice(start: 1, end: 3, step: -1), '');
      expect(string.slice(start: -3, end: 3, step: -1), '');
      expect(string.slice(start: 1, end: -1, step: -1), '');
      expect(string.slice(start: -3, end: -1, step: -1), '');
      expect(string.slice(start: 1, end: 100, step: -1), '');
    });

    test('behaves predictably when the bounds are increased in any direction',
        () {
      final string = 'word';

      expect(string.slice(start: 0, end: 0), '');
      expect(string.slice(start: 0, end: 1), 'w');
      expect(string.slice(start: 0, end: 2), 'wo');
      expect(string.slice(start: 0, end: 3), 'wor');
      expect(string.slice(start: 0, end: 4), 'word');
      expect(string.slice(start: 0, end: 5), 'word');

      expect(string.slice(start: 0, end: -5), '');
      expect(string.slice(start: 0, end: -4), '');
      expect(string.slice(start: 0, end: -3), 'w');
      expect(string.slice(start: 0, end: -2), 'wo');
      expect(string.slice(start: 0, end: -1), 'wor');

      expect(string.slice(start: 5, end: 4), '');
      expect(string.slice(start: 4, end: 4), '');
      expect(string.slice(start: 3, end: 4), 'd');
      expect(string.slice(start: 2, end: 4), 'rd');
      expect(string.slice(start: 1, end: 4), 'ord');

      expect(string.slice(start: -1, end: 4), 'd');
      expect(string.slice(start: -2, end: 4), 'rd');
      expect(string.slice(start: -3, end: 4), 'ord');
      expect(string.slice(start: -4, end: 4), 'word');
      expect(string.slice(start: -5, end: 4), 'word');

      expect(string.slice(start: 3, end: 3, step: -1), '');
      expect(string.slice(start: 3, end: 2, step: -1), 'd');
      expect(string.slice(start: 3, end: 1, step: -1), 'dr');
      expect(string.slice(start: 3, end: 0, step: -1), 'dro');

      expect(string.slice(start: 3, end: -1, step: -1), '');
      expect(string.slice(start: 3, end: -2, step: -1), 'd');
      expect(string.slice(start: 3, end: -3, step: -1), 'dr');
      expect(string.slice(start: 3, end: -4, step: -1), 'dro');
      expect(string.slice(start: 3, end: -5, step: -1), 'drow');

      expect(string.slice(start: 0, end: 0, step: -1), '');
      expect(string.slice(start: 1, end: 0, step: -1), 'o');
      expect(string.slice(start: 2, end: 0, step: -1), 'ro');
      expect(string.slice(start: 3, end: 0, step: -1), 'dro');
      expect(string.slice(start: 4, end: 0, step: -1), 'dro');
      expect(string.slice(start: 5, end: 0, step: -1), 'dro');

      expect(string.slice(start: -1, end: 0, step: -1), 'dro');
      expect(string.slice(start: -2, end: 0, step: -1), 'ro');
      expect(string.slice(start: -3, end: 0, step: -1), 'o');
      expect(string.slice(start: -4, end: 0, step: -1), '');

      expect(string.slice(start: -1, end: -5, step: -1), 'drow');
      expect(string.slice(start: -2, end: -5, step: -1), 'row');
      expect(string.slice(start: -3, end: -5, step: -1), 'ow');
      expect(string.slice(start: -4, end: -5, step: -1), 'w');
      expect(string.slice(start: -5, end: -5, step: -1), '');
    });
  });

  group('reverse', () {
    test('reverses a string', () {
      final string = 'word';
      expect(string.reverse(), 'drow');
    });

    test('returns an empty string if called on an empty string', () {
      expect(''.reverse(), '');
    });
  });

  group('isBlank', () {
    test('returns true if a string is blank', () {
      expect(''.isBlank, isTrue);
    });

    test('returns false if a string is not blank', () {
      expect('a'.isBlank, isFalse);
    });
  });

  group('isNotBlank', () {
    test('returns false if a string is blank', () {
      expect(''.isNotBlank, isFalse);
    });

    test('returns true if a string is not blank', () {
      expect('a'.isNotBlank, isTrue);
    });
  });

  group('isNullOrBlank', () {
    test('returns true if a string is null', () {
      final String? string = null;
      expect(string.isNullOrBlank, isTrue);
    });

    test('returns true if a string is blank', () {
      expect(''.isNullOrBlank, isTrue);
    });

    test('returns false if a string is not blank', () {
      expect('a'.isNullOrBlank, isFalse);
    });
  });

  group('isNotNullOrBlank', () {
    test('returns false if a string is null', () {
      final String? string = null;
      expect(string.isNotNullOrBlank, isFalse);
    });

    test('returns false if a string is blank', () {
      expect(''.isNotNullOrBlank, isFalse);
    });

    test('returns true if a string is not blank', () {
      expect('a'.isNotNullOrBlank, isTrue);
    });
  });

  group('truncate', () {
    test(
        'returns a truncated string that has the length'
        'based on the limit provided', () {
      final sentence = 'The quick brown fox jumps over the lazy dog';
      expect(sentence.truncate(20), 'The quick brown fox');
    });

    test(
        'returns the same string if the length of the string'
        'is less than provided limit', () {
      final sentence = 'The quick brown fox';
      expect(sentence.truncate(20), 'The quick brown fox');
    });

    test(
        'returns a truncated string that has the length based on the length'
        'provided without trimming the spaces at the end', () {
      final sentence = 'The quick brown fox jumps over the lazy dog';
      expect(sentence.truncate(20, trimTrailingWhitespace: false),
          'The quick brown fox ');
    });

    test(
        'returns a truncated string that has the length based on the length'
        'provided with a custom ending string', () {
      final sentence = 'The quick brown fox jumps over the lazy dog';
      expect(sentence.truncate(20, substitution: ' (...)'),
          'The quick brown fox (...)');
      expect(
          sentence.truncate(20, substitution: '...'), 'The quick brown fox...');
    });
  });
}
