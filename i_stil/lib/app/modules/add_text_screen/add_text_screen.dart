import 'package:flutter/material.dart';

class AddTextScreen extends StatefulWidget {
  const AddTextScreen({Key? key}) : super(key: key);

  @override
  State<AddTextScreen> createState() => _AddTextScreenState();
}

class _AddTextScreenState extends State<AddTextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text("AddTextScreen"),
      )),
    );
  }
}
