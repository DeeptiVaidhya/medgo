import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/home/stigma_slider.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';

class Stigma extends StatefulWidget {
  @override
  _StigmaState createState() => _StigmaState();
}

class _StigmaState extends State<Stigma> {
  var datamap = Map();
  @override
  void initState() {
    datamap['surveyno'] = 3;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header("Stigma", context, true, true, false, true),
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 10, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Social Inclusion",
                          textAlign: TextAlign.left,
                          style: AppCss.black16bold,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 13, bottom: 15),
                          child: Text(
                            "People have physically backed away from me because I have SCD.",
                            textAlign: TextAlign.left,
                            style: AppCss.black20bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            confirmButton(130, 52, "True", () {
                              datamap['social_inclusion'] = true;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StigmaSlider(),
                                  settings: RouteSettings(arguments: datamap),
                                ),
                              );
                            }),
                            confirmButton(130, 52, "False", () {})
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 232),
                          child: button(true, 100, 33, "Back",
                              AppCss.raven14bold, Color(0xffCCD1D9), () {
                            datamap['social_inclusion'] = true;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StigmaSlider(),
                                settings: RouteSettings(arguments: datamap),
                              ),
                            );
                          }, false),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: footer(
            ishomepageactive = false,
            iseducationpageactive = false,
            isteampageactive = false,
            isnotificationpageactive = false,
            ismorepageactive = false,
            context));
  }
}
