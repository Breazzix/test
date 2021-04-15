import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';
import 'models/TextOverlay.dart';
import 'package:battery/battery.dart';

class AdvancedOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onClickedFullScreen;
  final battery = Battery();

  static const allSpeeds = <double>[0.25, 0.5, 1, 1.5, 2, 3, 5, 10];

  AdvancedOverlayWidget({
    Key key,
    @required this.controller,
    this.onClickedFullScreen,
  }) : super(key: key);

  String getPosition() {
    final duration = Duration(
        milliseconds: controller.value.position.inMilliseconds.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () =>
          controller.value.isPlaying ? controller.pause() : controller.play(),
      child: Stack(
        children: <Widget>[
          buildPlay(),
          //buildSpeed(),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width/4, maxWidth: MediaQuery.of(context).size.width/4, minHeight: MediaQuery.of(context).size.height),
              color: Colors.black45,
              padding: EdgeInsets.all(6),
              child: Consumer<TextOverlay>(
                builder: (_, message, __) => Column(
                  children: [
                    Text(
                      '${message.message}',
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '${message.message}',
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
         /* Positioned(
            bottom: MediaQuery.of(context).size.width/5,
            right: 0,
            child: Container(
              child: SpinKitRotatingCircle(
                color: Colors.white,
                size: 80,
              ),
            ),
          ),*/
          Positioned(
            left: 10,
            top: 10,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                  ),
                  color: Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              constraints: BoxConstraints(minWidth: 40, maxWidth: 40),
              padding: EdgeInsets.all(10),
              child: Center(
                child: Consumer<TextOverlay>(
                  builder: (_, message, __) => Text(
                    '${message.repsNumber}',
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 8,
            bottom: 28,
            child: Text(getPosition()),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Expanded(child: buildIndicator()),
                const SizedBox(width: 12),
                GestureDetector(
                  child: Icon(
                    Icons.fullscreen,
                    color: Colors.white,
                    size: 28,
                  ),
                  onTap: onClickedFullScreen,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() => Container(
        margin: EdgeInsets.all(8).copyWith(right: 0),
        height: 16,
        child: VideoProgressIndicator(
          controller,
          allowScrubbing: true,
        ),
      );

  /*Widget buildSpeed() => Align(
        alignment: Alignment.topRight,
        child: PopupMenuButton<double>(
          initialValue: controller.value.playbackSpeed,
          tooltip: 'Playback speed',
          onSelected: controller.setPlaybackSpeed,
          itemBuilder: (context) => allSpeeds
              .map<PopupMenuEntry<double>>((speed) => PopupMenuItem(
                    value: speed,
                    child: Text('${speed}x'),
                  ))
              .toList(),
          child: Container(
            color: Colors.white38,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Text('${controller.value.playbackSpeed}x'),
          ),
        ),
      );*/

  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
          color: Colors.black26,
          child: Center(
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 70,
            ),
          ),
        );
}
