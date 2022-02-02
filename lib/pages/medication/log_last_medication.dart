import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';
import 'package:medgo/services/home.dart';

class LogLastMedication extends StatefulWidget {
  @override
  _LogLastMedicationState createState() => _LogLastMedicationState();
}

class _LogLastMedicationState extends State<LogLastMedication> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    checkLoginToken(context);
    WidgetsBinding.instance.addPostFrameCallback((_) => loader(context, _keyLoader));
    Future.delayed(Duration.zero, () {
      getLogMedicine();
    });
  }

  Future<void> getLogMedicine() async {
    try {
      final data = await getLogMedicines(<String, dynamic>{});
      if (data['status'] == "success") {        
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          // firstName = data['data']['first_name'];
          // lastName = data['data']['last_name'];
          // emailAdd = data['data']['email'];
          // userName = data['data']['username'];
          // dob      = data['data']['dob'];
          // phoneNumber = data['data']['phone_number'];
          // profilePicture = data['data']['profile_picture'];
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
  
  _nextScreen(route) {
    Navigator.of(context).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header("Log a medication", context, true, true, false, true),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 22),
            child: Column(
              children: [
                Container(
                  height: 189,
                  width: 320,
                  child: Card(
                    elevation: 04,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30, top: 28, bottom: 24),
                          child: Text("Would you like to log the same medication that you logged last time?",
                            textAlign: TextAlign.center,style: AppCss.black18bold,
                          ),
                        ),
                        Text("Hydroxyurea",style: AppCss.lightblack30bold)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 17),
                  child: button(true, 320, 54, "Yes, log this medication",
                    AppCss.white18bold, AppColors.PINK, () {
                      _nextScreen("/detail-populated");
                  }, false),
                ),
                Text("Or",style: AppCss.raven16bold),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: GestureDetector(
                    onTap: (){
                      _nextScreen("/medicationlist");  
                    },
                    child: Text("Log another medication",style: AppCss.denim16bold,
                  )),
                )
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
        context
      )
      
    );
  }
}
