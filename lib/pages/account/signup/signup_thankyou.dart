import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';

class SignUpThankYou extends StatefulWidget {
  @override
  _SignUpThankYouState createState() => _SignUpThankYouState();
}

class _SignUpThankYouState extends State<SignUpThankYou> {
  _nextScreen() {
    Navigator.of(context).pushNamed("/signin");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.AQUA_BLUE,
      appBar: header("Create your account", context, false, true, false, false),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 375,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 62, bottom: 54),
                  child: SizedBox(
                    child: buildCirclewithimg(
                        136,
                        136,
                        Image.asset("assets/images/logo/logo.png"),
                        79.61,
                        79.61),
                  ),
                ),
                Text(
                  "Thank You!!",
                  style: AppCss.black32bold,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 50, right: 50, bottom: 135),
                  child: Container(
                    height: 60,
                    child: Text(
                      "We’re excited to see you using MED-Go app",
                      textAlign: TextAlign.center,
                      style: AppCss.black16bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: button(true, 320, 54, "Finish", AppCss.white18bold,
                      AppColors.PINK, () {
                    _nextScreen();
                  }, false),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
