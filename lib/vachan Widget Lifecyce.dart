import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main()
{
  runApp(example());
}
class example extends StatefulWidget {
  const example({Key? key}) : super(key: key);

  @override
  State<example> createState() => _exampleState();
}

class _exampleState extends State<example> {
  @override
  void initState() {
    print("initiate state called");
  }

  @override
  void deactivate() {
    print("deactivate called");
  }

  @override
  Widget build(BuildContext context) {
    print("build called");
    return MaterialApp(home: Scaffold(body: Text("adfa"),),);
  }
}
