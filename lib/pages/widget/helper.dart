import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/education/education.dart';
//import 'package:medgo/pages/education/education_.dart';
import 'package:medgo/pages/home/home.dart';
import 'package:medgo/pages/more/more.dart';
import 'package:medgo/pages/notifications/notifications.dart';
import 'package:medgo/pages/your-team/your_team.dart';
import 'package:medgo/services/auth.dart';
import 'package:medgo/services/locator.dart';
import 'package:medgo/services/navigationService.dart';
import 'package:page_transition/page_transition.dart';
import 'mynav_bar.dart';

final NavigationService _navigationService = locator<NavigationService>();

Widget logocontainer(height, width, Widget image, imgheight, imgwidth) {
  return Container(
    width: height,
    height: width,
    child: image,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.WHITE,
    ),
  );
}

Stack buildCirclewithimg(double boxwidth, double boxheight, Image img,
    double imgheight, double imgwidth) {
  return Stack(
    children: [
      Positioned(
        child: Container(
          height: boxheight,
          width: boxwidth,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: AppColors.WHITE),
        ),
      ),
      Positioned(
        top: boxheight / 2 - imgheight / 2,
        left: boxwidth / 2 - imgwidth / 2,
        child: SizedBox(
          child: img,
          height: imgheight,
          width: imgwidth,
        ),
      ),
    ],
  );
}

// Widget button(height, width, ontab, text) {
//   return Container(
//       height: height,
//       width: width,
//       child: InkWell(
//         onTap: ontab,
//         child: Container(
//           width: width,
//           height: height,
//           child: Center(
//             child: Text(
//               text,
//               style: AppCss.white18bold,
//             ),
//           ),
//           decoration: BoxDecoration(
//             color: AppColors.PINK,
//             borderRadius: BorderRadius.circular(5.0),
//           ),
//         ),
//       ));
// }

Widget button(bool isActive, btnwidth, btnheight, btntext, btntextstyle,
    btnbgcolor, onpressfunction, bool isborder) {
  return InkWell(
    hoverColor: btnbgcolor,
    borderRadius: BorderRadius.circular(100),
    onTap: isActive ? onpressfunction : () {},
    child: Container(
      width: btnwidth,
      height: btnheight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: btnbgcolor,
          border: Border.all(color: isborder ? Color(0xff434A54) : btnbgcolor)),
      child: Center(
        child: Text(
          btntext,
          style: btntextstyle,
        ),
      ),
    ),
  );
}

Container textfield(
    height, width, hinttext, TextEditingController textEditingController) {
  return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: AppColors.WHITE, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 5),
        child: Theme(
          data: ThemeData(),
          child: TextField(
            controller: textEditingController,
            style: AppCss.grey16medium,
            decoration: InputDecoration(
              hintText: hinttext,
              hintStyle: AppCss.grey16medium,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ),
      ));
}

Container textfieldNewuser(height, width, hinttext, textstyle,
    TextEditingController textEditingController, bool isPasswordField) {
  return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffD5D5D5)),
          color: AppColors.WHITE,
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, bottom: 03),
        child: Theme(
          data: ThemeData(),
          child: TextField(
            obscureText: isPasswordField ? true : false,
            controller: textEditingController,
            style: isPasswordField
                ? TextStyle(fontSize: 30, color: AppColors.MISCHKA)
                : textstyle,
            decoration: InputDecoration(
              hintText: hinttext,
              hintStyle: textstyle,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ),
      ));
}

Container passwordfield(
    double height, double width, String hinttext, Color bordercolor) {
  return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: bordercolor, width: 1),
          color: AppColors.WHITE,
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
        ),
        child: Theme(
          data: ThemeData(),
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: AppColors.MISCHKA,
              fontSize: 30,
            ),
            decoration: InputDecoration(
              hintText: hinttext,
              hintStyle: AppCss.grey16medium,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ),
      ));
}

Container dropdownbutton(
    height,
    width,
    leftpadding,
    rightpadding,
    bool isborder,
    hintText,
    List<DropdownMenuItem> items,
    void Function(dynamic) onchanged) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        color: isborder ? AppColors.WHITE : Colors.white,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: Color(0xffD5D5D5), width: 1)),
    child: Padding(
      padding: EdgeInsets.only(left: leftpadding, right: rightpadding),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          items: items,
          iconSize: 27,
          onChanged: onchanged,
          iconEnabledColor: AppColors.CYAN_BLUE,
          iconDisabledColor: AppColors.CYAN_BLUE,
          hint: Text(
            hintText,
            style: AppCss.raven16bold,
          ),
        ),
      ),
    ),
  );
}

Future<void> modalPopup(BuildContext context, GlobalKey key,
    Widget popupcontent, double popupwidth, double popupheight) async {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: popupwidth,
            height: popupheight,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                    top: -18,
                    right: -20,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.close,
                          color: Color(0xff263E72),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 30),
                  child: popupcontent,
                )
              ],
            ),
          ),
        );
      });
}

Dialog popupDialog(height, width, Widget content) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    elevation: 0,
    backgroundColor: AppColors.WHITE,
    child: Container(
      height: height,
      width: width,
      child: content,
    ),
  );
}

Container listtileCardView(double width, double height, Image leading,
    String title, Image trailing, onTab) {
  return Container(
    width: width,
    height: 62,
    child: GestureDetector(
      onTap: onTab,
      child: Card(
        elevation: 3,
        child: ListTile(
          leading: SizedBox(height: 30, width: 30, child: leading),
          horizontalTitleGap: 10,
          title: Text(
            title,
            style: AppCss.black18bold,
          ),
          trailing: trailing,
        ),
      ),
    ),
  );
}

MyBottomNavigationBar bottomNavigationBar(
    BuildContext context, int currentIndex) {
  return MyBottomNavigationBar(
    backgroundColor: AppColors.WHITE,
    elevation: 4,
    type: MyBottomNavigationBarType.fixed,
    onTap: (index) {
      switch (index) {
        case 0:
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: Home(),
            ),
          );
          break;
        case 1:
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: Education(),
            ),
          );
          break;
        case 2:
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: YourTeam(),
            ),
          );
          break;
        case 3:
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: Notifications(),
            ),
          );
          break;
        case 4:
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: More(),
            ),
          );
          break;
      }
    },
    selectedFontSize: 7,
    unselectedFontSize: 7,
    unselectedItemColor: AppColors.RAVEN,
    selectedItemColor: AppColors.RAVEN,
    currentIndex: currentIndex,
    mouseCursor: MouseCursor.uncontrolled,
    items: [
      BottomNavigationBarItem(
          tooltip: "",
          icon: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
              height: 18,
              child: Image.asset("assets/images/icons/navBar/home.png")),
          label: "Home"),
      BottomNavigationBarItem(
        tooltip: "",
        icon: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
            width: 19.26,
            height: 30,
            child: Image.asset("assets/images/icons/navBar/Education.png")),
        label: "Education",
      ),
      BottomNavigationBarItem(
          tooltip: "",
          icon: Container(
            height: 25,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: Image.asset("assets/images/icons/navBar/Contact.png"),
          ),
          label: "Your team"),
      BottomNavigationBarItem(
          tooltip: "",
          icon: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
              width: 30,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: 17,
                      width: 17,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffDA4553),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 05,
                        ),
                        child: Text(
                          "7+",
                          style:
                              TextStyle(fontSize: 10, color: AppColors.WHITE),
                        ),
                      ),
                    ),
                    left: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 5,
                      bottom: 5,
                    ),
                    child: Image.asset(
                        "assets/images/icons/navBar/notification.png",
                        height: 16,
                        width: 16),
                  )
                ],
              )),
          label: "Notifications"),
      BottomNavigationBarItem(
          tooltip: "",
          icon: Container(
              child: Image.asset("assets/images/icons/navBar/more.png",
                  height: 16, width: 17)),
          label: "More"),
    ],
  );
}

Container symptomCard(height, width, image, text, onTab) {
  return Container(
    width: width,
    height: height,
    child: GestureDetector(
      onTap: onTab,
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: image,
            ),
            SizedBox(
              height: 21,
            ),
            Text(
              text,
              style: AppCss.black16bold,
            )
          ],
        ),
      ),
    ),
  );
}

toast(String message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      webBgColor: "linear-gradient(to right, #357B40, #357B40)",
      textColor: Colors.white);
}

errortoast(String message) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      webBgColor: "linear-gradient(to right, #CC0000, #CC0000)",
      textColor: Colors.white);
}

isVarEmpty(val, {title}) {
  if (val == null || val == "undefind" || val == "") {
    return "";
  }
  return val;
}

Future<void> loader(BuildContext context, GlobalKey key) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
                key: key,
                backgroundColor: AppColors.WHITE,
                children: <Widget>[
                  Center(
                    child: Row(children: [
                      SizedBox(
                        width: 30,
                      ),
                      CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              AppColors.LIGHT_BLACK.withOpacity(0.7)),
                          strokeWidth: 2.0),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Please Wait...",
                        style: AppCss.black16regular,
                      )
                    ]),
                  )
                ]));
      });
}

Container sliderCard(
    BuildContext context,
    double height,
    double width,
    String heading,
    String subheading1,
    String subheading2,
    double value,
    void Function(double) onChanged) {
  return Container(
    height: height,
    width: width,
    child: Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.only(right: 15, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading == ""
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      heading,
                      style: AppCss.black18bold,
                    ),
                  ),
            Padding(
              padding: EdgeInsets.only(left: 14, top: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(),
                      ),
                      height: 30,
                      width: 30,
                      child: Image.asset("assets/images/icons/pain.png")),
                  Container(
                      height: 30,
                      width: 30,
                      child:
                          Image.asset("assets/images/icons/energy-level.png"))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 14, top: 12, bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    subheading1,
                    style: AppCss.black12bold,
                  ),
                  Text(
                    subheading2,
                    style: AppCss.black12bold,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
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
                  onChanged: onChanged,
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 9.0 + (value * 28) - value, top: 5),
              child: Text(
                value.toString(),
                style: AppCss.sky16bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Container painDateTimeCard(height, width, text) {
  return Container(
    height: height,
    width: width,
    child: Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.only(top: 13, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 13),
              child: Text(
                text,
                style: AppCss.black18bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(width: 1.0, color: AppColors.MISCHKA)),
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
                  validator: (e) =>
                      (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                  onDateSelected: (DateTime value) {
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  dropdownbutton(41, 62, 10, 1, true, "12", [], (value) {}),
                  SizedBox(
                    width: 5,
                  ),
                  dropdownbutton(41, 62, 10, 1, true, "20", [], (value) {}),
                  SizedBox(
                    width: 5,
                  ),
                  dropdownbutton(41, 62, 8, 0, true, "PM", [], (value) {}),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Container confirmButton(width, height, text, void Function() ontab) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(width: 1.0, color: AppColors.MISCHKA)),
    height: height,
    width: width,
    child: InkWell(
      onTap: ontab,
      hoverColor: Colors.white,
      highlightColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppCss.black18bold,
            ),
            Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: AppColors.MISCHKA),
                  shape: BoxShape.circle),
            )
          ],
        ),
      ),
    ),
  );
}

Container dateField(height, width, onDateSelected, textstyle) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        border: Border.all(color: Color(0xffD5D5D5)),
        color: AppColors.WHITE,
        borderRadius: BorderRadius.circular(5)),
    child: Padding(
      padding: const EdgeInsets.only(left: 15),
      child: DateTimeFormField(
        dateTextStyle: textstyle,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintStyle: textstyle,
            suffixIcon: Icon(Icons.event_note),
            hintText: "July 2, 2004"),
        mode: DateTimeFieldPickerMode.date,
        autovalidateMode: AutovalidateMode.always,
        validator: (e) =>
            (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
        onDateSelected: onDateSelected,
      ),
    ),
  );
}

checkLoginToken1() async {
  final data = await checkLogin(<String, dynamic>{});
  final LocalStorage storage = new LocalStorage('medgo');

  print(_navigationService);
  if (data['status'] == "error") {
    storage.clear();
    _navigationService.navigateTo('/signin');
    errortoast(data['msg']);
  }
}

checkLoginToken(context) async {
  final data = await checkLogin(<String, dynamic>{});
  final LocalStorage storage = new LocalStorage('medgo');
  if (data['status'] == "error") {
    storage.clear();
    Navigator.pushNamed(context, '/');
    errortoast(data['msg']);
  }
}

nextScreen(BuildContext context, route) {
  Navigator.of(context).pushNamed(route);
}

int btnwidth;
int btnheight;
String btntextstyle;
String btntext;
String btnbgcolor;
bool btntypesubmit;
String onpressfunction;
int paddingtop;
int paddingbottom;
int paddingleft;
int paddingright;

//button
buttion(
    btnwidth,
    btnheight,
    btntext,
    btntextstyle,
    btnbgcolor,
    simplebtn,
    onpressfunction,
    paddingtop,
    paddingbottom,
    paddingleft,
    paddingright,
    context) {
  return InkWell(
    hoverColor: btnbgcolor,
    borderRadius: BorderRadius.circular(100),
    onTap: onpressfunction,
    child: Container(
      width: btnwidth,
      height: btnheight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: btnbgcolor,
      ),
      child: btntypesubmit
          ? Container(
              margin: EdgeInsets.only(top: paddingtop, bottom: paddingbottom),
              alignment: Alignment.center,
              child: Text(btntext,
                  style: btntextstyle, textAlign: TextAlign.center),
            )
          : Row(children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    paddingleft, paddingtop, paddingright, paddingbottom),
                child: Text(btntext, style: btntextstyle),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 17, bottom: 16, right: 20),
                child: CircleAvatar(
                  child: Icon(Icons.done, color: btnbgcolor, size: 20),
                  backgroundColor: AppColors.WHITE,
                ),
              )
            ]),
    ),
  );
}
