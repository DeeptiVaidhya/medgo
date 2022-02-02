import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';
import 'package:medgo/services/home.dart';

class DetailPopulated extends StatefulWidget {
  @override
  _DetailPopulatedState createState() => _DetailPopulatedState();
}

class _DetailPopulatedState extends State<DetailPopulated> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  double moodValue = 6;
  DateTime DOB;

  var timeHrs = [for (var i = 1; i <= 12; i++) i];
  var timeMin = [for (var i = 1; i <= 59; i++) i];
  var timeAmPm = ["AM", "PM"];
  var timeAmPmVal = "PM";
  var timeHrsVal = "12";
  var timeMinVal = "20";

  Future<void> submitProfile() async {
    loader(context, _keyLoader);
    try {
      final data = await logMedicine(<String, dynamic>{
        "log_date": (DOB != null) ? DOB.toString() : "",
        "log_time": "15:6:4",
        "medicine_id": "1"
      });
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
        });
        Navigator.pushNamed(context, '/loglast-medication');
        toast(data['msg']);
      } else {
        if (data['is_valid'] == false) {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          Navigator.pushNamed(context, '/signin');
        } else {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          Navigator.pushNamed(context, '/loglast-medication');
          errortoast(data['msg']);
        }
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();
      print('Caught error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header("Hydroxyurea", context, true, true, false, true),
        body: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 22),
              child: Column(
                children: [
                  //painDateTimeCard(170, 320, "Add date and time"),
                  Container(
                    height: 170,
                    width: 320,
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 13, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 13),
                              child: Text(
                                "Add date and time",
                                style: AppCss.black18bold,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(
                                      width: 1.0, color: AppColors.MISCHKA)),
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: DateTimeFormField(
                                  dateTextStyle: AppCss.raven16bold,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintStyle: AppCss.raven16bold,
                                    suffixIcon: Icon(Icons.event_note),
                                    hintText: "Today",
                                  ),
                                  mode: DateTimeFieldPickerMode.date,
                                  autovalidateMode: AutovalidateMode.always,
                                  validator: (e) => (e?.day ?? 0) == 1
                                      ? 'Please not the first day'
                                      : null,
                                  onDateSelected: (DateTime value) {
                                    DOB = value;
                                    // print(value);
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  dropdownbutton(
                                      41,
                                      62,
                                      10,
                                      1,
                                      true,
                                      timeHrsVal,
                                      timeHrs.map((item) {
                                        return DropdownMenuItem<String>(
                                            value: item.toString(),
                                            child: Text(item.toString(),
                                                style: AppCss
                                                    .greylight12semimedium));
                                      }).toList(), (value) {
                                    setState(() {
                                      timeHrsVal = value;
                                    });
                                  }),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  dropdownbutton(
                                      41,
                                      62,
                                      10,
                                      1,
                                      true,
                                      timeMinVal,
                                      timeMin.map((item) {
                                        return DropdownMenuItem<String>(
                                            value: item.toString(),
                                            child: Text(item.toString(),
                                                style: AppCss
                                                    .greylight12semimedium));
                                      }).toList(), (value) {
                                    setState(() {
                                      timeMinVal = value;
                                    });
                                  }),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  dropdownbutton(
                                      41,
                                      62,
                                      8,
                                      0,
                                      true,
                                      timeAmPmVal,
                                      timeAmPm.map((item) {
                                        return DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item,
                                                style: AppCss
                                                    .greylight12semimedium));
                                      }).toList(), (value) {
                                    setState(() {
                                      timeAmPmVal = value;
                                    });
                                  }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 11, top: 22),
                    child: button(true, 320, 54, "Log medication",
                        AppCss.white18bold, AppColors.PINK, () {
                      submitProfile();
                    }, false),
                  ),
                  button(true, 320, 54, "Cancel", AppCss.black18bold,
                      AppColors.WHITE, () {
                    nextScreen(context, "/medicationlist");
                  }, true),
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
            ismorepageactive = false,
            context));
  }
}
