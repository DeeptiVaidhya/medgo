import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medgo/services/auth.dart';
import 'package:localstorage/localstorage.dart';
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
  final LocalStorage storage = new LocalStorage('gemini');
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

  FocusNode focusNode;

  get code => null;
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

  @override
  void initState() {
    super.initState();
    focusNode = new FocusNode();
    //print(this.widget.code);
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
      Image.asset(
        "assets/images/bg.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar:
            header("Forgotten password", context, false, true, false, false),
        body: Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                Form(
                  key: _key,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 24, bottom: 16, left: 20, right: 20),
                        child: Text(
                          "Reset Password",
                          style: AppCss.black22bold,
                        ),
                      ),
                      //card for Email TextFormField
                      Container(
                          width: 500,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10, left: 18, bottom: 5, right: 18),
                            child: Text(
                                _isLabelPassword
                                    ? 'Password (8+ characters)'
                                    : '',
                                style: AppCss.grey12medium,
                                textAlign: TextAlign.left),
                          )),
                      Container(
                        width: 500,
                        padding: const EdgeInsets.only(
                            top: 0, left: 18, bottom: 13, right: 18),
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(new RegExp(r"\s"))
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _passwordFormKey,
                          validator: MultiValidator([
                            RequiredValidator(errorText: ""),
                            MinLengthValidator(8, errorText: ""),
                            PatternValidator(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                                errorText: "")
                          ]),
                          onChanged: (value) {
                            final trimVal = value.trim();
                            if (value != trimVal)
                              setState(() {
                                _passwordFormKey.currentState.validate();
                                _isPasswordDoneIconEnabled =
                                    _isPasswordFormFieldValid();
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
                                _isSubmitButtonEnabled = _isFormFieldValid();
                              });
                          },
                          obscureText: _securePasswordText,
                          onSaved: (e) => password = e,
                          style: AppCss.black12regular,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.AQUA_BLUE,
                            hintText: "Create a password",
                            hintStyle: AppCss.black12regular,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff666666), width: 0.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff666666), width: 0.0),
                            ),
                            suffixIcon: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween, // added line
                              mainAxisSize: MainAxisSize.min, // added line
                              children: <Widget>[
                                Icon(
                                    _isPasswordDoneIconEnabled
                                        ? Icons.done
                                        : null,
                                    color: AppColors.AQUA_BLUE),
                                IconButton(
                                  onPressed: passwordShowHide,
                                  color: Color.fromRGBO(38, 62, 114, 1),
                                  icon: Icon(_securePasswordText
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                          width: 500,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10, left: 18, bottom: 5, right: 18),
                            child: Text(
                                _isLabelConformPassword
                                    ? 'Confirm Password'
                                    : '',
                                style: AppCss.raven12meduim,
                                textAlign: TextAlign.left),
                          )),
                      Container(
                        width: 500,
                        padding: const EdgeInsets.only(
                            top: 0, left: 18, bottom: 13, right: 18),
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(new RegExp(r"\s"))
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _conformPasswordFormKey,
                          validator: MultiValidator([
                            RequiredValidator(errorText: ""),
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
                          obscureText: _secureConformPasswordText,
                          onSaved: (e) => conformpassword = e,
                          style: AppCss.raven12bold,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.AQUA_BLUE,
                            hintText: "Enter password again",
                            hintStyle: AppCss.aquablue16regular,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff666666), width: 0.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff666666), width: 0.0),
                            ),
                            suffixIcon: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween, // added line
                              mainAxisSize: MainAxisSize.min, // added line
                              children: <Widget>[
                                Icon(
                                    _isConformPasswordDoneIconEnabled
                                        ? Icons.done
                                        : null,
                                    color: AppColors.AQUA_BLUE),
                                IconButton(
                                  onPressed: conformPasswordShowHide,
                                  color: Color.fromRGBO(38, 62, 114, 1),
                                  icon: Icon(_secureConformPasswordText
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                            width: 500,
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
                                ])),
                      ),
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
