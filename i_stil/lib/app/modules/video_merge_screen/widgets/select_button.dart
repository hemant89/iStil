import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_stil/app/modules/widgets/video_player_widget.dart';
import 'package:image_picker/image_picker.dart';

class selectVideoButton extends StatelessWidget {
  const selectVideoButton({
    Key? key,
    this.onTap,
    this.videoFile,
    required this.title,
  }) : super(key: key);
  final Function()? onTap;
  final XFile? videoFile;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: videoFile != null ? null : onTap,
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16),
        padding: videoFile != null ? EdgeInsets.zero : const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: videoFile != null
            ? VideoPlayerWidget(videoFile: File(videoFile!.path))
            : Center(
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.video_collection),
                  const SizedBox(width: 10),
                  Text(title)
                ],
              )),
      ),
    );
  }
}
