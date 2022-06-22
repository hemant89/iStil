import 'package:flutter/material.dart';

class AudioAddScreen extends StatefulWidget {
  const AudioAddScreen({Key? key}) : super(key: key);

  @override
  State<AudioAddScreen> createState() => _AudioAddScreenState();
}

class _AudioAddScreenState extends State<AudioAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text("AudioAddScreen"),
      )),
    );
  }
}
