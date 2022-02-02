import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';
import 'package:medgo/services/home.dart';
import 'package:url_launcher/url_launcher.dart';

class Pharmacies extends StatefulWidget {
  @override
  _PharmaciesState createState() => _PharmaciesState();
}

class _PharmaciesState extends State<Pharmacies> {
  var pharmaciesList = [];
  var url;
  final GlobalKey<State> _keyLoading = new GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    checkLoginToken(context);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => loader(context, _keyLoading));
    Future.delayed(Duration.zero, () {
      getPharmaciesList();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getPharmaciesList() async {
    try {
      final data = await getPharmacies(<String, dynamic>{});
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          pharmaciesList = data['data'];
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
          Navigator.pushNamed(context, '/pharmacies');
          errortoast(data['msg']);
        }
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();
      print('Caught error: $err');
    }
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header("Resources", context, true, true, false, false),
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Container(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Pharmacies",
                              style: AppCss.black18bold,
                            ),
                          ),
                          ListView.separated(
                              separatorBuilder: (BuildContext context,
                                      int index) =>
                                  Container(margin: EdgeInsets.only(bottom: 8)),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: pharmaciesList.length,
                              itemBuilder: (context, index) {
                                url = pharmaciesList[index]['url'].toString();
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
                                            pharmaciesList[index]['image']
                                                .toString(),
                                            height: 21,
                                            width: 25),
                                        subtitle: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, bottom: 09, top: 07),
                                          child: SizedBox(
                                            height: 21,
                                            child: Text(
                                              pharmaciesList[index]['name']
                                                  .toString(),
                                              style: AppCss.black16bold,
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        trailing: InkWell(
                                          onTap: () {
                                            _launchURL(url);
                                          },
                                          child: Image.asset(
                                              "/images/icons/link.png"),
                                        ),
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

  SizedBox buildRow(Image image1, Image image2, title) {
    return SizedBox(
      width: 300,
      child: Card(
          elevation: 02,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 15, top: 17, bottom: 15),
            child: Row(
              children: [
                Container(width: 25, child: image1),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 90,
                  child: Text(
                    title,
                    style: AppCss.black16bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 95),
                  child: image2,
                ),
              ],
            ),
          )),
    );
  }
}
