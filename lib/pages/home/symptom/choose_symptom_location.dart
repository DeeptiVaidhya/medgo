import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';

class ChooseSymptomLocation extends StatefulWidget {
  @override
  _ChooseSymptomLocationState createState() => _ChooseSymptomLocationState();
}

class _ChooseSymptomLocationState extends State<ChooseSymptomLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          header("Tell us how you feel now", context, true, true, false, true),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30,bottom: 14),
                  child: Text(
                    "Click on any body area where you are feeling pain right now, then click “Next”",
                    style: AppCss.raven12meduim,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 17.17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/icons/boyfront.png"),

                      Padding(
                        padding: const EdgeInsets.only(left: 17.82),
                        child: Image.asset("assets/images/icons/boyback.png"),
                      )
                    ],
                  ),
                ),
                button(false, 320, 54, "Next", AppCss.grey18bold, Color(0xffE6E9EE), (){},false)
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
