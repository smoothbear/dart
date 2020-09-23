import 'dart:io';

int fibonacci(int n) {
  if (n < 2) return n;
  return fibonacci(n - 1) + (n - 2);
}

void main() {
  var result = fibonacci(int.parse(stdin.readLineSync()));
  print('Result : $result');
}