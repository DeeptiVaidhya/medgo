import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medgo/services/auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/helper.dart';

// ignore: must_be_immutable
class ResetPassword extends StatefulWidget {
  String code;
  ResetPassword({this.code});
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final _key = new GlobalKey<FormState>();

  final GlobalKey<FormFieldState> _passwordFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _conformPasswordFormKey =
      GlobalKey<FormFieldState>();
  String conformpassword, password, accessCode;

  bool _securePasswordText = true;
  bool _secureConformPasswordText = true;
  bool _isSubmitButtonEnabled = false;
  bool _isPasswordDoneIconEnabled = false;
  bool _isConformPasswordDoneIconEnabled = false;

  bool _isPasswordEightCharacter = false;
  bool _isPasswordSpace = false;
  bool _isPasswordUppercase = false;
  bool _isPasswordLowercase = false;
  bool _isPasswordNumber = false;
  bool _isPasswordSpecialsymbol = false;
  bool _isLabelPassword = false;
  bool _isLabelConformPassword = false;
  bool _isFormFieldValid() {
    return ((_passwordFormKey.currentState.isValid &&
        _conformPasswordFormKey.currentState.isValid));
  }

  bool _isPasswordFormFieldValid() {
    return ((_passwordFormKey.currentState.isValid));
  }

  bool _isConformPasswordFormFieldValid() {
    return ((_conformPasswordFormKey.currentState.isValid));
  }

  bool _isPasswordEightCharacterValid() {
    if (_passwordFormKey.currentState.value.length > 7) {
      return true;
    } else {
      return false;
    }
  }

  bool _isPasswordSpaceValid() {
    if (_passwordFormKey.currentState.value.length > 0) {
      if (_passwordFormKey.currentState.value.indexOf(' ') >= 0) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  bool _isPasswordUppercaseValid() {
    if (_passwordFormKey.currentState.value.length > 0) {
      return _passwordFormKey.currentState.value.contains(RegExp(r'[A-Z]'));
    } else {
      return false;
    }
  }

  bool _isPasswordLowercaseValid() {
    if (_passwordFormKey.currentState.value.length > 0) {
      return _passwordFormKey.currentState.value.contains(RegExp(r'[a-z]'));
    } else {
      return false;
    }
  }

  bool _isPasswordNumberValid() {
    if (_passwordFormKey.currentState.value.length > 0) {
      return _passwordFormKey.currentState.value.contains(RegExp(r'[0-9]'));
    } else {
      return false;
    }
  }

  bool _isPasswordSpecialsymbolValid() {
    if (_passwordFormKey.currentState.value.length > 0) {
      return _passwordFormKey.currentState.value
          .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    } else {
      return false;
    }
  }

  bool _isLabelPasswordValid() {
    if (_passwordFormKey.currentState.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool _isLabelConformPasswordValid() {
    if (_conformPasswordFormKey.currentState.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  FocusNode focusNode;

  get code => null;

  @override
  void initState() {
    super.initState();
    focusNode = new FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkresetCodeData());
  }

  passwordShowHide() {
    setState(() {
      _securePasswordText = !_securePasswordText;
    });
  }

  conformPasswordShowHide() {
    setState(() {
      _secureConformPasswordText = !_secureConformPasswordText;
    });
  }

  _submit() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      resetpassworddata();
    }
  }

  checkresetCodeData() async {
    String accode = this.widget.code;
    //print(accode);

    loader(context, _keyLoader); //invoking login
    final data = await checkresetPasswordCode(<String, dynamic>{
      "code": accode,
    });
    if (data['status'] == "success") {
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();
      });
    } else {
      setState(() {
        _key.currentState?.reset();
        _isSubmitButtonEnabled = false;
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushNamed(context, '/signin');
      });
      errortoast(data['msg']);
    }
  }

  resetpassworddata() async {
    String accode = this.widget.code;
    loader(context, _keyLoader); //invoking login
    final data = await resetPassword(<String, dynamic>{
      "password": password,
      "confirm_password": conformpassword,
      "code": accode,
    });
    if (data['status'] == "success") {
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushNamed(context, '/signin');
      });
      toast(data['msg']);
    } else {
      setState(() {
        _key.currentState?.reset();
        _isPasswordDoneIconEnabled = false;
        _isConformPasswordDoneIconEnabled = false;
        _isPasswordEightCharacter = false;
        _isPasswordSpace = false;
        _isPasswordUppercase = false;
        _isPasswordLowercase = false;
        _isPasswordNumber = false;
        _isPasswordSpecialsymbol = false;
        _isLabelPassword = false;
        _isLabelConformPassword = false;
        Navigator.of(context, rootNavigator: true).pop();
      });
      errortoast(data['msg']);
      errortoast(data['data']['password']);
      errortoast(data['password']);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(children: <Widget>[
      // Image.asset(
      //   "assets/images/bg.png",
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   fit: BoxFit.cover,
      // ),
      Scaffold(
        backgroundColor: AppColors.AQUA_BLUE,
        appBar: header("Reset Password", context, false, true, false, false),
        body: Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 31, left: 20, right: 20),
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
                ),
                Form(
                  key: _key,
                  child: Column(
                    children: <Widget>[
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       top: 24, bottom: 16, left: 20, right: 20),
                      //   child: Text(
                      //     "Reset Password",
                      //     style: AppCss.black22bold,
                      //   ),
                      // ),
                      //card for Email TextFormField
                      Container(
                          width: 340,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10, left: 18, bottom: 5, right: 18),
                            child: Text(
                                _isLabelPassword
                                    ? 'Password (8+ characters)'
                                    : '',
                                style: AppCss.black16bold,
                                textAlign: TextAlign.left),
                          )),
                      Container(
                        width: 350,
                        padding: const EdgeInsets.only(
                            top: 0, left: 18, bottom: 13, right: 18),
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(new RegExp(r"\s"))
                          ],
                          key: _passwordFormKey,
                          initialValue: password,
                          cursorColor: AppColors.RAVEN,
                          obscureText: true,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Password field is required.'),
                            MinLengthValidator(8, errorText: ""),
                            PatternValidator(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                                errorText: "")
                          ]),
                          onChanged: (value) {
                            password = value;
                            setState(() {
                              _passwordFormKey.currentState.validate();
                              _isPasswordEightCharacter =
                                  _isPasswordEightCharacterValid();
                              _isPasswordSpace = _isPasswordSpaceValid();
                              _isPasswordUppercase =
                                  _isPasswordUppercaseValid();
                              _isLabelPassword = _isLabelPasswordValid();
                              _isPasswordLowercase =
                                  _isPasswordLowercaseValid();
                              _isPasswordNumber = _isPasswordNumberValid();
                              _isPasswordSpecialsymbol =
                                  _isPasswordSpecialsymbolValid();
                            });
                          },
                          onSaved: (e) => password = e,
                          style: AppCss.grey16medium,
                          decoration: InputDecoration(
                            errorStyle: AppCss.red12medium,
                            contentPadding: EdgeInsets.only(
                                top: 18, bottom: 17, left: 20, right: 20),
                            hintText: "Create a password",
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
                      Container(
                          width: 350,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10, left: 18, bottom: 5, right: 18),
                            child: Text(
                                _isLabelConformPassword
                                    ? 'Confirm Password'
                                    : '',
                                style: AppCss.black16bold,
                                textAlign: TextAlign.left),
                          )),
                      Container(
                        width: 350,
                        padding: const EdgeInsets.only(
                            top: 0, left: 18, bottom: 13, right: 18),
                        child: TextFormField(
                          //controller: ctl_confirm_password,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(new RegExp(r"\s"))
                          ],
                          key: _conformPasswordFormKey,
                          //initialValue: confirmPassword,
                          cursorColor: AppColors.RAVEN,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Password field is required.'),
                            MinLengthValidator(8, errorText: ""),
                            PatternValidator(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                                errorText: "")
                          ]),
                          onChanged: (value) {
                            setState(() {
                              _conformPasswordFormKey.currentState.validate();
                              _isConformPasswordDoneIconEnabled =
                                  _isConformPasswordFormFieldValid();
                              _isLabelConformPassword =
                                  _isLabelConformPasswordValid();
                              _isSubmitButtonEnabled = _isFormFieldValid();
                            });
                          },
                          onSaved: (e) => conformpassword = e,
                          style: AppCss.grey16medium,
                          obscureText: true,
                          decoration: InputDecoration(
                            errorStyle: AppCss.red12medium,
                            contentPadding: EdgeInsets.only(
                                top: 18, bottom: 17, left: 20, right: 20),
                            hintText: "Type your password again",
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
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        child: Card(
                          child: Container(
                            width: 320,
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 20),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Text(
                                        'Your password must have the following:',
                                        textAlign: TextAlign.start,
                                        style: AppCss.black16bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 13),
                                        child: _isPasswordEightCharacter
                                            ? Image.asset(
                                                "assets/images/icons/check-icon.png",
                                                width: 14,
                                                height: 9.79)
                                            : Container(
                                                width: 8,
                                                height: 8,
                                                decoration: new BoxDecoration(
                                                  color: AppColors.LIGHT_GREY,
                                                  shape: BoxShape.circle,
                                                )),
                                      ),
                                      Text('8 characters or more',
                                          style: AppCss.grey12medium),
                                    ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 13),
                                        child: _isPasswordSpace
                                            ? Image.asset(
                                                "assets/images/icons/check-icon.png",
                                                width: 14,
                                                height: 9.79)
                                            : Container(
                                                width: 8,
                                                height: 8,
                                                decoration: new BoxDecoration(
                                                  color: AppColors.LIGHT_GREY,
                                                  shape: BoxShape.circle,
                                                )),
                                      ),
                                      Text('No spaces',
                                          style: AppCss.grey12medium),
                                    ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 13),
                                        child: _isPasswordUppercase
                                            ? Image.asset(
                                                "assets/images/icons/check-icon.png",
                                                width: 14,
                                                height: 9.79)
                                            : Container(
                                                width: 8,
                                                height: 8,
                                                decoration: new BoxDecoration(
                                                  color: AppColors.LIGHT_GREY,
                                                  shape: BoxShape.circle,
                                                )),
                                      ),
                                      Text('1 uppercase letter',
                                          style: AppCss.grey12medium),
                                    ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 13),
                                        child: _isPasswordLowercase
                                            ? Image.asset(
                                                "assets/images/icons/check-icon.png",
                                                width: 14,
                                                height: 9.79)
                                            : Container(
                                                width: 8,
                                                height: 8,
                                                decoration: new BoxDecoration(
                                                  color: AppColors.LIGHT_GREY,
                                                  shape: BoxShape.circle,
                                                )),
                                      ),
                                      Text('1 lowercase letter',
                                          style: AppCss.grey12medium),
                                    ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 13),
                                        child: _isPasswordSpecialsymbol
                                            ? Image.asset(
                                                "assets/images/icons/check-icon.png",
                                                width: 14,
                                                height: 9.79)
                                            : Container(
                                                width: 8,
                                                height: 8,
                                                decoration: new BoxDecoration(
                                                  color: AppColors.LIGHT_GREY,
                                                  shape: BoxShape.circle,
                                                )),
                                      ),
                                      Text('1 symbol (!@£%^&*)',
                                          style: AppCss.grey12medium),
                                    ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Row(children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 13),
                                        child: _isPasswordNumber
                                            ? Image.asset(
                                                "assets/images/icons/check-icon.png",
                                                width: 14,
                                                height: 9.79)
                                            : Container(
                                                width: 8,
                                                height: 8,
                                                decoration: new BoxDecoration(
                                                  color: AppColors.LIGHT_GREY,
                                                  shape: BoxShape.circle,
                                                )),
                                      ),
                                      Text('1 number',
                                          style: AppCss.grey12medium),
                                    ]),
                                  )
                                ]),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20),
                      //   child: Container(
                      //       width: 500,
                      //       child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Padding(
                      //               padding: const EdgeInsets.only(bottom: 20),
                      //               child: Text(
                      //                   'Your password must have the following:',
                      //                   textAlign: TextAlign.start,
                      //                   style: AppCss.black16bold),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(bottom: 10),
                      //               child: Row(children: [
                      //                 Padding(
                      //                   padding:
                      //                       const EdgeInsets.only(right: 13),
                      //                   child: _isPasswordEightCharacter
                      //                       ? Image.asset(
                      //                           "assets/images/icons/check-icon.png",
                      //                           width: 14,
                      //                           height: 9.79)
                      //                       : Container(
                      //                           width: 8,
                      //                           height: 8,
                      //                           decoration: new BoxDecoration(
                      //                             color: AppColors.LIGHT_GREY,
                      //                             shape: BoxShape.circle,
                      //                           )),
                      //                 ),
                      //                 Text('8 characters or more',
                      //                     style: AppCss.grey12medium),
                      //               ]),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(bottom: 10),
                      //               child: Row(children: [
                      //                 Padding(
                      //                   padding:
                      //                       const EdgeInsets.only(right: 13),
                      //                   child: _isPasswordSpace
                      //                       ? Image.asset(
                      //                           "assets/images/icons/check-icon.png",
                      //                           width: 14,
                      //                           height: 9.79)
                      //                       : Container(
                      //                           width: 8,
                      //                           height: 8,
                      //                           decoration: new BoxDecoration(
                      //                             color: AppColors.LIGHT_GREY,
                      //                             shape: BoxShape.circle,
                      //                           )),
                      //                 ),
                      //                 Text('No spaces',
                      //                     style: AppCss.grey12medium),
                      //               ]),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(bottom: 10),
                      //               child: Row(children: [
                      //                 Padding(
                      //                   padding:
                      //                       const EdgeInsets.only(right: 13),
                      //                   child: _isPasswordUppercase
                      //                       ? Image.asset(
                      //                           "assets/images/icons/check-icon.png",
                      //                           width: 14,
                      //                           height: 9.79)
                      //                       : Container(
                      //                           width: 8,
                      //                           height: 8,
                      //                           decoration: new BoxDecoration(
                      //                             color: AppColors.LIGHT_GREY,
                      //                             shape: BoxShape.circle,
                      //                           )),
                      //                 ),
                      //                 Text('1 uppercase letter',
                      //                     style: AppCss.grey12medium),
                      //               ]),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(bottom: 10),
                      //               child: Row(children: [
                      //                 Padding(
                      //                   padding:
                      //                       const EdgeInsets.only(right: 13),
                      //                   child: _isPasswordLowercase
                      //                       ? Image.asset(
                      //                           "assets/images/icons/check-icon.png",
                      //                           width: 14,
                      //                           height: 9.79)
                      //                       : Container(
                      //                           width: 8,
                      //                           height: 8,
                      //                           decoration: new BoxDecoration(
                      //                             color: AppColors.LIGHT_GREY,
                      //                             shape: BoxShape.circle,
                      //                           )),
                      //                 ),
                      //                 Text('1 lowercase letter',
                      //                     style: AppCss.grey12medium),
                      //               ]),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(bottom: 10),
                      //               child: Row(children: [
                      //                 Padding(
                      //                   padding:
                      //                       const EdgeInsets.only(right: 13),
                      //                   child: _isPasswordSpecialsymbol
                      //                       ? Image.asset(
                      //                           "assets/images/icons/check-icon.png",
                      //                           width: 14,
                      //                           height: 9.79)
                      //                       : Container(
                      //                           width: 8,
                      //                           height: 8,
                      //                           decoration: new BoxDecoration(
                      //                             color: AppColors.LIGHT_GREY,
                      //                             shape: BoxShape.circle,
                      //                           )),
                      //                 ),
                      //                 Text('1 symbol (!@£%^&*)',
                      //                     style: AppCss.grey12medium),
                      //               ]),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(bottom: 20),
                      //               child: Row(children: [
                      //                 Padding(
                      //                   padding:
                      //                       const EdgeInsets.only(right: 13),
                      //                   child: _isPasswordNumber
                      //                       ? Image.asset(
                      //                           "assets/images/icons/check-icon.png",
                      //                           width: 14,
                      //                           height: 9.79)
                      //                       : Container(
                      //                           width: 8,
                      //                           height: 8,
                      //                           decoration: new BoxDecoration(
                      //                             color: AppColors.LIGHT_GREY,
                      //                             shape: BoxShape.circle,
                      //                           )),
                      //                 ),
                      //                 Text('1 number',
                      //                     style: AppCss.grey12medium),
                      //               ]),
                      //             )
                      //           ])),
                      // ),
                      button(
                          _isSubmitButtonEnabled,
                          320,
                          54,
                          "SUBMIT",
                          AppCss.white18bold,
                          AppColors.PINK,
                          _isSubmitButtonEnabled
                              ? () {
                                  _submit();
                                }
                              : null,
                          false),
                      // button(
                      //     btnwidth = 295,
                      //     btnheight = 44,
                      //     btntext = 'SUBMIT',
                      //     _isSubmitButtonEnabled
                      //         ? AppCss.blue14bold
                      //         : AppCss.white14bold,
                      //     _isSubmitButtonEnabled
                      //         ? AppColors.LIGHT_ORANGE
                      //         : AppColors.LIGHT_GREY,
                      //     btntypesubmit = true,
                      //     _isSubmitButtonEnabled
                      //         ? () {
                      //             _submit();
                      //           }
                      //         : null,
                      //     13,
                      //     13,
                      //     92,
                      //     91,
                      //     context),
                    ],
                  ),
                ),
              ])),
        ),
      )
    ]);
  }
}
