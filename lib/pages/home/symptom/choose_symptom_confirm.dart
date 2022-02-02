import 'package:flutter/material.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';

import '../../app-css.dart';

class ChooseSymptomConfirm extends StatefulWidget {
  @override
  _ChooseSymptomConfirmState createState() => _ChooseSymptomConfirmState();
}

class _ChooseSymptomConfirmState extends State<ChooseSymptomConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          header("Tell us how you feel now", context, true, true, false, true),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Do you have pain now?",
                  style: AppCss.black20bold,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      confirmButton(130, 52, "Yes", () {
                        nextScreen(context,"/choose-symptom-location");
                      }),
                      SizedBox(width: 20,),
                      confirmButton(130, 52, "No", () {
                          nextScreen(context,"/lognext");
                      }),
                    ],
                  ),
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
