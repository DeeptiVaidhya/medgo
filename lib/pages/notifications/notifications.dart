import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header("Notifications", context, true, false, false, true),
        backgroundColor: Color(0xffF6F),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 375,
              child: Container(
                margin: const EdgeInsets.only(top:20,left: 20,right: 20,bottom: 20),
                child: Column(
                children: [
                  notificationsCard(
                      Image.asset("assets/images/trophyalert/trophy1.png"),
                      "You’ve earned a trophy!",
                      "You’ve earned five stars, now you get a badge! Awesome job! Keep up the good work!",
                      "1 hour ago"),
                  notificationsCard(
                      Image.asset("assets/images/trophyalert/trophy1.png"),
                      "You’ve earned a trophy!",
                      "You’ve earned five stars, now you get a badge! Awesome job! Keep up the good work!",
                      "1 hour ago"),
                  notificationsCard(
                      Image.asset("assets/images/trophyalert/trophy1.png"),
                      "You’ve earned a trophy!",
                      "You’ve earned five stars, now you get a badge! Awesome job! Keep up the good work!",
                      "1 hour ago"),
                  notificationsCard(
                      Image.asset("assets/images/trophyalert/trophy1.png"),
                      "You’ve earned a trophy!",
                      "You’ve earned five stars, now you get a badge! Awesome job! Keep up the good work!",
                      "1 hour ago"),
                ],
              ),
                          ),
            ),
          ),
        ),
          bottomNavigationBar: footer(
          ishomepageactive = false,
          iseducationpageactive = false,
          isteampageactive = false,
          isnotificationpageactive=true,
          ismorepageactive = false,
          context)
        );
  }

  notificationsCard(Image image, String title, String subtitle, String time) {
    return Container(
      child: Column(
        children: [
          Card(
            color: Color(0xffFFFFFF),
            elevation: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: false,
                  leading: Padding(
                   padding: const EdgeInsets.only(top: 15),
                    child: SizedBox(
                      width: 38,
                      height: 40,
                      child: image,
                    ),
                  ),
                  isThreeLine: true,
                  title: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      title,
                      style: AppCss.black16bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      subtitle,
                      style: AppCss.black12regular,
                    ),
                  ),
                  trailing: Icon(Icons.close, size: 15), 
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70, top: 10, bottom: 20),
                  child: Text(
                    time,
                    style: AppCss.denim12italic,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
