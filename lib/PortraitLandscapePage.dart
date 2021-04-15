import 'package:flutter/material.dart';
import 'package:fullscreen/VideoPlayer.dart';
import 'package:video_player/video_player.dart';
import 'VideoPlayer.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

class PortraitLandscapePlayerPage extends StatefulWidget with ChangeNotifier {
  @override
  _PortraitLandscapePlayerPageState createState() =>
      _PortraitLandscapePlayerPageState();
}

class _PortraitLandscapePlayerPageState
    extends State<PortraitLandscapePlayerPage> {
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    final FlutterFFprobe _probe = new FlutterFFprobe();

    _probe
        .getMediaInformation(
            'https://player.vimeo.com/external/535944008.m3u8?s=aafab02f4e073ca3c6bdb1306139678a2455c8e8')
        .then((i) => print(i));
    /*controller = VideoPlayerController.network(
        'https://player.vimeo.com/external/535944008.m3u8?s=aafab02f4e073ca3c6bdb1306139678a2455c8e8')
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());*/
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: VideoPlayerBothWidget(controller: controller),
    );
  }
}
