import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:i_stil/app/const/color_const.dart';
import 'package:i_stil/app/modules/video_merge_screen/widgets/select_button.dart';
import 'package:i_stil/app/providers/loading_provider.dart';
import 'package:i_stil/app/repositories/ffmpeg_repository/ffmpeg_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<String> get _localPath async {
  final directory = await getExternalStorageDirectory();

  return directory!.path;
}

Future<File> get localFile async {
  final path = await _localPath;
  return File('$path/mergeVideoFiles.txt');
}

Future<File> writePaths(String str) async {
  final file = await localFile;

  // Write the file
  return file.writeAsString(str);
}

class VideoMergeScreen extends StatefulWidget {
  const VideoMergeScreen({Key? key}) : super(key: key);

  @override
  State<VideoMergeScreen> createState() => _VideoMergeScreenState();
}

class _VideoMergeScreenState extends State<VideoMergeScreen> {
  XFile? firstVideo;
  XFile? secondVideo;
  int selectedFPS = 30;
  String selectedResolution = "720:1080";
  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Merge Videos"),
            backgroundColor: KColors.primaryColor,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: selectVideoButton(
                        title: "select First Video",
                        videoFile: firstVideo,
                        onTap: () async {
                          firstVideo = await imagePicker.pickVideo(
                              source: ImageSource.gallery);
                          // print(firstVideo?.path);
                          if (mounted) setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: selectVideoButton(
                        title: "Select Second Video",
                        videoFile: secondVideo,
                        onTap: () async {
                          secondVideo = await imagePicker.pickVideo(
                              source: ImageSource.gallery);
                          if (mounted) setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Column(
                                children: [
                                  const Text("Select FPS"),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (selectedFPS != 30 && mounted) {
                                            setState(() {
                                              selectedFPS = 30;
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: 34,
                                          width: 64,
                                          decoration: BoxDecoration(
                                            color: selectedFPS == 30
                                                ? KColors.primaryColor
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                              child: Text(
                                            "30FPS",
                                            style: TextStyle(
                                                color: selectedFPS == 30
                                                    ? Colors.white
                                                    : KColors.primaryColor),
                                          )),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (selectedFPS != 60 && mounted) {
                                            setState(() {
                                              selectedFPS = 60;
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: 34,
                                          width: 64,
                                          decoration: BoxDecoration(
                                            color: selectedFPS == 60
                                                ? KColors.primaryColor
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                              child: Text("60FPS",
                                                  style: TextStyle(
                                                      color: selectedFPS == 60
                                                          ? Colors.white
                                                          : KColors
                                                              .primaryColor))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Column(
                                children: [
                                  const Text("Select Resolution"),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (selectedResolution !=
                                                  "720:1080" &&
                                              mounted) {
                                            setState(() {
                                              selectedResolution = "720:1080";
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: 34,
                                          width: 64,
                                          decoration: BoxDecoration(
                                            color:
                                                selectedResolution == "720:1080"
                                                    ? KColors.primaryColor
                                                    : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                              child: Text(
                                            "720p",
                                            style: TextStyle(
                                                color: selectedResolution ==
                                                        "720:1080"
                                                    ? Colors.white
                                                    : KColors.primaryColor),
                                          )),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (selectedResolution !=
                                                  "1920:1080" &&
                                              mounted) {
                                            setState(() {
                                              selectedResolution = "1920:1080";
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: 34,
                                          width: 64,
                                          decoration: BoxDecoration(
                                            color: selectedResolution ==
                                                    "1920:1080"
                                                ? KColors.primaryColor
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                              child: Text("1080p",
                                                  style: TextStyle(
                                                      color: selectedResolution ==
                                                              "1920:1080"
                                                          ? Colors.white
                                                          : KColors
                                                              .primaryColor))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: MaterialButton(
                                  onPressed: () async {
                                    if (firstVideo != null &&
                                        secondVideo != null) {
                                      Provider.of<LoadingProvider>(context,
                                              listen: false)
                                          .showLoader();
                                      var _tempDir =
                                          await getExternalStorageDirectory();
                                      log(firstVideo!.name);
                                      File _firstVideoFile = File(
                                          "${_tempDir!.path}/video1.${firstVideo!.name.split(".").last}");
                                      if (await _firstVideoFile.exists()) {
                                        await _firstVideoFile.delete();
                                      }
                                      _firstVideoFile.create();

                                      await _firstVideoFile.writeAsBytes(
                                          await firstVideo!.readAsBytes());
                                      File _secondVideoFile = File(
                                          "${_tempDir.path}/video2.${secondVideo!.name.split(".").last}");
                                      if (await _secondVideoFile.exists()) {
                                        await _secondVideoFile.delete();
                                      }

                                      _secondVideoFile.create();
                                      await _secondVideoFile.writeAsBytes(
                                          await secondVideo!.readAsBytes());
                                      await writePaths(
                                          "file '${_firstVideoFile.path}' \nfile '${_secondVideoFile.path}'");
                                      await FfmpegRepository().mergeVideos(
                                        callback: () {
                                          if (mounted) {
                                            Provider.of<LoadingProvider>(
                                                    context,
                                                    listen: false)
                                                .hideLoader();
                                          }
                                        },
                                        firstVideoPath: _firstVideoFile.path,
                                        secondVideoPath: _secondVideoFile.path,
                                        resolution: selectedResolution,
                                        fps: selectedFPS,
                                      );
                                      log("message");
                                    }
                                  },
                                  color: KColors.primaryColor,
                                  child: const Text(
                                    "Merge",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: Provider.of<LoadingProvider>(context).isLoding,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
              child: Center(
                child: Container(
                  height: 130,
                  width: 250,
                  child: Center(
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
                      elevation: 10,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              CircularProgressIndicator(
                                color: KColors.primaryColor,
                              ),
                              SizedBox(height: 4),
                              Text("Please Wait, Merging videos")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
