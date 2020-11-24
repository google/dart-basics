# Dart Basics

This repository contains a collection of useful extension methods on the
built-in objects in Dart, such as String, Iterable, and Object.

> :warning: Due to the ongoing [null safety](https://dart.dev/null-safety)
migration in the Dart SDK, **the code currently available in the `basics`
[pub package](https://pub.dev/packages/basics) does not reflect the state
of the code in this repo.** The code in this repo has been updated to
be null-aware, which requires an SDK feature still gated by an experiment
flag. Until the latest stable release of the Dart SDK includes null safety
by default, the `basics` pub package will not be updated with any changes
from this repo.

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

