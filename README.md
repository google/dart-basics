# Dart Basics

This repository contains a collection of useful extension methods on the
built-in objects in Dart, such as String, Iterable, and Object.

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

numbers = [1, 4, 7];

if (numbers.isNotNull && numbers.one(isEven)) {
  print('Exactly one number is even');
}
```

## Notes
This is not an official Google project.

