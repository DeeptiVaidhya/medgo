import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';

class LogNext extends StatefulWidget {
  @override
  _LogNextState createState() => _LogNextState();
}

class _LogNextState extends State<LogNext> {
  double moodValue = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header("Symptom logged", context, true, true, false, true),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 22),
            child: Column(
              children: [
                Container(
                  height: 140,
                  width: 320,
                  child: Card(
                    elevation: 04,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24, left: 10),
                      child: ListTile(
                        horizontalTitleGap: 19,
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Well done!",
                            style: AppCss.black18bold,
                          ),
                        ),
                        leading: SizedBox(
                            width: 40,
                            child: Image.asset("assets/images/icons/pain.png")),
                        subtitle: Text(
                          "You’re doing a great job of logging your symptoms - keep up the good work!",
                          style: AppCss.raven12meduim,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 23, bottom: 20),
                  child: Text(
                    "What would you like to do next?",
                    style: AppCss.raven12bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 11),
                  child: button(true, 320, 54, "Log another symptom",
                      AppCss.white18bold, AppColors.PINK, () {
                        nextScreen(context,"/choose-symptom");
                      },false),
                ),
                button(true, 320, 54, "Go back home", AppCss.black18bold,
                    AppColors.WHITE, () {
                      nextScreen(context,"/home");
                    },true),
              ],
            ),
          ),
        ),
      ),
       bottomNavigationBar: footer(
          ishomepageactive = false,
          iseducationpageactive = false,
          isteampageactive = false,
          isnotificationpageactive=false,
          ismorepageactive = true,
          context)
    );
  }
}
