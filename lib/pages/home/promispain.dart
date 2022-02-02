import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/home/assessment_complete.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';
import 'package:medgo/services/home.dart';

class PromisPain extends StatefulWidget {
  @override
  _PromisPainState createState() => _PromisPainState();
}

class _PromisPainState extends State<PromisPain> {
  var queData;
  var mainServeyData;

  bool refresh = false;
  bool isLoading = false;
  var nextQuedata;
  double sliderValue = 3;
  GlobalKey<State> _myKey = GlobalKey();
  Future<void> getQueNext(mainData, queData) async {
    setState(() {
      isLoading = true;
    });
    print("object");
    print(mainData);
    if (mainData['responseFormat'] == 'likert') {
      try {
        final data = await getNextServeyQue(<String, dynamic>{
          "assessmentOID": mainData['assessmentOID'],
          "sessionId": mainData['sessionId'],
          "qaId": mainData['qaId'],
          "itemResponseOID":
              mainData['allowSkip'] == "true" ? "" : queData['itemResponseOID'],
          "label": mainData['allowSkip'] == "true" ? "" : queData['label'],
          "value": mainData['allowSkip'] == "true" ? "" : queData['value'],
          "textAnswer": "",
          "questionId": mainData['question_id'],
          "responseFormat": mainData['responseFormat'],
        });

        // final Map<dynamic, dynamic> queData = json.decode(data);
        // print("next Que data");
        // print(data);
        // setState(() {
        //   isLoading = false;
        // });
        if (data['status'] == "success") {
          // print("done flag");
          // print(data['result']['doneFlag'] == true);
          if (data['result']['doneFlag'] == true) {
            print("should redirect........>>>>>>");
            setState(() {
              refresh = false;
            });
            nextScreen(context, "/assessment-complete");
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AssessmentComplete(),
            //   ),
            // );
          } else {
            setState(() {
              refresh = true;
              nextQuedata = data['result'];
              isLoading = false;
            });
          }

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => PromisPain(),
          //     settings: RouteSettings(arguments: data['result']),
          //   ),
          // );
        } else {
          if (data['is_valid'] == false) {
            setState(() {
              Navigator.of(context, rootNavigator: true).pop();
            });
            //Navigator.of(context, rootNavigator: true).pop();
          }
        }
      } catch (err) {
        Navigator.of(context, rootNavigator: true).pop();
        print('Caught error: $err');
      }
    } else {
      try {
        // print("main data>>>>>>>>>>>");
        // print(mainData);
        final data = await getNextServeyQue(<String, dynamic>{
          "assessmentOID": mainData['assessmentOID'],
          "sessionId": mainData['sessionId'],
          "qaId": mainData['qaId'],
          "itemResponseOID": "",
          "label": "",
          "value": mainData['allowSkip'] == "true" ? "" : sliderValue,
          "textAnswer": "",
          "doneFlag": mainData['doneFlag'],
          "questionId": mainData['question_id'],
          "responseFormat": mainData['responseFormat'],
        });

        // final Map<dynamic, dynamic> queData = json.decode(data);
        print("next Que data rating");
        print(data);

        if (data['status'] == "success") {
          if (data['result']['doneFlag'] == true) {
            print("should redirect........>>>>>>");
            setState(() {
              refresh = false;
            });
            nextScreen(context, "/assessment-complete");
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AssessmentComplete(),
            //   ),
            // );
          } else {
            setState(() {
              isLoading = false;
              queData = data['result'];
              refresh = true;
              nextQuedata = data['result'];
            });
          }
        } else {
          if (data['is_valid'] == false) {
            setState(() {
              Navigator.of(context, rootNavigator: true).pop();
            });
            //Navigator.of(context, rootNavigator: true).pop();
          }
        }
      } catch (err) {
        Navigator.of(context, rootNavigator: true).pop();
        print('Caught error:slider $err');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    queData = ModalRoute.of(context).settings.arguments;

    mainServeyData = queData;

    ///print(queData);
    return Scaffold(
        appBar: header("Pain", context, true, true, false, true),
        body: SingleChildScrollView(
            key: _myKey,
            child: isLoading != true
                ? mainServeyData != null
                    ? mainServeyData['responseFormat'] == 'likert'
                        ? likertContainer(context, mainServeyData)
                        : mainServeyData['responseFormat'] == 'rating'
                            ? sliderQueCard(context, mainServeyData)
                            : Text("no data")
                    : Text("No Data")
                : LinearProgressIndicator()),
        bottomNavigationBar: footer(
            ishomepageactive = false,
            iseducationpageactive = false,
            isteampageactive = false,
            isnotificationpageactive = false,
            ismorepageactive = false,
            context));
  }

  Container sliderQueCard(BuildContext context, data) {
    if (refresh == true) {
      setState(() {
        data = nextQuedata;
      });
    }
    return (data['responseFormat'] == 'rating')
        ? Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 40, bottom: 10, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            data['introduction'].toString(),
                            textAlign: TextAlign.left,
                            style: AppCss.black20bold,
                          ),
                        ),
                        Text(data['questionText'].toString(),
                            style: AppCss.raven14meduim),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            height: 114,
                            child: Card(
                              elevation: 01,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 0, top: 12, bottom: 6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data['minMeaning'].toString(),
                                          style: AppCss.black12bold,
                                        ),
                                        Text(
                                          data['maxMeaning'].toString(),
                                          style: AppCss.black12bold,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        trackHeight: 2,
                                        inactiveTrackColor: Color(0xFFCCD1D9),
                                        activeTrackColor: AppColors.AQUA_BLUE,
                                        thumbColor: AppColors.AQUA_BLUE,
                                        thumbShape: RoundSliderThumbShape(
                                            enabledThumbRadius: 9.0),
                                        overlayShape: RoundSliderOverlayShape(
                                            overlayRadius: 9.0),
                                      ),
                                      child: Slider(
                                        value: sliderValue,
                                        min: data['minDigit'],
                                        max: data['maxDigit'],
                                        divisions: data['maxDigit'] - 1,
                                        onChanged: (newvalue) {
                                          setState(() {
                                            sliderValue = newvalue;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5, left: 143),
                                    child: Text(
                                      sliderValue.toString(),
                                      style: AppCss.sky16bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 129),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              data['allowSkip'] == true
                                  ? button(
                                      true,
                                      100,
                                      33,
                                      "Skip",
                                      AppCss.raven14bold,
                                      Color(0xffCCD1D9), () {
                                      getQueNext(data, null);
                                    }, false)
                                  : Container(),
                              button(true, 100, 33, "Finish",
                                  AppCss.black14bold, AppColors.AQUA_BLUE, () {
                                getQueNext(data, null);
                                // nextScreen(context, "/assessment-complete");
                              }, false),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : likertContainer(context, data);
  }

  // Card buildCard(BuildContext context) {
  //   return
  // }

  Container likertContainer(BuildContext context, data) {
    // print(data['selectionOptions']);

    print("refresh");
    print(refresh);
    if (refresh == true) {
      setState(() {
        data = nextQuedata;
      });
    }

    if (data['doneFlag'] == "true") {
      print("should redirect........>>>>>>");
      nextScreen(context, "/assessment-complete");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => AssessmentComplete(),
      //   ),
      // );
    }
    return (data['responseFormat'] == 'likert')
        ? Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 40, bottom: 10, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            data['questionText'],
                            textAlign: TextAlign.center,
                            style: AppCss.black20bold,
                          ),
                        ),
                        Container(
                          height: 400,
                          child: ListView.builder(
                            itemCount: data['selectionOptions'].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: confirmButton(280, 52,
                                    data['selectionOptions'][index]['label'],
                                    () {
                                  if (data['doneFlag'] == "true") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AssessmentComplete(),
                                      ),
                                    );
                                  } else {
                                    getQueNext(
                                        data, data['selectionOptions'][index]);
                                  }

                                  // print(data['selectionOptions'][index]['value']);
                                }),
                              );
                            },
                          ),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10),
                        //   child: confirmButton(280, 52, "Almost Never", () {}),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10),
                        //   child: confirmButton(280, 52, "Sometimes", () {}),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10),
                        //   child: confirmButton(280, 52, "Often", () {}),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10, bottom: 20),
                        //   child: confirmButton(280, 52, "Almost Always", () {}),
                        // ),
                        data['allowSkip'] == "true"
                            ? button(true, 100, 33, "Skip", AppCss.raven14bold,
                                Color(0xffCCD1D9), () {
                                // Navigator.pop(context);
                                getQueNext(data, null);
                              }, false)
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : sliderQueCard(context, data);
  }

  Container textContainer(BuildContext context) {
    // print(data['selectionOptions']);

    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 10, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                  ),
                  Container(height: 400, child: Text("sasa")),

                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10),
                  //   child: confirmButton(280, 52, "Almost Never", () {}),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10),
                  //   child: confirmButton(280, 52, "Sometimes", () {}),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10),
                  //   child: confirmButton(280, 52, "Often", () {}),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10, bottom: 20),
                  //   child: confirmButton(280, 52, "Almost Always", () {}),
                  // ),
                  button(true, 100, 33, "Skip", AppCss.raven14bold,
                      Color(0xffCCD1D9), () {
                    // Navigator.pop(context);
                  }, false)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
