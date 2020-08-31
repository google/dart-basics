// Copyright (c) 2019, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:basics/basics.dart';
import 'package:test/test.dart';

void main() {
  group('isNull', () {
    test('returns true when object is null', () {
      Object? object;

      expect(object.isNull, isTrue);
    });

    test('returns false when object is not null', () {
      Object? object = '';

      expect(object.isNull, isFalse);
    });

    test('returns true on uninitialized Object subclasses', () {
      String? object1;
      int? object2;
      double? object3;
      num? object4;
      List? object5;
      Map? object7;
      Set? object9;

      expect(object1.isNull, isTrue);
      expect(object2.isNull, isTrue);
      expect(object3.isNull, isTrue);
      expect(object4.isNull, isTrue);
      expect(object5.isNull, isTrue);
      expect(object7.isNull, isTrue);
      expect(object9.isNull, isTrue);
    });

    test('returns false on initialized Object subclasses', () {
      String? object1 = '';
      int? object2 = 1;
      double? object3 = 1.0;
      num? object4 = 1;
      List? object5 = [1, 2, 3];
      Map? object7 = {1: 2, 3: 4, 5: 6};
      Set? object9 = {1, 2, 3};

      expect(object1.isNull, isFalse);
      expect(object2.isNull, isFalse);
      expect(object3.isNull, isFalse);
      expect(object4.isNull, isFalse);
      expect(object5.isNull, isFalse);
      expect(object7.isNull, isFalse);
      expect(object9.isNull, isFalse);
    });
  });

  group('isNotNull', () {
    test('returns true when object is not null', () {
      Object? object = '';

      expect(object.isNotNull, isTrue);
    });

    test('returns false when object is null', () {
      Object? object;

      expect(object.isNotNull, isFalse);
    });

    test('returns false on uninitialized Object subclasses', () {
      String? object1;
      int? object2;
      double? object3;
      num? object4;
      List? object5;
      Map? object7;
      Set? object9;

      expect(object1.isNotNull, isFalse);
      expect(object2.isNotNull, isFalse);
      expect(object3.isNotNull, isFalse);
      expect(object4.isNotNull, isFalse);
      expect(object5.isNotNull, isFalse);
      expect(object7.isNotNull, isFalse);
      expect(object9.isNotNull, isFalse);
    });

    test('returns true on initialized Object subclasses', () {
      String? object1 = '';
      int? object2 = 1;
      double? object3 = 1.0;
      num? object4 = 1;
      List? object5 = [1, 2, 3];
      Map? object7 = {1: 2, 3: 4, 5: 6};
      Set? object9 = {1, 2, 3};

      expect(object1.isNotNull, isTrue);
      expect(object2.isNotNull, isTrue);
      expect(object3.isNotNull, isTrue);
      expect(object4.isNotNull, isTrue);
      expect(object5.isNotNull, isTrue);
      expect(object7.isNotNull, isTrue);
      expect(object9.isNotNull, isTrue);
    });
  });
}
