// dart '.\[filename]'
//this is the command to run in terminal
import 'dart:io';

void main() {
  perform();
}

void perform() async {
  func1();
  String func2Result = await func2();
  func3(func2Result);
}

func1() {
  print("func 1 complete");
}

Future func2() async {
  String? result;
  Duration threeseconds = Duration(seconds: 3);
  await Future.delayed(threeseconds, () {
    // this is async delay
    print("func 2 complete");
    result = "future vk fun2 variable";
  });
  return result;
  // sleep(threeseconds); -- this is synchronous delay
}

func3(String taskTwodata) {
  print("func 3 complete $taskTwodata");
}
