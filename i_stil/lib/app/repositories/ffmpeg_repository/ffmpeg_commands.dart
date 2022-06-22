import 'package:path_provider/path_provider.dart';

class ffmpegCommands {
  static String videoMergeCommand({
    required String firstPath,
    required String secondPath,
    required String outputPath,
    required int fps,
    required String resolution,
  }) {
    print(firstPath);
    print(secondPath);
    print(outputPath);
    return '-i $firstPath -i $secondPath -preset ultrafast -r $fps -filter_complex "[0]scale=$resolution:force_original_aspect_ratio=decrease,pad=$resolution:(ow-iw)/2:(oh-ih)/2,setsar=1[0v];[1]scale=$resolution:force_original_aspect_ratio=decrease,pad=$resolution:(ow-iw)/2:(oh-ih)/2,setsar=1[1v];[0v][0:a][1v][1:a]concat=n=2:v=1:a=1[v][a]" -vsync 2 -map "[v]" -map "[a]" $outputPath';
    // return "-i $firstPath -i $secondPath -filter_complex '[0:v]scale=$resolution,pad=$resolution[0:a][1:v]scale=$resolution[1:a] concat=n=2:v=1:a=1 [outv] [outa]' -map '[outv]' -map '[outa]' $outputPath";
    // return '-i "concat:/storage/emulated/0/Download/2.mp4|/storage/emulated/0/Download/1.mp4" -c:v -c:a copy $outputPath';
  }

  static String videoMergetxtCommand({
    required String fileName,
    required String outputPath,
    required int fps,
    required String resolution,
  }) {
    print(fileName);

    print(outputPath);

    return '-f concat -safe 0 -i $fileName -c copy $outputPath';
    // return "-i $firstPath -i $secondPath -filter_complex '[0:v]scale=$resolution,pad=$resolution[0:a][1:v]scale=$resolution[1:a] concat=n=2:v=1:a=1 [outv] [outa]' -map '[outv]' -map '[outa]' $outputPath";
    // return '-i "concat:/storage/emulated/0/Download/2.mp4|/storage/emulated/0/Download/1.mp4" -c:v -c:a copy $outputPath';
  }
}

//  _CutVideoCommand =
//             '$_trimLengthCommand -vf "fps=$fpsGIF,scale=$scaleGIF:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 ';