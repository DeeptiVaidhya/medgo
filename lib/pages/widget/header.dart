import 'package:flutter/material.dart';
import 'package:medgo/pages/widget/helper.dart';
import 'package:medgo/pages/app-css.dart';

// Widget header(text, BuildContext context) {
//   return AppBar(
//     leading: GestureDetector(
//       child: Icon(Icons.arrow_back_ios),
//       onTap: () {
//         Navigator.pop(context);
//       },
//     ),
//     backgroundColor: AppColors.AQUA_BLUE,
//     elevation: 0,
//     title: Text(
//       text,
//       style: AppCss.black21bold,
//     ),
//   );
// }

Widget header(text, BuildContext context, bool isLogin, bool isBack,
    bool isLogo, bool isAvatar,
    {callback = null}) {
  return AppBar(
    toolbarHeight: 80,
    centerTitle: true,
    titleSpacing: 0,
    actions: [
      InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/useraccount-detail');
        },
        child: Container(
          height: 40,
          width: 40,
          child: isAvatar
              ? Image.asset(
                  "assets/images/avatar/Avatar2.png",
                  fit: BoxFit.contain,
                )
              : Container(),
        ),
      ),
      SizedBox(

        width: 20,
      )
    ],
    leading: isBack
        ? GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              if (callback != null) {
                callback();
              } else {
                Navigator.pop(context);
              }
            },
          )
        : Container(
            child: isLogo
                ? IconButton(
                    onPressed: () {},
                    icon: buildCirclewithimg(
                        40,
                        40,
                        Image.asset("assets/images/logo/logo.png"),
                        25.25,
                        25.25),
                  )
                : Container(),
          ),
    backgroundColor: AppColors.AQUA_BLUE,
    elevation: 0,
    title: Text(
      text,
      style: AppCss.black18bold,
    ),
  );
}