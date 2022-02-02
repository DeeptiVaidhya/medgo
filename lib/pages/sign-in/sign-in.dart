import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:medgo/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailcontroller = TextEditingController();

  _nextScreen(route) {
    Navigator.of(context).pushNamed(route);
  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final LocalStorage storage = new LocalStorage('medgo');
  final _loginFormKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _usernameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordKey = GlobalKey<FormFieldState>();

  String username, password;
  bool _isSignButtonEnabled = false;
  bool _incorrectPassword = false;
  bool _ispassword = false;
  bool _isusername = false;

  bool _isFormFieldValid() {
    return ((_usernameKey.currentState.isValid &&
        _passwordKey.currentState.isValid));
  }

  bool _isLabelUsernameValid() {
    if (_usernameKey.currentState.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool _isLabelPasswordValid() {
    if (_passwordKey.currentState.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  _submitLogin() {
    final form = _loginFormKey.currentState;

    if (form.validate()) {
      form.save();
      signindata();
    }
  }

  Future<void> signindata() async {
    try {
      loader(context, _keyLoader);
      //invoking login
      final data = await signIn(<String, dynamic>{
        "username": username,
        "password": password,
      });
      if (data['status'] == "success") {
        setState(() {
          storage.setItem('token', data['token']);
          storage.setItem('name', data['name']);
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.pushNamed(context, '/home');
        });
        toast(data['msg']);
      } else {
        if (data['status'] == "error" && data['show_msg_type'] == "label") {
          setState(() {
            _loginFormKey.currentState?.reset();
            Navigator.of(context, rootNavigator: true).pop();
          });
          _incorrectPassword = true;
        } else {
          setState(() {
            _loginFormKey.currentState?.reset();
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
          header("Sign in to your account", context, false, true, false, false),
      backgroundColor: AppColors.AQUA_BLUE,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: SizedBox(
                  child: buildCirclewithimg(75, 75,
                      Image.asset("assets/images/logo/logo.png"), 47.37, 47.37),
                  height: 75,
                ),
              ),
              Form(
                key: _loginFormKey,
                child: Column(children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 20),
                    child: Container(
                      width: 320,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(new RegExp(r"\s"))
                        ],
                        initialValue: (storage.getItem('password') != null)
                            ? storage.getItem('password')
                            : null,
                        key: _usernameKey,
                        cursorColor: AppColors.RAVEN,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText:
                                  'Username or Email Address field is required'),
                        ]),
                        onChanged: (value) {
                          setState(() {
                            _usernameKey.currentState.validate();
                            _isSignButtonEnabled = _isFormFieldValid();
                            _isusername = _isLabelUsernameValid();
                          });
                        },
                        onSaved: (e) => username = e,
                        style: AppCss.grey16medium,
                        decoration: InputDecoration(
                          errorStyle: AppCss.red12medium,
                          contentPadding: EdgeInsets.only(
                              top: 18, bottom: 17, left: 20, right: 20),
                          hintText: "Enter username or email address.",
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 20),
                    child: Container(
                      width: 320,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(new RegExp(r"\s"))
                        ],
                        initialValue: (storage.getItem('password') != null)
                            ? storage.getItem('password')
                            : null,
                        key: _passwordKey,
                        cursorColor: AppColors.RAVEN,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "Password filed is required."),
                          // MinLengthValidator(8,
                          //     errorText:
                          //         "Password must be at least 8 digits long"),
                          // PatternValidator(
                          //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                          //     errorText:
                          //         "Passwords must have at least one capital,numeric and special character")
                        ]),
                        obscureText: true,
                        // onChanged: (value) {
                        //   setState(() {
                        //     _passwordKey.currentState.validate();
                        //     _ispassword = _isLabelPasswordValid();
                        //   });
                        // },
                        onSaved: (e) => password = e,
                        style: AppCss.grey16medium,
                        decoration: InputDecoration(
                          errorStyle: AppCss.red12medium,
                          contentPadding: EdgeInsets.only(
                              top: 18, bottom: 17, left: 20, right: 20),
                          hintText: "Enter your password",
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
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: GestureDetector(
                  onTap: () {
                    _nextScreen("/forgottenpassword");
                  },
                  child: Text(
                    "I forgot my password",
                    style: AppCss.black16boldunderline,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 38, left: 40, right: 40),
                child: button(true, 320, 54, "Sign in", AppCss.white18bold,
                    AppColors.PINK, () {
                  if (_passwordKey.currentState.value.length > 7) {
                    _submitLogin();
                  } else {
                    errortoast("Username or password required.");
                  }
                }, false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
