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
List<int> numbers;

if (numbers.isNull) {
  print('Numbers is uninitialized');
}

for (var i in 1.to(10)) {
  if (i.isEven) numbers.add(i);
}

if (numbers.isNotNull && numbers.all(isEven)) {
  print('All numbers are even');
}
```

## Notes
This is not an official Google project.

