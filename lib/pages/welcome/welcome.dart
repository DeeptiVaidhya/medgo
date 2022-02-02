import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/helper.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  _signIn(context) {
    Navigator.of(context).pushNamed("/signin");
  }

  _signUp(context) {
    Navigator.of(context).pushNamed("/signup");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.AQUA_BLUE,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 148, left: 30, right: 30),
                child: Text(
                  "Welcome to MED-Go",
                  textAlign: TextAlign.center,
                  style: AppCss.black30bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 40, right: 40),
                child: Text(
                  "MED-Go app is a fun journey to help you take your medicine!!",
                  textAlign: TextAlign.center,
                  style: AppCss.black16medium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 105, right: 105),
                child: logocontainer(150, 150,
                    Image.asset("assets/images/logo/logo.png"), 94, 94),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: button(true, 320, 54, "Sign in", AppCss.white18bold,
                      AppColors.PINK, () {
                    _signIn(context);
                  }, false)),
              // Padding(
              //   padding: const EdgeInsets.only(top: 25,bottom: 30),
              //   child: GestureDetector(
              //     onTap: () {
              //       _signUp(context);
              //     },
              //     child: Column(
              //       children: [
              //         Text(
              //           "Don’t have an account?",
              //           style: AppCss.black16medium,
              //         ),
              //         Text(
              //           "Sign up!",
              //           style: AppCss.black16boldunderline,
              //         )
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
