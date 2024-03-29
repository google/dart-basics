// Copyright (c) 2020, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:basics/basics.dart';

void main() async {
  const numbers = <int>[2, 4, 8];

  if (numbers.all((n) => n.isEven)) {
    print('All numbers are even.');
  }

  print('sum of numbers is: ${numbers.sum()}');

  for (var _ in 5.range) {
    print('waiting 500 milliseconds...');
    await Future<void>.delayed(500.milliseconds);
  }
}
