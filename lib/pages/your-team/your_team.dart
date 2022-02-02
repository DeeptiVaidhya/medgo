import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/services/teamservice.dart';

class YourTeam extends StatefulWidget {
  @override
  _YourTeamState createState() => _YourTeamState();
}

class _YourTeamState extends State<YourTeam> {
  @override
  void initState() {
    getTeamList();
    super.initState();
  }

  var teamList;
  bool isloading = true;
  Future<void> getTeamList() async {
    try {
      final data = await getTeamData(<String, dynamic>{});
      if (data['status'] == "success") {
        setState(() {
          teamList = data['data'];
          isloading = false;
          // Navigator.of(context, rootNavigator: true).pop();
        });
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();
      print('Caught error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header("Your team", context, true, true, false, false),
        body: !isloading
            ? Container(
                child: SingleChildScrollView(
                  child: teamList['site_details'] != null
                      ? Center(
                          child: Container(
                            width: 320,
                            margin: const EdgeInsets.only(top: 21, bottom: 30),
                            child: Card(
                              elevation: 03,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 18, bottom: 23, left: 22, right: 22),
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount:
                                        teamList['team_details'].length + 1,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return teamHeadWidget();
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 28, 0, 0),
                                          child: teamDetails(
                                              Image.asset(
                                                  "assets/images/icons/MaskGroup2.png"),
                                              teamList['team_details']
                                                  [index - 1]['first_name'],
                                              teamList['team_details']
                                                  [index - 1]['last_name'],
                                              teamList['team_details']
                                                  [index - 1]['phone_number'],
                                              "312-227-9372",
                                              teamList['team_details']
                                                  [index - 1]['email'],
                                              "Monday-Friday (9am-5pm)"),
                                        );
                                      }
                                    }),
                              ),
                            ),
                          ),
                        )
                      : Center(child: Text("No data....")),
                ),
              )
            : Center(child: CircularProgressIndicator()),
        bottomNavigationBar: footer(
            ishomepageactive = false,
            iseducationpageactive = false,
            isteampageactive = true,
            isnotificationpageactive = false,
            ismorepageactive = false,
            context));
  }

  Column teamHeadWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset("assets/images/icons/yourteam-logo.png"),
        Padding(
          padding: const EdgeInsets.only(top: 09),
          child: Text(
            "1.800.KIDS DOC",
            style: AppCss.black18bold,
          ),
        ),
        Text(
          "1.800.543.7362",
          style: AppCss.raven15meduim,
        ),
      ],
    );
  }

  Column teamDetails(leading, title, subtitlte, phone, fax, email, hours) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: leading,
          title: Text(
            title,
            style: AppCss.lightblack16bold,
          ),
          subtitle: Text(
            subtitlte,
            style: AppCss.lightgrey16regular,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Row(
            children: [
              Text(
                "Phone",
                style: AppCss.black16bold,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                phone,
                style: AppCss.lightgrey16regular,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Text(
                "Fax",
                style: AppCss.black16bold,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                fax,
                style: AppCss.lightgrey16regular,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Text(
                "Email",
                style: AppCss.black16bold,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                email,
                style: AppCss.aquablue16regular,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Text(
                "Hours",
                style: AppCss.black16bold,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                hours,
                style: AppCss.lightgrey16regular,
              )
            ],
          ),
        )
      ],
    );
  }
}
