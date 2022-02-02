import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/helper.dart';

class MedAlert extends StatefulWidget {
  @override
  _MedAlertState createState() => _MedAlertState();
}

class _MedAlertState extends State<MedAlert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: AppColors.AQUA_BLUE,
          child: popupDialog(
            580,
            300,
            popupContent(),
          )),
    );
  }

  Column popupContent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 260),
          child: GestureDetector(
              onTap: () {
                nextScreen(context,"/home");
              },
              child: Icon(
                Icons.clear_sharp,
                size: 30,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 103, bottom: 22),
          child: Container(height: 129, child: Text("")),
        ),
        Text(
          "Try, try again!",
          style: AppCss.black22bold,
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 99),
          child: Container(
            child: Text(
              "You've logged some of your medicine (< 60%), I know you can do better, right?!",
              textAlign: TextAlign.center,
              style: AppCss.black16regular,
            ),
          ),
        ),
        button(true, 240, 54, "Okay", AppCss.white18bold, AppColors.PINK, () {
          nextScreen(context, "/home");
        }, false)
      ],
    );
  }
}
