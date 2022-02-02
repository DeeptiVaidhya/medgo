import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/video/video.dart';
import 'package:medgo/pages/widget/helper.dart';

class FullScreenVideo extends StatefulWidget {
  final String practiceResourceId;
  final String url;
  FullScreenVideo({Key key, this.practiceResourceId, this.url = ""})
      : super(key: key);

  @override
  _FullScreenVideoState createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<FullScreenVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.AQUA_BLUE,
      appBar: AppBar(toolbarHeight: 0),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(right: 10.0, top: 11),
              child: IconButton(
                icon: Icon(Icons.close, color: AppColors.WHITE),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 30, left: 20, right: 20),
              child: Text(
                'For the best viewing experience, please turn your phone to landscape mode.',
                // style: AppCss.white14medium,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                // constraints: BoxConstraints(
                //   maxWidth: 375,
                // ),
                margin: EdgeInsets.only(left: 0, right: 0, top: 16),
                child: Video(
                    practiceResourceId: widget.practiceResourceId,
                    url: widget.url)),
            Padding(
              padding: const EdgeInsets.only(top: 80, bottom: 30, left: 54, right: 46),
              child: buttion(
                  btnwidth = 275,
                  btnheight = 44,
                  btntext = 'close this window'.toUpperCase(),
                  AppCss.white18bold,
                  AppColors.PINK,
                  btntypesubmit = true, () {
                Navigator.of(context).pop();
              }, 12, 12, 15, 13, context),
            ),
          ]),
        ),
      ),
    );
  }
}
