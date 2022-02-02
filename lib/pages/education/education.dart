import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/video/video.dart';
//import 'package:medgo/pages/video/video.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/services/educationService.dart';

class Education extends StatefulWidget {
  @override
  _EducationState createState() => _EducationState();
}

ScrollController _controller;

class _EducationState extends State<Education> {
  @override
  void initState() {
    getList();
    _controller = ScrollController();
    super.initState();
  }

  AudioPlayer audioPlayer = AudioPlayer();
  final AudioPlayer player = AudioPlayer();
  List educationData;
  //var url = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
  bool isAuidoplayed = false;
  bool isLoading = true;
  playAudio(var url) async {
    await player.setUrl(url);

    await player.play();
    setState(() {
      isAuidoplayed = true;
    });

    // int result = await audioPlayer.play(url);
    // if (result == 1) {
    //   setState(() {
    //     isAuidoplayed = true;
    //   });
    // } else {}
  }

  pauseAudio() async {
    try {
      await player.pause();
      setState(() {
        isAuidoplayed = false;
      });
    } catch (e) {}

    // int resultstop = await audioPlayer.pause();
    // if (resultstop == 1) {}
  }

  Future<void> getList() async {
    try {
      final data = await getEducationData(<String, dynamic>{});
      if (data['status'] == "success") {
        setState(() {
          // Navigator.of(context, rootNavigator: true).pop();
          educationData = data['result'];
          isLoading = false;
        });
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();
      print('Caught error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    final scrollKey = new GlobalKey();
    double dwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: header("Education", context, true, true, false, true),
        body: SingleChildScrollView(
          key: scrollKey,
          child: Center(
              child: isLoading
                  ? LinearProgressIndicator()
                  : Container(
                      margin: EdgeInsets.only(top: 20, right: 20),
                      height: 400,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            Container(margin: EdgeInsets.only(left: 10)),
                        itemCount: educationData.length,
                        itemBuilder: (context, index) =>
                            mainModleCard(dwidth, educationData[index]),
                      ),
                    )),
        ),
        bottomNavigationBar: footer(
            ishomepageactive = false,
            iseducationpageactive = true,
            isteampageactive = false,
            isnotificationpageactive = false,
            ismorepageactive = false,
            context));
  }

  ClipRRect mainModleCard(double dwidth, var mainData) {
    return mainData != null
        ? ClipRRect(
            borderRadius: new BorderRadius.circular(5.0),
            child: Center(
              child: Stack(
                children: [
                  Container(
                    width: 375,
                    height: 170,
                    margin: const EdgeInsets.only(top: 10, left: 20.0),
                    decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 26.0,
                              color: Color(0xff57C5FF).withOpacity(0.7))),
                    ),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              left: 15,
                            ),
                            child: Text(mainData['module_name'].toString(),
                                style: AppCss.black18bold,
                                textAlign: TextAlign.left),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 20,
                              right: 10,
                            ),
                            child: SizedBox(
                              height: 120,
                              child: mainData['resources']['result'].length > 0
                                  ? ListView.separated(
                                      separatorBuilder: (BuildContext context,
                                              int index) =>
                                          Container(
                                              margin:
                                                  EdgeInsets.only(left: 10)),
                                      itemCount: mainData['resources']['result']
                                          .length,
                                      controller: _controller,
                                      scrollDirection: Axis.horizontal,
                                      // ignore: missing_return
                                      itemBuilder: (context, index) {
                                        if (mainData['resources']['result']
                                                [index]['type'] ==
                                            'AUDIO') {
                                          return audioCard(mainData['resources']
                                              ['result'][index]);
                                        } else {
                                          if (mainData['resources']['result']
                                                  [index]['type'] ==
                                              'VIDEO') {
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: videoCard(
                                                  mainData['resources']
                                                      ['result'][index]),
                                            );
                                          } else {
                                            return Text("No data type found");
                                          }
                                        }
                                      },
                                    )
                                  : Center(child: Text("No data")),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  (dwidth > 416)
                      ? Positioned(
                          left: 370,
                          top: 80,
                          child: GestureDetector(
                              onTap: () {
                                _controller.jumpTo(_controller.offset + 1);
                              },
                              child: Icon(Icons.arrow_forward_ios_outlined,
                                  color: AppColors.WHITE, size: 24)))
                      : Positioned(
                          left: dwidth - 45,
                          top: 80,
                          child: GestureDetector(
                              onTap: () {
                                _controller.jumpTo(_controller.offset + 7);
                              },
                              child: Icon(Icons.arrow_forward_ios_outlined,
                                  color: AppColors.WHITE, size: 24))),
                ],
              ),
            ),
          )
        : Text("No data");
  }

  SizedBox videoCard(var videoData) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Color(0xffD5D5D5),
                    )),
                child: videoData['file_url'] != null
                    ? Container(
                        width: 70,
                        height: 70,
                        child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: 70,
                              child: AspectRatio(
                                aspectRatio: 4 / 3,
                                child: Video(
                                  practiceResourceId: '1',
                                  url: videoData['file_url'].toString(),
                                ),
                              ),
                            )),
                      )
                    : Container(
                        child: Center(
                            child: Text(
                        "No data",
                        textAlign: TextAlign.center,
                        style: AppCss.lightblack10bold,
                      )))),
          ),
          SizedBox(
            width: 70,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                "Lorem ipsum Dolor Sit",
                textAlign: TextAlign.center,
                style: AppCss.lightblack10bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  SizedBox audioCard(var audioData) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Color(0xffD5D5D5),
                )),
            child: audioData['file_url'] != null
                ? SizedBox(
                    height: 70,
                    width: 70,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.SHADOWCOLOR,
                        borderRadius: BorderRadius.circular(100.0),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.SHADOWCOLOR,
                              spreadRadius: 0,
                              blurRadius: 7,
                              offset: Offset(0, 4))
                        ],
                      ),
                      child: GestureDetector(
                        child: !isAuidoplayed
                            ? Image.asset("assets/images/icons/speaker.png")
                            : Icon(Icons.pause,
                                color: Color(0xFF19769F), size: 30),
                        onTap: () {
                          if (isAuidoplayed == false) {
                            playAudio(audioData['file_url']);
                          } else {
                            pauseAudio();
                          }
                        },
                      ),
                    ),
                  )
                : Container(
                    width: 70,
                    height: 70,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        "No data",
                        textAlign: TextAlign.center,
                        style: AppCss.lightblack10bold,
                      ),
                    ))),
          ),
          SizedBox(
            width: 70,
            child: audioData['file_url'] != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      "Lorem ipsum Dolor Sit",
                      textAlign: TextAlign.center,
                      style: AppCss.lightblack10bold,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      "No data",
                      textAlign: TextAlign.center,
                      style: AppCss.lightblack10bold,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
