import 'package:flutter/material.dart';

class AudioRemoveScreen extends StatefulWidget {
  const AudioRemoveScreen({Key? key}) : super(key: key);

  @override
  State<AudioRemoveScreen> createState() => _AudioRemoveScreenState();
}

class _AudioRemoveScreenState extends State<AudioRemoveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text("AudioRemoveScreen"),
      )),
    );
  }
}
