import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';

class StressIntensity extends StatefulWidget {
  @override
  _StressIntensityState createState() => _StressIntensityState();
}

class _StressIntensityState extends State<StressIntensity> {
  double moodValue = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          header("How is your stress level now?", context, true, true, false, true),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 26),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 6),
                    child: Container(
                      width: 300,
                      child: Text(
                        "Tell us how stressed you are right now using the sliding scale 0-10 below",
                        style: AppCss.raven12meduim,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    child: sliderCard(
                        context,
                        150,
                        320,
                        "",
                        "Not stressed at all (0)",
                        "Very stressed (10)",
                        moodValue, (newvalue) {
                      setState(() {
                        moodValue = newvalue;
                      });
                    }),
                  ),
                  painDateTimeCard(170, 320, "Add date and time"),
                  Padding(
                    padding: const EdgeInsets.only(top: 31, bottom: 20),
                    child: button(true, 320, 54, "Save", AppCss.white18bold,
                        AppColors.PINK, () {
                            nextScreen(context,"/lognext");
                        },false),
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
          isnotificationpageactive=false,
          ismorepageactive = true,
          context)
    );
  }
}
