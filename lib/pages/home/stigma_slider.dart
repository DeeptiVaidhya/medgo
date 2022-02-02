import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/home/assessment_complete.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';
import 'package:medgo/services/home.dart';

class StigmaSlider extends StatefulWidget {
  @override
  _StigmaSliderState createState() => _StigmaSliderState();
}

class _StigmaSliderState extends State<StigmaSlider> {
  double value = 6.0;
  var datamap = Map();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context).settings.arguments;
    //print(datamap);
    datamap = data;
    datamap['value'] = value;
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
                        top: 40, bottom: 10, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 13),
                          child: Text(
                            "Expected Discrimination",
                            textAlign: TextAlign.left,
                            style: AppCss.black16bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            "I worry about people discriminating against me because I have SCD.",
                            textAlign: TextAlign.left,
                            style: AppCss.black20bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            height: 114,
                            child: buildCard(context),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 129),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              button(true, 100, 33, "Back", AppCss.raven14bold,
                                  Color(0xffCCD1D9), () {}, false),
                              button(true, 100, 33, "Finish",
                                  AppCss.black14bold, AppColors.AQUA_BLUE, () {
                                // nextScreen(context, "/assessment-complete");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AssessmentComplete(),
                                    // Pass the arguments as part of the RouteSettings. The
                                    // DetailScreen reads the arguments from these settings.
                                    settings: RouteSettings(
                                      arguments: datamap,
                                    ),
                                  ),
                                );
                              }, false),
                            ],
                          ),
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

  Card buildCard(BuildContext context) {
    return Card(
      elevation: 01,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 0, top: 12, bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "No pain at all (0)",
                  style: AppCss.black12bold,
                ),
                Text(
                  "So much pain (10)",
                  style: AppCss.black12bold,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 2),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2,
                inactiveTrackColor: Color(0xFFCCD1D9),
                activeTrackColor: AppColors.AQUA_BLUE,
                thumbColor: AppColors.AQUA_BLUE,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 9.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 9.0),
              ),
              child: Slider(
                value: value,
                min: 0,
                max: 10,
                divisions: 10,
                onChanged: (newvalue) {
                  setState(() {
                    datamap['value'] = newvalue;
                    value = newvalue;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 143),
            child: Text(
              value.toString(),
              style: AppCss.sky16bold,
            ),
          ),
        ],
      ),
    );
  }
}
