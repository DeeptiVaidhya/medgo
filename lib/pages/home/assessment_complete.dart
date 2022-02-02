import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';

class AssessmentComplete extends StatefulWidget {
  @override
  _AssessmentCompleteState createState() => _AssessmentCompleteState();
}

class _AssessmentCompleteState extends State<AssessmentComplete> {
  @override
  Widget build(BuildContext context) {
    // final seveydataMap = ModalRoute.of(context).settings.arguments;
    // print(seveydataMap);
    return Scaffold(
        appBar: header("Well done!", context, true, true, false, true),
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 220,
                      width: 320,
                      child: Card(
                        elevation: 04,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 40, bottom: 14, left: 30, right: 30),
                              child: Text(
                                "You have successfully completed your health survey!",
                                textAlign: TextAlign.center,
                                style: AppCss.black18bold,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              // child: Text(
                              //   "Your next assessment will be sent to you on September 26th, 2020.",
                              //   textAlign: TextAlign.center,
                              //   style: AppCss.raven14meduim,
                              // ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: button(true, 320, 54, "Go back Home",
                          AppCss.white18bold, AppColors.PINK, () {
                        nextScreen(context, "/home");
                      }, false),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: footer(
            ishomepageactive = false,
            iseducationpageactive = false,
            isteampageactive = false,
            isnotificationpageactive = false,
            ismorepageactive = true,
            context));
  }
}
