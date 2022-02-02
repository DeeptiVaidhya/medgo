import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:localstorage/localstorage.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';
import 'package:medgo/services/auth.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _signupFormKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final LocalStorage storage = new LocalStorage('medgo');
  final GlobalKey<FormFieldState> _fnameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _lnameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _userNameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _confirmPassKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _emailKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _phoneNoKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _dobKey = GlobalKey<FormFieldState>();
  String fname,
      lname,
      email,
      password,
      confirmPassword,
      username,
      dob,
      phoneNo,
      monthDob,
      monthIDob,
      dayDob,
      yearDob,
      userAvatar;
  var isuniques = {'email': false, 'username': false, 'phone_number': false};
  int _stepNumber = 1;

  bool _isPasswordEightCharacter = false;
  bool _isPasswordSpace = false;
  bool _isPasswordUppercase = false;
  bool _isPasswordLowercase = false;
  bool _isPasswordNumber = false;
  bool _isPasswordSpecialsymbol = false;

  bool _isCPasswordEightCharacter = false;
  bool _isCPasswordSpace = false;
  bool _isCPasswordUppercase = false;
  bool _isCPasswordLowercase = false;
  bool _isCPasswordNumber = false;
  bool _isCPasswordSpecialsymbol = false;
  bool _isPass = false;
  bool _isCPass = false;
  bool _isDateValidate = true;

  final avatars = [
    {'1': 'Avatar1.png', '2': 'Avatar2.png', '3': 'Avatar3.png'},
    {'4': 'Avatar4.png', '5': 'Avatar5.png', '6': 'Avatar6.png'},
    {'7': 'Avatar7.png', '8': 'Avatar8.png', '9': 'Avatar9.png'},
  ];

  @override
  void initState() {
    super.initState();
  }

  bool _isPasswordEightCharacterValid() {
    if (_passwordKey.currentState.value.length > 7) {
      return true;
    } else {
      return false;
    }
  }

  bool _isPasswordSpaceValid() {
    if (_passwordKey.currentState.value.length > 0) {
      if (_passwordKey.currentState.value.indexOf(' ') >= 0) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  bool _isPasswordUppercaseValid() {
    if (_passwordKey.currentState.value.length > 0) {
      return _passwordKey.currentState.value.contains(RegExp(r'[A-Z]'));
    } else {
      return false;
    }
  }

  bool _isPasswordLowercaseValid() {
    if (_passwordKey.currentState.value.length > 0) {
      return _passwordKey.currentState.value.contains(RegExp(r'[a-z]'));
    } else {
      return false;
    }
  }

  bool _isPasswordNumberValid() {
    if (_passwordKey.currentState.value.length > 0) {
      return _passwordKey.currentState.value.contains(RegExp(r'[0-9]'));
    } else {
      return false;
    }
  }

  bool _isPasswordSpecialsymbolValid() {
    if (_passwordKey.currentState.value.length > 0) {
      return _passwordKey.currentState.value
          .contains(RegExp(r'[@#$%^&*(),.?":{}|<>]'));
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

  bool _isLabelConfirmPasswordValid() {
    if (_confirmPassKey.currentState.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool _isCPasswordEightCharacterValid() {
    if (_confirmPassKey.currentState.value.length > 7) {
      return true;
    } else {
      return false;
    }
  }

  bool _isCPasswordSpaceValid() {
    if (_confirmPassKey.currentState.value.length > 0) {
      if (_confirmPassKey.currentState.value.indexOf(' ') >= 0) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  bool _isCPasswordUppercaseValid() {
    if (_confirmPassKey.currentState.value.length > 0) {
      return _confirmPassKey.currentState.value.contains(RegExp(r'[A-Z]'));
    } else {
      return false;
    }
  }

  bool _isCPasswordLowercaseValid() {
    if (_confirmPassKey.currentState.value.length > 0) {
      return _confirmPassKey.currentState.value.contains(RegExp(r'[a-z]'));
    } else {
      return false;
    }
  }

  bool _isCPasswordNumberValid() {
    if (_confirmPassKey.currentState.value.length > 0) {
      return _confirmPassKey.currentState.value.contains(RegExp(r'[0-9]'));
    } else {
      return false;
    }
  }

  bool _isCPasswordSpecialsymbolValid() {
    if (_confirmPassKey.currentState.value.length > 0) {
      return _confirmPassKey.currentState.value
          .contains(RegExp(r'[@#$%^&*(),.?":{}|<>]'));
    } else {
      return false;
    }
  }

  bool _isValidDate(y, m, d) {
    var emptyValue = ["", null, false, 0];
    if (emptyValue.contains(y) ||
        emptyValue.contains(m) ||
        emptyValue.contains(d)) {
      return false;
    }

    y = y.padLeft(4, '0');
    m = m.padLeft(2, '0');
    d = d.padLeft(2, '0');
    var input = "$y$m$d";
    final date = DateTime.parse(input);
    final originalFormatString = toOriginalFormatString(date);
    return input == originalFormatString;
  }

  String toOriginalFormatString(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    var date = "$y$m$d";
    return date;
  }

  void saveData() {
    final form = _signupFormKey.currentState;
    if (form.validate()) {
      form.save();
      signupData();
    }
  }

  Future<void> signupData() async {
    try {
      loader(context, _keyLoader); //invoking login
      final data = await signup(<String, dynamic>{
        "username": username,
        "email": email,
        "password": password,
        "confirm_password": confirmPassword,
        "first_name": fname,
        "last_name": lname,
        "phone_number": phoneNo,
        "dob": "$dayDob-$monthIDob-$yearDob",
        "avatar": userAvatar
      });
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.pushNamed(context, '/signup-thankyou');
        });
        toast(data['msg']);
      } else {
        if (data['status'] == "error" && data['show_msg_type'] == "label" ||
            data['msg_type'] == "multiple") {
          setState(() {
            _signupFormKey.currentState?.reset();
            Navigator.of(context, rootNavigator: true).pop();
          });
          errortoast(data['msg']);
          errortoast(data['error']['email']);
          errortoast(data['error']['password']);
          errortoast(data['error']['phone_number']);
          errortoast(data['error']['username']);
        } else {
          setState(() {
            _signupFormKey.currentState?.reset();
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

  Future<void> isUniqueValue({key, value}) async {
    var isUnique = false;
    try {
      final data = await checkUniqueValue(<String, dynamic>{
        "key": key,
        "value": value,
      });
      if (data['status'] == "success") {
        isUnique = true;
      } else {
        isUnique = false;
      }
    } catch (err) {
      print('Caught error: $err');
      isUnique = false;
    }
    setState(() {
      isuniques[key] = isUnique;
    });
  }

  void nextPrev(
      {isBack = false, key, skipValidation = false, isCustomValidate = false}) {
    var goTo = _stepNumber;
    if (!isBack) {
      skipValidation
          ? goTo += 1
          : (!isCustomValidate && key.currentState.validate() ? goTo += 1 : '');
    } else {
      goTo -= 1;
    }
    goTo = goTo < 1 ? Navigator.pushNamed(context, '/') : (goTo > 9 ? 9 : goTo);
    setState(() {
      _stepNumber = goTo;
    });
  }

  var month = [
    "JANUARY",
    "FEBRUARY",
    "MARCH",
    "APRIL",
    "MAY",
    "JUNE",
    "JULY",
    "AUGUEST",
    "SEPTEMBER",
    "OCTOBER",
    "NOVEMBER",
    "DECEMBER"
  ];
  var date = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31
  ];
  var year = [
    1970,
    1971,
    1972,
    1973,
    1974,
    1975,
    1976,
    1977,
    1978,
    1979,
    1980,
    1981,
    1982,
    1983,
    1984,
    1985,
    1986,
    1987,
    1988,
    1989,
    1990,
    1991,
    1992,
    1993,
    1994,
    1995,
    1996,
    1997,
    1998,
    1999,
    2000,
    2001,
    2002,
    2003,
    2004,
    2005,
    2006,
    2007,
    2008,
    2009,
    2010,
    2011,
    2012,
    2013,
    2014,
    2015,
    2016,
    2017,
    2018,
    2019,
    2020,
    2021
  ];

  void nextField({String value, FocusNode focusNode}) {
    if (value.isNotEmpty) {
      focusNode.requestFocus();
    }
  }

  FocusNode Anniversary;

  Column fnameBuilder() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 26, left: 20, right: 20),
          child: Center(
            child: Container(
              width: 320,
              child: Text(
                "First name",
                style: AppCss.black16bold,
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              width: 320,
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(new RegExp(r"\s"))
                ],
                key: _fnameKey,
                cursorColor: AppColors.RAVEN,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'First name field is required.'),
                ]),
                initialValue: fname,
                onChanged: (value) {
                  fname = value;
                  setState(() {
                    _fnameKey.currentState.validate();
                  });
                },
                style: AppCss.grey16medium,
                decoration: InputDecoration(
                  errorStyle: AppCss.red12medium,
                  contentPadding:
                      EdgeInsets.only(top: 18, bottom: 17, left: 20, right: 20),
                  hintText: "Enter your first name",
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
                    borderSide:
                        const BorderSide(color: AppColors.MANDY, width: 1),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 280, left: 40, right: 40, bottom: 20),
          child: button(
              true, 320, 54, "Next", AppCss.white18bold, AppColors.PINK, () {
            nextPrev(key: _fnameKey);
          }, false),
        ),
      ],
    );
  }

  Column lnameBuilder() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 26, left: 20, right: 20),
          child: Center(
            child: Container(
              width: 320,
              child: Text(
                "Last name",
                style: AppCss.black16bold,
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              width: 320,
              child: TextFormField(
                //controller: ctl_lname,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(new RegExp(r"\s"))
                ],
                key: _lnameKey,
                initialValue: lname,
                cursorColor: AppColors.RAVEN,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Last name field is required.'),
                ]),
                onChanged: (value) {
                  lname = value;
                  setState(() {
                    _lnameKey.currentState.validate();
                  });
                },
                // onSaved: (e) => lname = e,
                style: AppCss.grey16medium,
                decoration: InputDecoration(
                  errorStyle: AppCss.red12medium,
                  contentPadding:
                      EdgeInsets.only(top: 18, bottom: 17, left: 20, right: 20),
                  hintText: "Enter your last name",
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
                    borderSide:
                        const BorderSide(color: AppColors.MANDY, width: 1),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 280, left: 40, right: 40, bottom: 20),
          child: button(
              true, 320, 54, "Next", AppCss.white18bold, AppColors.PINK, () {
            nextPrev(key: _lnameKey);
          }, false),
        ),
      ],
    );
  }

  Column dobBuilder() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 26, left: 20, right: 20),
          child: Center(
            child: Container(
              width: 320,
              child: Text(
                "Date of birth",
                style: AppCss.black16bold,
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.WHITE,
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                          color: _isDateValidate
                              ? Color(0xffD5D5D5)
                              : AppColors.MANDY,
                          width: 1)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Container(
                        width: 64,
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text("Month", style: AppCss.greylight16medium),
                      ),
                      value: monthDob,
                      key: _dobKey,
                      icon: Icon(Icons.arrow_drop_down, color: AppColors.SKY),
                      iconSize: 25.0,
                      iconEnabledColor: AppColors.SKY,
                      items: month.map((item) {
                        return DropdownMenuItem<String>(
                            value: item,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(item,
                                  style: AppCss.greylight12semimedium),
                            ));
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          monthDob = null;
                          monthIDob = null;
                          if (value != '' && value.isNotEmpty) {
                            monthDob = value;
                            monthIDob = (month.indexOf(value) + 1).toString();
                          }
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: AppColors.WHITE,
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                          color: _isDateValidate
                              ? Color(0xffD5D5D5)
                              : AppColors.MANDY,
                          width: 1)),
                  child: DropdownButton<String>(
                    hint: Container(
                      width: 64,
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text("Day", style: AppCss.greylight16medium),
                    ),
                    value: dayDob,
                    underline: Container(),
                    icon: Icon(Icons.arrow_drop_down, color: AppColors.SKY),
                    iconSize: 25.0,
                    iconEnabledColor: AppColors.SKY,
                    items: date.map((int dayText) {
                      return DropdownMenuItem<String>(
                          value: dayText.toString(),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(dayText.toString(),
                                style: AppCss.greylight12semimedium),
                          ));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dayDob = (value != '') ? value : null;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: AppColors.WHITE,
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                          color: _isDateValidate
                              ? Color(0xffD5D5D5)
                              : AppColors.MANDY,
                          width: 1)),
                  child: DropdownButton<String>(
                    hint: Container(
                      width: 64,
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text("Year", style: AppCss.greylight16medium),
                    ),
                    value: yearDob,
                    underline: Container(),
                    icon: Icon(Icons.arrow_drop_down, color: AppColors.SKY),
                    iconSize: 25.0,
                    iconEnabledColor: AppColors.SKY,
                    items: year.map((int dayYear) {
                      return DropdownMenuItem<String>(
                          value: dayYear.toString(),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(dayYear.toString(),
                                style: AppCss.greylight12semimedium),
                          ));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        yearDob = (value != '') ? value : null;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          // decoration:BoxDecoration(color: Colors.blue),
          width: 320,
          child: !_isDateValidate
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  child: Text(
                    'Please select date of birth',
                    style: AppCss.red12medium,
                    textAlign: TextAlign.left,
                  ),
                )
              : Container(),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 280, left: 40, right: 40, bottom: 20),
          child: button(
              true, 320, 54, "Next", AppCss.white18bold, AppColors.PINK, () {
            setState(() {
              _isDateValidate = _isValidDate(yearDob, monthIDob, dayDob);
            });

            // print({
            //   'month': monthIDob,
            //   'dayText': dayDob,
            //   'dayYear': yearDob,
            //   'valid': _isDateValidate
            // });

            nextPrev(
                key: _dobKey,
                skipValidation: _isDateValidate,
                isCustomValidate: true);
          }, false),
        ),
      ],
    );
  }

  Column phoneNoBuilder() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 26, left: 20, right: 20),
          child: Center(
            child: Container(
              width: 320,
              child: Text(
                "Phone number",
                style: AppCss.black16bold,
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              width: 320,
              child: TextFormField(
                /// controller: ctl_phoneNo,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  FilteringTextInputFormatter.deny(new RegExp(r"\s")),
                ],
                key: _phoneNoKey,
                initialValue: phoneNo,
                cursorColor: AppColors.RAVEN,
                // validator: MultiValidator([
                //   RequiredValidator(
                //       errorText: 'Phone number field is required.'),
                //   MinLengthValidator(10,
                //       errorText: 'Please provide a valid phone number.'),
                //   PatternValidator(r'^(?:[+0][1-9])?[0-9]{10,12}$',
                //       errorText: 'Please provide a valid phone number.')
                // ]),

                validator: (value) {
                  var error = MultiValidator([
                    RequiredValidator(
                        errorText: 'Phone number field is required.'),
                    MinLengthValidator(10,
                        errorText: 'Please provide a valid phone number.'),
                    PatternValidator(r'^(?:[+0][1-9])?[0-9]{10,12}$',
                        errorText: 'Please provide a valid phone number.')
                  ]).call(value);

                  isUniqueValue(
                    key: 'phone_number',
                    value: value,
                  );
                  if (!isuniques['phone_number']) {
                    error = 'Phone number already has been taken.';
                  }

                  return error;
                },
                onChanged: (value) {
                  phoneNo = value;
                },
                // onSaved: (e) => phoneNo = e,
                style: AppCss.grey16medium,
                decoration: InputDecoration(
                  errorStyle: AppCss.red12medium,
                  contentPadding:
                      EdgeInsets.only(top: 18, bottom: 17, left: 20, right: 20),
                  hintText: "Enter your phone number",
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
                    borderSide:
                        const BorderSide(color: AppColors.MANDY, width: 1),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 280, left: 40, right: 40, bottom: 20),
          child: button(
              true, 320, 54, "Next", AppCss.white18bold, AppColors.PINK, () {
            nextPrev(key: _phoneNoKey);
          }, false),
        ),
      ],
    );
  }

  Column emailBuilder() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 26, left: 20, right: 20),
          child: Center(
            child: Container(
              width: 320,
              child: Text(
                "Email address",
                style: AppCss.black16bold,
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              width: 320,
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(new RegExp(r"\s"))
                ],
                key: _emailKey,
                initialValue: email,
                cursorColor: AppColors.RAVEN,
                // validator: MultiValidator([
                //   RequiredValidator(errorText: 'Email field is required.'),
                //   EmailValidator(errorText: 'Please provide a valid email.'),
                // ]),
                validator: (value) {
                  var error = MultiValidator([
                    RequiredValidator(errorText: 'Email field is required.'),
                    EmailValidator(errorText: 'Please provide a valid email.'),
                  ]).call(value);

                  isUniqueValue(
                    key: 'email',
                    value: value,
                  );
                  if (!isuniques['email']) {
                    error = 'Email already has been taken.';
                  }

                  return error;
                },

                onChanged: (value) {
                  email = value;
                  setState(() {
                    _emailKey.currentState.validate();
                  });
                },
                // onSaved: (e) => email = e,
                style: AppCss.grey16medium,
                decoration: InputDecoration(
                  errorStyle: AppCss.red12medium,
                  contentPadding:
                      EdgeInsets.only(top: 18, bottom: 17, left: 20, right: 20),
                  hintText: "Enter your email address",
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
                    borderSide:
                        const BorderSide(color: AppColors.MANDY, width: 1),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 280, left: 40, right: 40, bottom: 20),
          child: button(
              true, 320, 54, "Next", AppCss.white18bold, AppColors.PINK, () {
            nextPrev(key: _emailKey);
          }, false),
        ),
      ],
    );
  }

  Column usernameBuilder() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 26, left: 20, right: 20),
          child: Center(
            child: Container(
              width: 320,
              child: Text(
                "Add a username",
                style: AppCss.black16bold,
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              width: 320,
              child: TextFormField(
                //controller: ctl_username,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(new RegExp(r"\s"))
                ],
                key: _userNameKey,
                initialValue: username,
                cursorColor: AppColors.RAVEN,
                // validator: MultiValidator([
                //   RequiredValidator(errorText: 'User name field is required.'),
                // ]),
                validator: (value) {
                  var error = MultiValidator([
                    RequiredValidator(
                        errorText: 'User name field is required.'),
                  ]).call(value);

                  isUniqueValue(
                    key: 'username',
                    value: value,
                  );
                  if (!isuniques['username']) {
                    error = 'Username already has been taken.';
                  }

                  return error;
                },
                onChanged: (value) {
                  username = value;
                  setState(() {
                    _userNameKey.currentState.validate();
                  });
                },
                // onSaved: (e) => username = e,
                style: AppCss.grey16medium,
                decoration: InputDecoration(
                  errorStyle: AppCss.red12medium,
                  contentPadding:
                      EdgeInsets.only(top: 18, bottom: 17, left: 20, right: 20),
                  hintText: "Create a user name",
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
                    borderSide:
                        const BorderSide(color: AppColors.MANDY, width: 1),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 280, left: 40, right: 40, bottom: 20),
          child: button(
              true, 320, 54, "Next", AppCss.white18bold, AppColors.PINK, () {
            nextPrev(key: _userNameKey);
          }, false),
        ),
      ],
    );
  }

  Column passwordBuilder() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 26, left: 20, right: 20),
          child: Center(
            child: Container(
              width: 320,
              child: Text(
                "Password",
                style: AppCss.black16bold,
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              width: 320,
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(new RegExp(r"\s"))
                ],
                key: _passwordKey,
                initialValue: password,
                cursorColor: AppColors.RAVEN,
                obscureText: true,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Password field is required.'),
                  MinLengthValidator(8, errorText: ""),
                  PatternValidator(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                      errorText: "")
                ]),
                onChanged: (value) {
                  password = value;
                  setState(() {
                    _passwordKey.currentState.validate();
                    _isPasswordEightCharacter =
                        _isPasswordEightCharacterValid();
                    _isPasswordSpace = _isPasswordSpaceValid();
                    _isPasswordUppercase = _isPasswordUppercaseValid();
                    _isPass = _isLabelPasswordValid();
                    _isPasswordLowercase = _isPasswordLowercaseValid();
                    _isPasswordNumber = _isPasswordNumberValid();
                    _isPasswordSpecialsymbol = _isPasswordSpecialsymbolValid();
                  });
                },
                // onSaved: (e) => password = e,
                style: AppCss.grey16medium,
                decoration: InputDecoration(
                  errorStyle: AppCss.red12medium,
                  contentPadding:
                      EdgeInsets.only(top: 18, bottom: 17, left: 20, right: 20),
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
                    borderSide:
                        const BorderSide(color: AppColors.MANDY, width: 1),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
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
                      child: Text('Your password must have the following:',
                          textAlign: TextAlign.start,
                          style: AppCss.black16bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 13),
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
                          padding: const EdgeInsets.only(right: 13),
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
                        Text('No spaces', style: AppCss.grey12medium),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 13),
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
                        Text('1 uppercase letter', style: AppCss.grey12medium),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 13),
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
                        Text('1 lowercase letter', style: AppCss.grey12medium),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 13),
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
                        Text('1 symbol (!@£%^&*)', style: AppCss.grey12medium),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 13),
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
                        Text('1 number', style: AppCss.grey12medium),
                      ]),
                    )
                  ]),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 58, left: 40, right: 40, bottom: 20),
          child: button(
              true, 320, 54, "Next", AppCss.white18bold, AppColors.PINK, () {
            nextPrev(key: _passwordKey);
          }, false),
        ),
      ],
    );
  }

  Column confirmPasswordBuilder() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 26, left: 20, right: 20),
          child: Center(
            child: Container(
              width: 320,
              child: Text(
                "Confirm password",
                style: AppCss.black16bold,
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Container(
              width: 320,
              child: TextFormField(
                //controller: ctl_confirm_password,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(new RegExp(r"\s"))
                ],
                key: _confirmPassKey,
                initialValue: confirmPassword,
                cursorColor: AppColors.RAVEN,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Password field is required.'),
                  MinLengthValidator(8, errorText: ""),
                  PatternValidator(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                      errorText: "")
                ]),
                onChanged: (value) {
                  confirmPassword = value;
                  setState(() {
                    _confirmPassKey.currentState.validate();
                    _isCPass = _isLabelConfirmPasswordValid();
                    _isCPasswordEightCharacter =
                        _isCPasswordEightCharacterValid();
                    _isCPasswordSpace = _isCPasswordSpaceValid();
                    _isCPasswordUppercase = _isCPasswordUppercaseValid();
                    _isCPasswordLowercase = _isCPasswordLowercaseValid();
                    _isCPasswordNumber = _isCPasswordNumberValid();
                    _isCPasswordSpecialsymbol =
                        _isCPasswordSpecialsymbolValid();
                  });
                },
                // onSaved: (e) => confirmPassword = e,
                style: AppCss.grey16medium,
                obscureText: true,
                decoration: InputDecoration(
                  errorStyle: AppCss.red12medium,
                  contentPadding:
                      EdgeInsets.only(top: 18, bottom: 17, left: 20, right: 20),
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
                    borderSide:
                        const BorderSide(color: AppColors.MANDY, width: 1),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
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
                      child: Text('Your password must have the following:',
                          textAlign: TextAlign.start,
                          style: AppCss.black16bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 13),
                          child: _isCPasswordEightCharacter
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
                          padding: const EdgeInsets.only(right: 13),
                          child: _isCPasswordSpace
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
                        Text('No spaces', style: AppCss.grey12medium),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 13),
                          child: _isCPasswordUppercase
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
                        Text('1 uppercase letter', style: AppCss.grey12medium),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 13),
                          child: _isCPasswordLowercase
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
                        Text('1 lowercase letter', style: AppCss.grey12medium),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 13),
                          child: _isCPasswordSpecialsymbol
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
                        Text('1 symbol (!@£%^&*)', style: AppCss.grey12medium),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 13),
                          child: _isCPasswordNumber
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
                        Text('1 number', style: AppCss.grey12medium),
                      ]),
                    )
                  ]),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 58, left: 40, right: 40, bottom: 20),
          child: button(
              true, 320, 54, "Next", AppCss.white18bold, AppColors.PINK, () {
            nextPrev(key: _confirmPassKey);
          }, false),
        ),
      ],
    );
  }

  Center avatarBuilder() {
    return Center(
        child: Container(
            // decoration: BoxDecoration(color: AppColors.LIGHT_BLACK),
            width: 320,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 40),
                  child: Text(
                    "Choose an avatar",
                    style: AppCss.black16bold,
                  ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: avatars
                        .map((arow) => new Container(
                            // decoration: BoxDecoration(color: AppColors.MANDY),
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // children: avatars.map((arow) =>new Container()),
                              children: arow.keys.map((akey) {
                                var avatar = arow[akey];
                                return new InkWell(
                                    onTap: () {
                                      setState(() {
                                        userAvatar = akey;
                                      });
                                    },
                                    child: Image.asset(
                                        "assets/images/avatar/$avatar"));
                              }).toList(),
                            )))
                        .toList()),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 40, right: 40, bottom: 20),
                  child: button(
                      true, 320, 54, "Next", AppCss.white18bold, AppColors.PINK,
                      () {
                    saveData();
                  }, false),
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: header("Create your account", context, false, true, false, false,
          callback: () {
        nextPrev(isBack: true);
      }),
      body: Container(
        height: height,
        color: AppColors.AQUA_BLUE,
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 31, left: 20, right: 20),
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
                key: _signupFormKey,
                child: Column(
                  children: [
                    Visibility(
                        visible: _stepNumber == 1, child: this.fnameBuilder()),
                    Visibility(
                        visible: _stepNumber == 2, child: this.lnameBuilder()),
                    Visibility(
                        visible: _stepNumber == 3, child: this.dobBuilder()),
                    Visibility(
                        visible: _stepNumber == 4,
                        child: this.phoneNoBuilder()),
                    Visibility(
                        visible: _stepNumber == 5, child: this.emailBuilder()),
                    Visibility(
                        visible: _stepNumber == 6,
                        child: this.usernameBuilder()),
                    Visibility(
                        visible: _stepNumber == 7,
                        child: this.passwordBuilder()),
                    Visibility(
                        visible: _stepNumber == 8,
                        child: this.confirmPasswordBuilder()),
                    Visibility(
                        visible: _stepNumber == 9, child: this.avatarBuilder()),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
