import 'dart:developer';

import 'package:ffmpeg_kit_flutter_video/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_video/log.dart';
import 'package:ffmpeg_kit_flutter_video/session.dart';
import 'package:ffmpeg_kit_flutter_video/statistics.dart';
import 'package:flutter/material.dart';
import 'package:i_stil/app/modules/video_merge_screen/video_merge_screen.dart';
import 'package:i_stil/app/providers/loading_provider.dart';
import 'package:i_stil/app/repositories/ffmpeg_repository/ffmpeg_commands.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class FfmpegRepository {
  Future<bool> mergeVideos({
    required Function() callback,
    required String firstVideoPath,
    required String secondVideoPath,
    required int fps,
    required String resolution,
  }) async {
    String _fileName = firstVideoPath.split("/").last.split(".").first +
        secondVideoPath.split("/").last.split(".").first +
        "_" +
        DateTime.now().millisecondsSinceEpoch.toString();
    String _txtFile = (await localFile).path;
    var res = await FFmpegKit.executeAsync(
        // ffmpegCommands.videoMergeCommand(
        //   firstPath: firstVideoPath,
        //   secondPath: secondVideoPath,
        //   outputPath:
        //       (await getExternalStorageDirectory())!.path + "/$fileName.mp4",
        //   fps: fps,
        //   resolution: resolution,
        // )
        ffmpegCommands.videoMergetxtCommand(
          fileName: _txtFile,
          outputPath:
              (await getExternalStorageDirectory())!.path + "/$_fileName.mp4",
          fps: fps,
          resolution: resolution,
        ), (Session session) async {
      log("Successfully Merged Videos ${await session.getAllLogsAsString()}");
      var x = await session.getReturnCode();

      callback();
      print(x);
      // CALLED WHEN SESSION IS EXECUTED
    }, (Log log) {
      print(log.getMessage());
      // CALLED WHEN SESSION PRINTS LOGS
    }, (Statistics statistics) {
      print("Statics: getTime ${statistics.getTime()}");
      print("Statics: getSpeed ${statistics.getSpeed()}");
      print("Statics: getBitrate ${statistics.getBitrate()}");
      print("Statics: getVideoQuality ${statistics.getVideoQuality()}");
      // callback();
      // CALLED WHEN SESSION GENERATES STATISTICS
    });
    log(await res.getLogsAsString());
    log((await res.getEndTime()).toString());
    return true;
  }
}
