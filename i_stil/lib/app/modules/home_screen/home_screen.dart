import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_stil/app/const/color_const.dart';
import 'package:i_stil/app/modules/add_sticker_screen/add_sticker_screen.dart';
import 'package:i_stil/app/modules/add_text_screen/add_text_screen.dart';
import 'package:i_stil/app/modules/audio_add_screen/audio_add_screen.dart';
import 'package:i_stil/app/modules/audio_remove_screen/audio_remove_screen.dart';
import 'package:i_stil/app/modules/video_cutting_screen/video_cutting_screen.dart';
import 'package:i_stil/app/modules/video_merge_screen/video_merge_screen.dart';
import 'package:i_stil/app/modules/widgets/card_widget.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColors.primaryColor,
        elevation: 0,
        title: const Text("iStil"),
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: (MediaQuery.of(context).size.width / 2) - 42,
              child: Row(
                children: [
                  Expanded(
                    child: CardWidget(
                      onTap: () async {
                        ImagePicker _picker = ImagePicker();
                        XFile? _video = await _picker.pickVideo(
                            source: ImageSource.gallery);
                        if (_video != null) {
                          if (!mounted) return;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => VideoCuttingScreen(
                                        videoFile: File(_video.path),
                                      )));
                        }
                      },
                      child: const Text(
                        "Cut Video",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CardWidget(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const VideoMergeScreen()));
                        },
                        child: const Text(
                          "Merge Video",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: (MediaQuery.of(context).size.width / 2) - 42,
              child: Row(
                children: [
                  Expanded(
                    child: CardWidget(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AudioAddScreen()));
                        },
                        child: const Text(
                          "Add Audio",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CardWidget(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AudioRemoveScreen()));
                        },
                        child: const Text(
                          "Remove Audio",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: (MediaQuery.of(context).size.width / 2) - 42,
              child: Row(
                children: [
                  Expanded(
                    child: CardWidget(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AddStickerScreen()));
                        },
                        child: const Text(
                          "Add Sticker",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CardWidget(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AddTextScreen()));
                        },
                        child: const Text(
                          "Add Text",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
