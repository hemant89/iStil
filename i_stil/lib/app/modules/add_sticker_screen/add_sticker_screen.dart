import 'package:flutter/material.dart';

class AddStickerScreen extends StatefulWidget {
  const AddStickerScreen({Key? key}) : super(key: key);

  @override
  State<AddStickerScreen> createState() => _AddStickerScreenState();
}

class _AddStickerScreenState extends State<AddStickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text("AddStickerScreen"),
      )),
    );
  }
}
