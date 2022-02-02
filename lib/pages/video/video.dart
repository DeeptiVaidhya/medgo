import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:medgo/pages/video/OverlayWidget.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter/services.dart' show SystemChrome;

class Video extends StatefulWidget {
  final String practiceResourceId;
  final String url;
  Video({Key key, this.practiceResourceId, this.url = ""}) : super(key: key);
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  VideoPlayerController _controller;
  var videoList = [];
  Orientation target;
  var pos;
  var timer;
  var currentTime;
  var totalTime;

  @override
  void initState() {
    initcontroller();
  }

  initcontroller() {
    _controller = VideoPlayerController.network(widget.url)
      ..addListener(() => setState(() {}))
      ..setLooping(false)
      ..initialize().then((value) => _controller.pause());
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) => () {});
    super.initState();
  }

// @override
// didUpdateWidget(){
//   return;

// }

// getPosition(){
//   pos = _controller.value.position.inSeconds;
//   print(pos);
//   if (pos%10==0) {
//     fileTracking();
//   }
//   return true;
// }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setOrientation(bool isPortrait) {
    if (isPortrait) {
      Wakelock.disable();
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    } else {
      Wakelock.enable();
      SystemChrome.setEnabledSystemUIOverlays([]);
    }
  }

  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Container(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: buildVideo(),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget buildVideo() => OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;
          setOrientation(isPortrait);
          return Stack(
            fit: isPortrait ? StackFit.loose : StackFit.expand,
            children: <Widget>[
              buildVideoPlayer(),
              Positioned.fill(
                child: BasicOverlayWidget(
                  controller: _controller,
                  practiceResourceId: widget.practiceResourceId,
                  url: widget.url,
                  onClickedFullScreen: () {
                    target = isPortrait
                        ? Orientation.landscape
                        : Orientation.portrait;
                    if (isPortrait) {
                      AutoOrientation.landscapeRightMode();
                    } else {
                      AutoOrientation.portraitUpMode();
                    }
                  },
                  key: null,
                ),
              ),
            ],
          );
        },
      );

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     children: [
  //      ClipRRect(
  //       borderRadius: BorderRadius.circular(8),
  //       child: VideoPlayerWidget(controller: _controller)),
  //     ],
  //   );
  // }

  Widget buildVideoPlayer() => buildFullScreen(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      );

  Widget buildFullScreen({Widget child}) {
    final size = _controller.value.size;
    final width = size.width;
    final height = size.height;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}
