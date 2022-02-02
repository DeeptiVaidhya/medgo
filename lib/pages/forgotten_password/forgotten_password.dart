import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:localstorage/localstorage.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';
import 'package:medgo/services/auth.dart';
import '../app-css.dart';

class ForgottenPassword extends StatefulWidget {
  @override
  _ForgottenPasswordState createState() => _ForgottenPasswordState();
}

class _ForgottenPasswordState extends State<ForgottenPassword> {
  TextEditingController textEditingController;
  final _forgotKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _emailKey = GlobalKey<FormFieldState>();
  String email;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final LocalStorage storage = new LocalStorage('medgo');
  bool _isSignButtonEnabled = false;
  bool _incorrectPassword = false;
  bool _ispassword = false;
  bool _isusername = false;
  bool isSubmit = false;
  bool _isFormFieldValid() {
    return ((_emailKey.currentState.isValid));
  }

  bool _isLabelUsernameValid() {
    if (_emailKey.currentState.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  _submitLogin() {
    setState(() {
      isSubmit = true;
    });
    final form = _forgotKey.currentState;
    if (form.validate()) {
      form.save();
      //signindata();
      forgotdata();
    }
  }

  Future<void> forgotdata() async {
    try {
      //loader(context, _keyLoader); //invoking login
      final data = await forgotPassword(<String, dynamic>{"email": email});
      if (data['status'] == "success") {
        setState(() {
          // Navigator.of(context, rootNavigator: true).pop();
          Navigator.pushNamed(context, '/signin');
          toast(data['msg']);
        });
        // toast(data['msg']);
      } else {
        if (data['status'] == "error" && data['show_msg_type'] == "label") {
          setState(() {
            _emailKey.currentState?.reset();
            Navigator.of(context, rootNavigator: true).pop();
          });
          _incorrectPassword = true;
        } else {
          setState(() {
            _emailKey.currentState?.reset();
            _isSignButtonEnabled = false;
            Navigator.of(context, rootNavigator: true).pop();
          });
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
        appBar:
            header("Forgotten password", context, false, true, false, false),
        backgroundColor: AppColors.AQUA_BLUE,
        body: Container(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: SizedBox(
                    child: buildCirclewithimg(
                        75,
                        75,
                        Image.asset("assets/images/logo/logo.png"),
                        47.37,
                        47.37),
                    height: 75,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 49),
                  child: Container(
                    width: 320,
                    child: Text(
                      "Please enter the email address you used to sign up and we’ll send you a link to reset your password.",
                      style: AppCss.black16bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
                  child: Form(
                    key: _forgotKey,
                    child: Container(
                      width: 320,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(new RegExp(r"\s"))
                        ],
                        initialValue: (storage.getItem('email') != null)
                            ? storage.getItem('email')
                            : null,
                        key: _emailKey,
                        cursorColor: AppColors.RAVEN,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'Email Address field is required'),
                        ]),
                        onChanged: (value) {
                          setState(() {
                            _emailKey.currentState.validate();
                            _isSignButtonEnabled = _isFormFieldValid();
                            _isusername = _isLabelUsernameValid();
                          });
                        },
                        onSaved: (e) => email = e,
                        style: AppCss.grey16medium,
                        decoration: InputDecoration(
                          errorStyle: AppCss.red12medium,
                          contentPadding: EdgeInsets.only(
                              top: 18, bottom: 17, left: 20, right: 20),
                          hintText: "Enter email address.",
                          hintStyle: AppCss.grey16medium,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                color: AppColors.MANDY, width: 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 66, left: 40, right: 40),
                  child: !isSubmit
                      ? button(true, 320, 54, "Sign in", AppCss.white18bold,
                          AppColors.PINK, () {
                          _submitLogin();
                        }, false)
                      : Container(
                          width: 320,
                          child: LinearProgressIndicator(
                            color: AppColors.PINK,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Go back to ",
                        style: AppCss.black16medium,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed("/signin");
                        },
                        child: Text(
                          "Sign in",
                          style: AppCss.black16boldunderline,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
