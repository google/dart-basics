
import 'package:basics/basics.dart';

main() async {
  const numbers = <int>[2, 4, 8];

  if (numbers.isNotNull && numbers.all((n) => n.isEven)) {
    print('All numbers are even.');
  }

  print('sum of numbers is: ${numbers.sum()}');

  for (var i in 5.range) {
    print('waiting 500 milliseconds...');
    await Future.delayed(500.milliseconds);
  }
}