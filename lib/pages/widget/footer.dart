import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';

bool ishomepageactive = false;
bool iseducationpageactive = false;
bool isnotificationpageactive = false;
bool ismorepageactive = false;
bool isteampageactive = false;
bool checkin = false;
footer(ishomepageactive, iseducationpageactive, isteampageactive,
    isnotificationpageactive, ismorepageactive, context) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: AppColors.WHITE,
      boxShadow: [
        BoxShadow(
          color: AppColors.SHADOWCOLOR,
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 4),
        )
      ],
    ),
    child: Container(
      margin: EdgeInsets.only(top: 5, bottom: 1.5),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 5),
            decoration: ishomepageactive
                ? BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 4, color: AppColors.SKY)))
                : null,
            child: Column(children: [
              InkWell(
                hoverColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).pushNamed("/home");
                },
                child: Container(
                    child: Image.asset("assets/images/icons/navBar/home.png",
                        width: 18, height: 18)),
              ),
              InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1, bottom: 2.0),
                    child: Text('Home', style: AppCss.grey7bold),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/home");
                  })
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            decoration: iseducationpageactive
                ? BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 4, color: AppColors.SKY)))
                : null,
            child: Column(children: [
              InkWell(
                hoverColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).pushNamed("/education");
                },
                child: Image.asset("assets/images/icons/navBar/Education.png",
                    width: 19.26, height: 18),
              ),
              InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1, bottom: 2.0),
                    child: Text('Education', style: AppCss.grey7bold),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/education");
                  })
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            decoration: isteampageactive
                ? BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 4, color: AppColors.SKY)))
                : null,
            child: Column(children: [
              InkWell(
                hoverColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).pushNamed("/yourteam");
                },
                child: Image.asset(
                  "assets/images/icons/navBar/Contact.png",
                  height: 18,
                  width: 18,
                ),
              ),
              InkWell(
                  hoverColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1, bottom: 2.0),
                    child: Text('Your team', style: AppCss.grey7bold),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/yourteam");
                  })
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            decoration: isnotificationpageactive
                ? BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 4, color: AppColors.SKY)))
                : null,
            child: Column(children: [
              InkWell(
                hoverColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).pushNamed("/notifications");
                },
                child: Image.asset(
                    "assets/images/icons/navBar/notification.png",
                    height: 16,
                    width: 16),
              ),
              InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1, bottom: 2.0),
                    child: Text('Notifications', style: AppCss.grey7bold),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/notifications");
                  })
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            decoration: ismorepageactive
                ? BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 4, color: AppColors.SKY)))
                : null,
            child: Column(children: [
              InkWell(
                hoverColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).pushNamed("/more");
                },
                child: Image.asset("assets/images/icons/navBar/more.png",
                    height: 16, width: 17),
              ),
              InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1, bottom: 2.0),
                    child: Text('More', style: AppCss.grey7bold),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/more");
                  })
            ]),
          ),
        ],
      ),
    ),
  );
}
