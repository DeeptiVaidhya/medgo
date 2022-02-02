import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';
import 'package:medgo/services/home.dart';

class MedicationList extends StatefulWidget {
  @override
  _MedicationListState createState() => _MedicationListState();
}

class _MedicationListState extends State<MedicationList> {

  var medicationList = [];
  final GlobalKey<State> _keyLoading = new GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    checkLoginToken(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => loader(context, _keyLoading));
    Future.delayed(Duration.zero, () {
      getMedicationList();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getMedicationList() async {    
    try {
      final data = await getMedication(<String, dynamic>{});
      if (data['status'] == "success") {        
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          medicationList = data['data'];
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
          Navigator.pushNamed(context, '/medicationlist');
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
      appBar: header("Log a medication", context, true, true, false, true),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                ListView.separated( 
                  separatorBuilder: (BuildContext context, int index) =>
                  Container(margin: EdgeInsets.only(bottom: 8)),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: medicationList.length,
                  itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    child: buildContainer(medicationList[index]['title'].toString(), "(6MP)",(){
                      nextScreen(context, "/detail-populated1");
                  }),
                  );                 
                  }
                ),
                // buildContainer(medicationList[index]['title'].toString(), "(6MP)",(){
                //   nextScreen(context, "/detail-populated1");
                // }),
                // Padding(
                //   padding: const EdgeInsets.only(top: 15),
                //   child: buildContainer("Adakveo", "(Crizanlizumab)",(){}),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 15),
                //   child: buildContainer("Hydroxyurea", "(HU)",(){}),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 15),
                //   child: buildContainer("Dexamethasone", "(Decadron)",(){}),
                // ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: footer(
      ishomepageactive = false,
      iseducationpageactive = false,
      isteampageactive = false,
      isnotificationpageactive=false,
      ismorepageactive = false,
      context)
    );
  }

  Container buildContainer(text1, text2,onTab) {
    return Container(
      height: 84,
      width: 320,
      child: GestureDetector(
        onTap: onTab,
        child: Card(
        elevation: 03,
        child: Padding(
            padding: const EdgeInsets.only(top: 21),
            child: Column(
              children: [
                Text(
                  text1,
                  style: AppCss.black18bold,
                ),
                Text(
                  text2,
                  style: AppCss.black12medium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
