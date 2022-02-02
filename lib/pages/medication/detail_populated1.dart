import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';

class DetailPopulated1 extends StatefulWidget {
  @override
  _DetailPopulated1State createState() => _DetailPopulated1State();
}

class _DetailPopulated1State extends State<DetailPopulated1> {
  double moodValue = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header("Hydroxyurea", context, true, true, false, true),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  painDateTimeCard(170, 320, "Add date and time"),
               
                Padding(
                  padding: const EdgeInsets.only(bottom: 11,top:22),
                  child: button(true, 320, 54, "Log medication",
                      AppCss.white18bold, AppColors.PINK, () {
                        nextScreen(context,"/medalert");
                      },false),
                ),
                button(true, 320, 54, "Cancel", AppCss.black18bold,
                    AppColors.WHITE, () {      
                      nextScreen(context,"/medicationlist");

                    },true),
                    Padding(
                      padding: const EdgeInsets.only(top:9),
                      child: Text("Question 2 0f 6",style: AppCss.raven14meduim,
                    ))
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
          ismorepageactive = false,
          context)
    );
  }
}
