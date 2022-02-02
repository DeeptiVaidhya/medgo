import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/video/fullscreen-video.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';
import 'MyprogressBar.dart';

class BasicOverlayWidget extends StatefulWidget {
  final String practiceResourceId;
  final VideoPlayerController controller;
  final onClickedFullScreen;
  final String url;
  BasicOverlayWidget(
      {Key key,
      this.controller,
      this.practiceResourceId,
      this.url = "",
      this.onClickedFullScreen})
      : super(key: key);
  @override
  _BasicOverlayWidgetState createState() => _BasicOverlayWidgetState();
}

class _BasicOverlayWidgetState extends State<BasicOverlayWidget> {
  var onClickedFullScreen;
  var position;
  var duration;
  var currentTime;
  var totalTime;
  var practiceResourceId;
  var timer;
  int timerCounter = 0;

  // getPosition(){
  //   fileTracking();
  //   // position =  widget.controller.value.position.inSeconds;
  //   // print(position);
  //   // if (position%10==0) {
  //   //   fileTracking();
  //   // }
  // }

  // Future<void> fileTracking() async {
  //   try {
  //   currentTime = position.inSeconds.toString();
  //   totalTime = duration.inSeconds.toString();

  //   final data = await updatePracticeContent(<String, dynamic>{
  //     "practice_resource_id":widget.practiceResourceId,
  //     "progress_time":currentTime,
  //     "total_time":totalTime,
  //   });
  //   if (data['status'] == "success") {
  //   } else {
  //       if (data['is_valid']) {
  //       setState(() {
  //         Navigator.of(context, rootNavigator: true).pop();
  //       });
  //       toast(data['msg']);
  //     } else {
  //       Navigator.of(context, rootNavigator: true).pop();
  //       errortoast(data['msg']);
  //     }
  //   }
  //  } catch (err) {
  //     Navigator.of(context, rootNavigator: true).pop();
  //     print('Caught error: $err');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    bool isFullScreen = true;
    //final isMuted = widget.controller.value.volume ==0;
    var value = widget.controller.value;
    var possec = value.position.inSeconds - value.position.inMinutes * 60;
    var dursec = value.duration.inSeconds - value.duration.inMinutes * 60;
    //print(value.position.inMinutes.toString()+'.'+ possec.toString());
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => widget.controller.value.isPlaying
          ? widget.controller.pause()
          : widget.controller.play(),
      child: Stack(
        children: [
          buidplay(),
          (isFullScreen == true)
              ? Positioned(
                  bottom: 32,
                  left: 20,
                  right: 40,
                  child: Text(""
                      // value.position.inMinutes.toString() +
                      //     "." +
                      //     possec.toString() +
                      //     "/" +
                      //     value.duration.inMinutes.toString() +
                      //     "." +
                      //     dursec.toString(),
                      // style: AppCss.white8bold,
                      ),
                )
              : Positioned(
                  bottom: 32,
                  left: 20,
                  right: 40,
                  child: Text(""),
                ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 60,
            child: buildIndicator(),
          ),
          Positioned(
            bottom: 2,
            right: 12,
            child: IconButton(
              //icon : Icon(Icons.fullscreen,color: Color(0xFFFEBEBEB),size: 2),
              icon: Image.asset("assets/images/icons/fullscreen/fullscreen.png",
                  width: 0, height: 0),
              onPressed: () {
                if (isFullScreen == true)
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: FullScreenVideo(
                          key: null,
                          practiceResourceId: widget.practiceResourceId,
                          url: widget.url),
                    ),
                  );
                else
                  setState(() {
                    isFullScreen = !isFullScreen;
                  });
                if (isFullScreen == false)
                  setState(() {
                    Navigator.of(context).pop();
                  });
              },
            ),
          ),
        ],
      ),
    );
  }

  VideoProgressColors mcolors = const VideoProgressColors(
      playedColor: Color(0xffF539A5), bufferedColor: Color(0xffCCCCCC));

  Widget buildIndicator() => MyVideoProgressIndicator(widget.controller,
      colors: mcolors, allowScrubbing: true);

  Widget buidplay() => widget.controller.value.isPlaying
      ? Container()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: Container(
              //color: AppColors.WHITE,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100.0),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.SHADOWCOLOR,
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: Offset(0, 4))
                ],
              ),
              child:
                  Icon(Icons.play_arrow, color: Color(0xFF19769F), size: 30)));

  // Container(alignment: Alignment.center,
  //   child: Icon(
  //       Icons.refresh_outlined,
  //       color: Color(0xffFF9A42), size: 50,
  //     ),
  // )
}
