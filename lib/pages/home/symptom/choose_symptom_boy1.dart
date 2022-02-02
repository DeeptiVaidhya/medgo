import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';

class ChooseSymptomBoy1 extends StatefulWidget {
  @override
  _ChooseSymptomBoy1State createState() => _ChooseSymptomBoy1State();
}

class _ChooseSymptomBoy1State extends State<ChooseSymptomBoy1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header("Tell us how you feel now", context, true, true, false, true),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Choose a symptom from the options below",
                  style: AppCss.raven12meduim,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      symptomCard(170, 150,
                          Image.asset("assets/images/icons/pain.png"), "Pain",(){
                            nextScreen(context,"/choose-symptom-confirm");
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      symptomCard(
                          170,
                          150,
                          Image.asset("assets/images/icons/energy-level.png"),
                          "Energy Level",(){
                             nextScreen(context,"/fatigue-intensity");
                          }),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    symptomCard(170, 150,
                        Image.asset("assets/images/icons/mood.png"), "Mood",(){
                          nextScreen(context,"/mood-intensity");
                        }),
                    SizedBox(
                      width: 20,
                    ),
                    symptomCard(
                        170,
                        150,
                        Image.asset("assets/images/icons/stress.png"),
                        "Stress",(){
                          nextScreen(context,"/stress-intensity");
                        }),
                  ],
                ),
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
