import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/helper.dart';

class AlertTrophy extends StatefulWidget {
  @override
  _AlertTrophyState createState() => _AlertTrophyState();
}

class _AlertTrophyState extends State<AlertTrophy> {
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
          padding: const EdgeInsets.only(top: 118, bottom: 45),
          child: Image.asset("assets/images/trophyalert/trophy1.png"),
        ),
        Text(
          "You’ve won a trophy!",
          style: AppCss.black22bold,
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 24, left: 20, right: 20, bottom: 86),
          child: Container(
            child: Text(
              "You are a superstar!! WOOHOO! You’ve earned 5 badges, you deserve a trophy!!!",
              textAlign: TextAlign.center,
              style: AppCss.black16regular,
            ),
          ),
        ),
        button(true,240, 54, "Okay", AppCss.white18bold, AppColors.PINK, () {
          nextScreen(context,
          "/home");
        },false)
      ],
    );
  }
}
