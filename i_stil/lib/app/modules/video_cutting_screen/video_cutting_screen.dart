import 'dart:io';
// import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:i_stil/app/modules/video_cutting_screen/widgets/trimmer.dart';
import 'package:i_stil/app/modules/video_cutting_screen/widgets/video_viewer.dart';
import 'package:i_stil/app/modules/widgets/video_player_widget.dart';
import 'package:video_player/video_player.dart';

class VideoCuttingScreen extends StatefulWidget {
  const VideoCuttingScreen({Key? key, required this.videoFile})
      : super(key: key);
  final File videoFile;

  @override
  State<VideoCuttingScreen> createState() => _VideoCuttingScreenState();
}

class _VideoCuttingScreenState extends State<VideoCuttingScreen> {
  // late VideoPlayerController _controller;
  final Trimmer _trimmer = Trimmer();

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  void _loadVideo() {
    _trimmer.loadVideo(videoFile: widget.videoFile);
  }

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.file(widget.videoFile);
    // _controller.addListener(() {
    //   setState(() {});
    // });
    // _controller.setLooping(false);
    // _controller.initialize().then((_) => setState(() {}));
    // _controller.play();
    _loadVideo();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   foregroundColor: Colors.white,
      // ),
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Center(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Expanded(
                  child: VideoViewer(trimmer: _trimmer),
                ),
                // Center(
                //   child: AspectRatio(
                //       aspectRatio: _controller.value.aspectRatio,
                //       child: VideoPlayer(_controller)),
                // ),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 50,
                    child: _trimmer.videoPlayerController != null
                        ? _ControlsOverlay(
                            controller: _trimmer.videoPlayerController!)
                        : Container()),
                Positioned(
                    left: 10,
                    right: 10,
                    bottom: 50,
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 30,
                                  width: 60,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "00:00",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                              Container(
                                  height: 30,
                                  width: 60,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "00:00",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                            ]),
                        SizedBox(height: 5),
                        // VideoProgressIndicator(_controller,
                        //     allowScrubbing: true),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration(milliseconds: 0),
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 60.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  height: 30,
                  width: 40,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.cut,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
              PopupMenuButton<double>(
                initialValue: controller.value.playbackSpeed,
                tooltip: 'Playback speed',
                onSelected: (double speed) {
                  controller.setPlaybackSpeed(speed);
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuItem<double>>[
                    for (final double speed in _examplePlaybackRates)
                      PopupMenuItem<double>(
                        value: speed,
                        child: Text('${speed}x'),
                      )
                  ];
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    // Using less vertical padding as the text is also longer
                    // horizontally, so it feels like it would need more spacing
                    // horizontally (matching the aspect ratio of the video).
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Container(
                      height: 30,
                      width: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                          child: Text(
                        '${controller.value.playbackSpeed}x',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ))),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
