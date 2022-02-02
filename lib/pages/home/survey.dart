import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/home/promispain.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';
import 'package:medgo/services/home.dart';

class Survey extends StatefulWidget {
  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  final GlobalKey<State> _keyLoading = new GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    checkLoginToken(context);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => loader(context, _keyLoading));
    Future.delayed(Duration.zero, () {
      surveyList();
    });
  }

  bool isLoading = false;
  var surveyDataList = [];
  Future<void> surveyList() async {
    try {
      final data = await getSurveyList(<String, dynamic>{});
      // print(data['result']);
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          surveyDataList = data['result'];
        });
      } else {
        if (data['is_valid'] == false) {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          Navigator.pushNamed(context, '/signin');
        } else {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          Navigator.pushNamed(context, '/edit-profile');
          errortoast(data['msg']);
        }
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();
      print('Caught error: $err');
    }
  }

  Future<void> getQueFirst(id) async {
    setState(() {
      isLoading = true;
    });
    print("id" + id.toString());
    try {
      final data =
          await getFirstServeyQue(<String, dynamic>{"id": id.toString()});

      // final Map<dynamic, dynamic> queData = json.decode(data);
      print(data);
      if (data != null) {
        setState(() {
          isLoading = false;
          if (data['status'] == "success") {
          } else {
            Fluttertoast.showToast(
                msg: "No Question Found in This servey",
                toastLength: Toast.LENGTH_LONG);
          }
        });
      }
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          isLoading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PromisPain(),
            settings: RouteSettings(arguments: data['result']),
          ),
        );
      } else {
        if (data['is_valid'] == false) {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          Navigator.of(context, rootNavigator: true).pop();
        }
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();
      print('Caught error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            header("Take a health survey", context, true, true, false, true),
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: isLoading != true
                  ? surveyDataList != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            height: 500,
                            child: surveyDataList.length > 0
                                ? ListView.builder(
                                    itemBuilder: (context, index) {
                                      return buildContainer(
                                          surveyDataList[index]['title'], () {
                                        // nextScreen(context, "/promispain");
                                        getQueFirst(surveyDataList[index]['id']
                                            .toString());
                                      });
                                    },
                                    itemCount: surveyDataList.length,
                                  )
                                : Text("No data......"),
                          ),
                        )
                      : Text("No data........")
                  : Center(child: LinearProgressIndicator()),
            ),
          ),
        ),
        bottomNavigationBar: footer(
            ishomepageactive = false,
            iseducationpageactive = false,
            isteampageactive = false,
            isnotificationpageactive = false,
            ismorepageactive = false,
            context));
  }

  Widget buildContainer(text, onTab) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: SizedBox(
        height: 62,
        width: 320,
        child: GestureDetector(
          onTap: onTab,
          child: Card(
            elevation: 03,
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: AppCss.black18bold,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColors.AQUA_BLUE,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// child: Column( 
//                   children: [
//                     buildContainer("Survey 1", () {
//                       nextScreen(context, "/promispain");
//                     }),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 5),
//                       child: buildContainer("Survey 2", () {
//                         nextScreen(context, "/illness-perceptions");
//                       }),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 5),
//                       child: buildContainer("Survey 3", () {
//                         nextScreen(context, "/stigma");
//                       }),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 5),
//                       child: buildContainer("Survey 4", () {
//                         nextScreen(context, "/stigma");
//                       }),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 5),
//                       child: buildContainer("Survey 5", () {
//                         nextScreen(context, "/stigma");
//                       }),
//                     ),
//                   ],
//                 ),