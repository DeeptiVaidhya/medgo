import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';
import 'package:medgo/services/home.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final GlobalKey<State> _keyLoading = new GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    checkLoginToken(context);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => loader(context, _keyLoading));
    Future.delayed(Duration.zero, () {
      communitiesList();
    });
  }

  var name;
  var communityList = [];

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> communitiesList() async {
    try {
      final data = await getCommunities(<String, dynamic>{});
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          communityList = data['result'];
        });
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
          Navigator.pushNamed(context, '/edit-profile');
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
        appBar: header("Community", context, true, true, false, true),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 375,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Container(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          communityList.isEmpty
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      top: 150,
                                      bottom: 150,
                                      left: 40,
                                      right: 40),
                                  child: Text("No list yet.",
                                      style: AppCss.grey12medium,
                                      textAlign: TextAlign.center),
                                )
                              : ListView.separated(
                                  separatorBuilder: (BuildContext context,
                                          int index) =>
                                      Container(
                                          margin: EdgeInsets.only(bottom: 8)),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: communityList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.WHITE,
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.SHADOWCOLOR,
                                              spreadRadius: 0,
                                              blurRadius: 3,
                                              offset: Offset(0, 3))
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
                                        child: Card(
                                          child: ListTile(
                                            minLeadingWidth: 0,
                                            horizontalTitleGap: 0.0,
                                            leading: Image.network(
                                                communityList[index]['logo_url']
                                                    .toString(),
                                                height: 40,
                                                width: 40),
                                            subtitle: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 15,
                                                  top: 17,
                                                  bottom: 15),
                                              child: Text(
                                                communityList[index]['name']
                                                    .toString(),
                                                style: AppCss.black16bold,
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            trailing: Image.asset(
                                                "/images/icons/link.png"),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                        ],
                      ),
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
            ismorepageactive = true,
            context));
  }

  SizedBox buildRow(image1, image2, title) {
    return SizedBox(
      child: Card(
          elevation: 02,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 15, top: 17, bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                image1,
                SizedBox(
                  width: 05,
                ),
                Expanded(
                    child: Text(
                  title,
                  style: AppCss.black16bold,
                )),
                image2,
              ],
            ),
          )),
    );
  }
}
