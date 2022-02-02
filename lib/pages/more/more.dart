import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header("More", context, true, true, false, true),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      gridCard(
                          Image.asset("assets/images/icons/graduation-hat.png"),
                          "Education",
                          "Learn more about your health and how to take care of yourself!",
                          () {
                        Navigator.of(context).pushNamed("/education");
                      }),
                      SizedBox(
                        width: 10,
                      ),
                      gridCard(
                          Image.asset("assets/images/icons/Communityicon.png"),
                          "Community",
                          "Explore patient organizations and get involved!",
                          () {
                        nextScreen(context, "/community");
                      }),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      gridCard(
                          Image.asset("assets/images/icons/pharmacy.png"),
                          "Pharmacies",
                          "Locate nearby pharmacies to get your refills and meds you need.",
                          () {
                        nextScreen(context, "/pharmacies");
                      }),
                      SizedBox(
                        width: 10,
                      ),
                      gridCard(
                          Image.asset("assets/images/logo/logo.png"),
                          "Medications",
                          "Learn about your medications and how to take them",
                          () {
                        nextScreen(context, "/medicationlist");
                      }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: footer(
            ishomepageactive = false,
            iseducationpageactive = false,
            isteampageactive = false,
            isnotificationpageactive = false,
            ismorepageactive = true,
            context));
  }

  SizedBox gridCard(Image image, title, subtitle, onTab) {
    return SizedBox(
      width: 150,
      child: GestureDetector(
        onTap: onTab,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 02,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 16),
                child: SizedBox(height: 62, width: 62, child: image),
              ),
              Text(
                title,
                style: AppCss.black16bold,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7, bottom: 19),
                child: Container(
                  height: 58,
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: AppCss.raven12meduim,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
