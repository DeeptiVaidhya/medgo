import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';

class FatigueIntensity extends StatefulWidget {
  @override
  _FatigueIntensityState createState() => _FatigueIntensityState();
}

class _FatigueIntensityState extends State<FatigueIntensity> {
  double tiredValue = 6;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          header("How tired are you now?", context, true, true, false, true),
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
                        "Tell us how tired you are right now using the sliding scale 0-10 below",
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
                        "Not tired at all (0)",
                        "Very tired (10)",
                        tiredValue, (newvalue) {
                      setState(() {
                        tiredValue = newvalue;
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
