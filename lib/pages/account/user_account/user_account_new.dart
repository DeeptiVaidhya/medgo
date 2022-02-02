
import 'package:flutter/material.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';

class UserAccountNew extends StatefulWidget {
  @override
  _UserAccountNewState createState() => _UserAccountNewState();
}

class _UserAccountNewState extends State<UserAccountNew> {
  TextEditingController firstnamecontroller;
  TextEditingController lastnamecontroller;
  TextEditingController telephonecontroller;
  TextEditingController usernamecontroller;
  TextEditingController emailcontroller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header("My account", context, true, true, false, true),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  personalinformation(),
                  accountInformation(),
                  changePassword(),
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
          isnotificationpageactive=false,
          ismorepageactive = true,
          context)
    );
  }

  Container changePassword() {
    return Container(
      width: 320,
      child: Card(
        elevation: 04,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 20, right: 20),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Change Password",
                      style: AppCss.black18bold,
                    ),
                    button(
                        true,
                        80,
                        33,
                        "Save",
                        AppCss.black14bold,
                        AppColors.AQUA_BLUE,
                        () {},
                        false),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: formField(
                    "Current password",
                    textfieldNewuser(41, 280, "Enter your Current password",AppCss.grey16bold,
                        usernamecontroller, true)),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20,),
                child: formField(
                    "New password",
                    textfieldNewuser(
                        41,
                        280,
                        "Enter your New password",AppCss.grey16bold,
                        emailcontroller,
                        true)),
              ),
                Padding(
                padding:
                    const EdgeInsets.only(top: 20, bottom: 20),
                child: formField(
                    "Confirm new password",
                    textfieldNewuser(
                        41,
                        280,
                        "Enter your New password",AppCss.grey16bold,
                        emailcontroller,
                        true)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container accountInformation() {
    return Container(
      width: 320,
      child: Card(
        elevation: 04,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:const EdgeInsets.only(top: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account information",
                      style: AppCss.black18bold,
                    ),
                    button(true,80,33,"Save",AppCss.black14bold,AppColors.AQUA_BLUE,() {},false),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: formField("Username",textfieldNewuser(41, 280, "WayneW",AppCss.grey16bold,
                usernamecontroller, false)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: formField("Email address",textfieldNewuser(41,280,"waynewilliams@gmail.com",AppCss.grey16bold,emailcontroller,false)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container personalinformation() {
    return Container(
    width: 320,
    child: Card(
      elevation: 04,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 20, right: 20),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/icons/editphoto.png"),
                  button(true,80,33,"Save",AppCss.black14bold,AppColors.AQUA_BLUE,() {},false),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Personal Information",
                style: AppCss.black18bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: formField(
                  "Full Name",
                  textfieldNewuser(41, 280, "Wayne",AppCss.grey16bold,
                      firstnamecontroller, false)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: formField(
                  "Last Name",
                  textfieldNewuser(41, 280, "Williams",AppCss.grey16bold,
                      lastnamecontroller, false)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: formField(
                "Date of Birth",
                dateField(41, 280, (DateTime value) {
                  // print(value);
                },AppCss.grey16bold),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 20, bottom: 20),
              child: formField(
                  "Phone number",
                  textfieldNewuser(41, 280, "921-283-8393",AppCss.grey16bold,
                      telephonecontroller, false)),
            ),
          ],
        ),
      ),
    ),
    );
  }

  Column formField(title, inputtype) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppCss.raven14regular,
        ),
        SizedBox(
          height: 05,
        ),
        inputtype,
      ],
    );
  }
}
