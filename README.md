[![Dart CI](https://github.com/google/dart-basics/actions/workflows/dart.yml/badge.svg)](https://github.com/google/dart-basics/actions/workflows/dart.yml)
[![pub package](https://img.shields.io/pub/v/basics.svg)](https://pub.dev/packages/basics)
[![package publisher](https://img.shields.io/pub/publisher/basics.svg)](https://pub.dev/packages/basics/publisher)

This repository contains a collection of useful extension methods on the
built-in objects in Dart, such as String, Iterable, and Object.

## Usage
Import the basics library.

```dart
import 'package:basics/basics.dart';
```

Then use the methods directly on objects in your dart code.

```dart
import 'package:basics/basics.dart';

main() async {
  const numbers = <int>[2, 4, 8];

  if (numbers.all((n) => n.isEven)) {
    print('All numbers are even.');
  }

  print('sum of numbers is: ${numbers.sum()}');

  for (var _ in 5.range) {
    print('waiting 500 milliseconds...');
    await Future.delayed(500.milliseconds);
  }
}
```

## Notes
This is not an official Google project.

