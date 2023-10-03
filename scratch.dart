import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  task1();
  String result = await task2();
  task3(result);
  task1();
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future task2() async {
  Duration a = Duration(seconds: 3);

  late String result;

  await Future.delayed(a, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });
  return result;
}

void task3(String message) {
  String result = 'task 3 data';
  print('Task 3 complete with $message');
}
