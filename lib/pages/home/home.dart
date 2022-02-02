import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/gradiant_bar.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:medgo/pages/widget/helper.dart';
import 'package:getwidget/getwidget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;
  _nextScreen(route) {
    Navigator.of(context).pushNamed(route);
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    // checkLoginToken(context);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  int _currentIndex = 0;

  List list = [widget1(), widget2(), widget3()];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header("Welcome to MED-Go", context, true, false, true, true),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 21),
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 183.0,
                    aspectRatio: 2.0,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: list.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: 320,
                            margin: EdgeInsets.symmetric(horizontal: 7.0),
                            child: i);
                      },
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(list, (index, url) {
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index
                            ? Color(0xff57C5FF)
                            : Color(0xffa0C5FF),
                      ),
                    );
                  }),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 11),
                      child: listtileCardView(
                          320,
                          54,
                          Image.asset("assets/images/icons/Group.png"),
                          "Log your medicine",
                          Image.asset("assets/images/icons/chevron.png"), () {
                        _nextScreen("/loglast-medication");
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: listtileCardView(
                          320,
                          54,
                          Image.asset(
                              "assets/images/icons/log_symptomsicon.png"),
                          "Tell us how you feel",
                          Image.asset("assets/images/icons/chevron.png"), () {
                        _nextScreen("/choose-symptom");
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: listtileCardView(
                          320,
                          54,
                          Image.asset("assets/images/icons/todolist.png"),
                          "Take a health survey",
                          Image.asset("assets/images/icons/chevron.png"), () {
                        nextScreen(context, "/survey");
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: listtileCardView(
                          320,
                          54,
                          Image.asset("assets/images/icons/todolist.png"),
                          "View helpful resources",
                          Image.asset("assets/images/icons/chevron.png"), () {
                        nextScreen(context, "/more");
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: footer(
          ishomepageactive = true,
          iseducationpageactive = false,
          isteampageactive = false,
          isnotificationpageactive=false,
          ismorepageactive = false,
          context)

      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     color: AppColors.WHITE,
      //     boxShadow: [
      //       BoxShadow(
      //         color: AppColors.SHADOWCOLOR,
      //         spreadRadius: 5,
      //         blurRadius: 7,
      //         offset: Offset(0, 4),
      //       )
      //     ],
      //   ),
      // child: Container( height: 60,child: bottomNavigationBar(context, 0))
      // ),

      // bottomNavigationBar: SizedBox(
      //   height: 52,
      //   child: Container(
      //     decoration: BoxDecoration(
      //       color: AppColors.WHITE,
      //       boxShadow: [
      //         BoxShadow(
      //           color: AppColors.SHADOWCOLOR,
      //           spreadRadius: 5,
      //           blurRadius: 7,
      //           offset: Offset(0, 4),
      //         )
      //       ],
      //     ),
      //     child: GFTabBar(
      //       tabBarColor: Colors.white,
      //       indicatorColor: AppColors.SKY,
      //       indicatorWeight: 3,
      //       indicatorPadding: EdgeInsets.only(top: 20, bottom: 2),
      //       length: 5,
      //       controller: tabController,
      //       indicatorSize: TabBarIndicatorSize.label,
      //       tabs: [
      //         Tab(
      //           icon: Container(
      //               height: 18,
      //               child: Image.asset("assets/images/icons/navBar/home.png")),
      //           child: Container(
      //               height: 9, child: Text("Home", style: AppCss.grey7bold)),
      //         ),
      //         Tab(
      //           icon: Container(
      //               width: 19.26,
      //               height: 15.5,
      //               child: Image.asset(
      //                   "assets/images/icons/navBar/Education.png")),
      //           child: Text(
      //             "Education",
      //             style: AppCss.grey7bold,
      //             textAlign: TextAlign.center,
      //             softWrap: true,
      //           ),
      //         ),
      //         Tab(
      //           icon: Container(
      //               height: 18,
      //               child:
      //                   Image.asset("assets/images/icons/navBar/Contact.png")),
      //           child: Text("Your team",
      //               style: AppCss.grey7bold, textAlign: TextAlign.center),
      //         ),
      //         Tab(
      //           icon: Image.asset("assets/images/icons/navBar/notification.png",
      //               height: 16, width: 16),
      //           child: Text(
      //             "Notifications",
      //             style: AppCss.grey7bold,
      //             textAlign: TextAlign.center,
      //             softWrap: true,
      //           ),
      //         ),
      //         Tab(
      //           icon: Container(
      //               child: Image.asset("assets/images/icons/navBar/more.png",
      //                   height: 16, width: 17)),
      //           child: Text("More", style: AppCss.grey7bold),
      //         ),
      //       ],
            
      //     ),
      //   ),
      // ),
    );
  }
}

Widget widget1() {
  return Card(
    elevation: 3,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 28),
          child: Text("Almost there!", style: AppCss.black18bold),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 45, right: 45, top: 10, bottom: 14.22),
          child: Text(
              "You’ve logged most of your medicine (60-80%), I am sure you can do better!",
              style: AppCss.raven12meduim),
        ),
        Container(
          width: 222,
          height: 23.78,
          child: MyGradientProgressIndicator(
            value: 0.8,
            gradient: LinearGradient(
                colors: [Colors.red, Colors.yellow, Colors.green]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Container(
            width: 222,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "0%",
                  style: AppCss.black12medium,
                ),
                Text(
                  "100%",
                  style: AppCss.black12medium,
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget widget2() {
  return Card(
    elevation: 3,
    child: Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 25, left: 18, right: 18, bottom: 9),
          child: Text("Here is an overview of your awards this week",
              textAlign: TextAlign.center, style: AppCss.black18bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 39,
                  height: 45,
                  child: Image.asset("assets/images/trophyalert/trophy1.png"),
                ),
                Text(
                  "+1",
                  style: AppCss.yellow14bold,
                )
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                SizedBox(
                  width: 39,
                  height: 45,
                  child: Image.asset("assets/images/icons/heart.png"),
                ),
                Text("-1", style: AppCss.grey14bold)
              ],
            ),
          ],
        )
      ],
    ),
  );
}

Widget widget3() {
  return Card(
    elevation: 3,
    child: Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 24, left: 17, right: 17, bottom: 9),
          child: Text("You’ve lost 1 heart :(",
              textAlign: TextAlign.center, style: AppCss.black18bold),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40, bottom: 5),
          child: Text(
            "Oh no…you have missed some of your medications. Make sure to take it every day and you can get your heart (emoji for heart) back!",
            textAlign: TextAlign.center,
            style: AppCss.raven12meduim,
          ),
        ),
        Column(
          children: [
            SizedBox(
              width: 30,
              height: 27,
              child: Image.asset("assets/images/icons/heart.png"),
            ),
            Text("-1", style: AppCss.grey14bold)
          ],
        ),
      ],
    ),
  );
}
