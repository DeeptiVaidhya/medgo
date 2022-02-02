import 'dart:convert';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:localstorage/localstorage.dart';
import 'package:medgo/pages/app-css.dart';
import 'package:medgo/pages/widget/dateField.dart';
import 'package:medgo/pages/widget/footer.dart';
import 'package:medgo/pages/widget/header.dart';
import 'package:medgo/pages/widget/helper.dart';
import 'package:medgo/services/auth.dart';
import 'package:file_picker/file_picker.dart';

class UserAccountDetail extends StatefulWidget {
  @override
  _UserAccountDetailState createState() => _UserAccountDetailState();
}

class _UserAccountDetailState extends State<UserAccountDetail> {
  final _editUserDetailsFormKey = GlobalKey<FormState>();
  final LocalStorage storage = new LocalStorage('medgo');
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<FormFieldState> _fullNameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _emailKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _lastNameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _cellPhoneKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _userNameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _currentPasswordKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _newPasswordKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _confirmPasswordKey =
      GlobalKey<FormFieldState>();

  var firstName;
  var lastName;
  var dob;
  var emailAdd;
  var userName;
  var phoneNumber;
  var profilePicture;
  var fullName;
  var edit;
  var email;
  var cellPhone;
  var currentPassword;
  var newPassword;
  var confirmPassword;
  var fileBytes;
  var fileName;
  var lastname;
  bool imageUpload = false;
  DateTime DOB;

  @override
  void initState() {
    super.initState();
    checkLoginToken(context);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => loader(context, _keyLoader));
    Future.delayed(Duration.zero, () {
      getUserDetails();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getUserDetails() async {
    try {
      final data = await getUserProfile(<String, dynamic>{});
      if (data['status'] == "success") {
        setState(() {
          //   print(data['data']);
          Navigator.of(context, rootNavigator: true).pop();
          firstName = data['data']['first_name'];
          lastName = data['data']['last_name'];
          emailAdd = data['data']['email'];
          userName = data['data']['username'];
          dob = data['data']['dob'];
          phoneNumber = data['data']['phone_number'];
          profilePicture = data['data']['profile_picture'];
        });
      } else {
        if (data['is_valid'] == false) {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          Navigator.pushNamed(context, '/signin');
        } else {
          if (data['status'] == "error") {
            errortoast("Invalid token");
            Navigator.pushNamed(context, '/useraccount-detail');
          }
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

  chooseImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'pdf', 'doc'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        if (file != null) {
          imageUpload = true;
          fileBytes = file.bytes;
          fileName = file.name;
        }
      });
    }
  }

  Future<void> submitProfile() async {
    loader(context, _keyLoader);
    // print(_userNameKey.currentState.value != null &&
    //     _userNameKey.currentState.value != '');
    // print("unma" + userName);
    // print(_userNameKey.currentState.value);
    try {
      final data = await saveProfile(<String, dynamic>{
        "username": (_userNameKey.currentState.value != null)
            ? _userNameKey.currentState.value
            : userName,
        "email": (_emailKey.currentState.value != null)
            ? _emailKey.currentState.value
            : emailAdd,
        "current_password": (_currentPasswordKey.currentState.value != null)
            ? _currentPasswordKey.currentState.value
            : "",
        "password": (_newPasswordKey.currentState.value != null)
            ? _newPasswordKey.currentState.value
            : "123",
        "confirm_password": (_confirmPasswordKey.currentState.value != null)
            ? _confirmPasswordKey.currentState.value
            : "",
        "first_name": (_fullNameKey.currentState.value != null)
            ? _fullNameKey.currentState.value + _lastNameKey.currentState.value
            : firstName,
        "last_name": (_lastNameKey.currentState.value != null)
            ? _lastNameKey.currentState.value
            : lastName,
        "phone_number": (_cellPhoneKey.currentState.value != null)
            ? _cellPhoneKey.currentState.value
            : phoneNumber,
        "dob": (DOB != null) ? DOB.toString() : "",
        "avatar": "1",
        "profile_picture": {
          "filename": (fileName != null) ? fileName : "",
          "filetype": "image/jpeg",
          "value": (fileBytes != null) ? base64Encode(fileBytes) : "",
        }
      });
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
        });
        Navigator.pushNamed(context, '/useraccount-detail');
        toast(data['msg']);
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
          Navigator.pushNamed(context, '/useraccount-detail');
          errortoast(data['msg']);
        }
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();
      print('Caught error: $err');
    }
  }

  logOut() async {
    final data = await logout(<String, dynamic>{});
    if (data['status'] == "success") {
      storage.clear();
      Navigator.pushNamed(context, '/signin');
    } else {
      if (data['is_valid']) {
        toast(data['msg']);
      } else {
        Navigator.pushNamed(context, '/');
        errortoast(data['msg']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //print("nts" + profilePicture.toString());
    return Scaffold(
        appBar: header("My account", context, true, true, false, true),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 375,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              child: Form(
                key: _editUserDetailsFormKey,
                child: Column(
                  children: [
                    (isVarEmpty(firstName) == '')
                        ? Container()
                        : Column(children: [
                            (edit == "edit")
                                ? Column(children: [
                                    Container(
                                      child: Card(
                                        elevation: 04,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20, right: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    (profilePicture != null)
                                                        ? InkWell(
                                                            onTap: () {
                                                              chooseImage();
                                                            },
                                                            child: Container(
                                                              height: 70,
                                                              width: 70,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .white),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                              child: (profilePicture !=
                                                                      null)
                                                                  ? getpic(
                                                                      profilePicture)
                                                                  : Image.asset(
                                                                      "assets/images/avatar/Avatar2.png"),
                                                            ),
                                                          )
                                                        : InkWell(
                                                            onTap: () {
                                                              chooseImage();
                                                            },
                                                            child: Container(
                                                              height: 70,
                                                              width: 70,
                                                              child: imageUpload
                                                                  ? Image.memory(
                                                                      fileBytes,
                                                                      width: 70,
                                                                      height:
                                                                          70,
                                                                      fit: BoxFit
                                                                          .cover)
                                                                  : Image.asset(
                                                                      "assets/images/icons/camera.png"),
                                                            ),
                                                          ),
                                                    button(
                                                        true,
                                                        80,
                                                        33,
                                                        "Save",
                                                        AppCss.black14bold,
                                                        AppColors.AQUA_BLUE,
                                                        () {
                                                      submitProfile();
                                                    }, false),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                  "Personal Information",
                                                  style: AppCss.black18bold,
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 20),
                                                child: Text("Full Name",
                                                    style:
                                                        AppCss.raven14darkbold),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 7,
                                                    bottom: 20,
                                                    right: 20),
                                                child: TextFormField(
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .deny(new RegExp(r"\s"))
                                                  ],
                                                  initialValue:
                                                      firstName.toString() +
                                                          " " +
                                                          lastName.toString(),
                                                  key: _fullNameKey,
                                                  cursorColor: AppColors.RAVEN,
                                                  validator: MultiValidator([
                                                    RequiredValidator(
                                                        errorText:
                                                            'Full name field is required'),
                                                  ]),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _fullNameKey.currentState
                                                          .validate();
                                                    });
                                                  },
                                                  onSaved: (e) => fullName = e,
                                                  style: AppCss.grey16bold,
                                                  decoration: InputDecoration(
                                                    errorStyle:
                                                        AppCss.red12medium,
                                                    hintText: "Enter full name",
                                                    hintStyle:
                                                        AppCss.grey16medium,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Color(
                                                                    0xffD5D5D5))),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xffD5D5D5))),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xffD5D5D5))),
                                                    errorBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Color(
                                                                    0xffDA4553))),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text("Last Name",
                                                    style:
                                                        AppCss.raven14darkbold),
                                              ),
                                              Container(
                                                height: 41,
                                                margin: EdgeInsets.only(
                                                    top: 7,
                                                    bottom: 20,
                                                    right: 20),
                                                child: TextFormField(
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .deny(new RegExp(r"\s"))
                                                  ],
                                                  initialValue:
                                                      lastName.toString(),
                                                  key: _lastNameKey,
                                                  cursorColor: AppColors.RAVEN,
                                                  validator: MultiValidator([
                                                    RequiredValidator(
                                                        errorText:
                                                            'Last Name field is required'),
                                                  ]),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _lastNameKey.currentState
                                                          .validate();
                                                    });
                                                  },
                                                  onSaved: (e) => lastname = e,
                                                  style: AppCss.grey16bold,
                                                  decoration: InputDecoration(
                                                    errorStyle:
                                                        AppCss.red12medium,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 18,
                                                            bottom: 17,
                                                            left: 15,
                                                            right: 20),
                                                    hintText: "Enter last name",
                                                    hintStyle:
                                                        AppCss.grey16medium,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Color(
                                                                    0xffD5D5D5))),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xffD5D5D5))),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xffD5D5D5))),
                                                    // disabledBorder: OutlineInputBorder(
                                                    //   borderRadius: BorderRadius.circular(5),
                                                    //   borderSide: BorderSide.none,
                                                    // ),
                                                    // errorBorder: OutlineInputBorder(
                                                    //   borderRadius: BorderRadius.circular(5),
                                                    //   borderSide: BorderSide.none,
                                                    // ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text("Date of Birth",
                                                    style:
                                                        AppCss.raven14darkbold),
                                              ),
                                              Container(
                                                height: 41,
                                                margin: EdgeInsets.only(
                                                    top: 7, right: 20),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    border: Border.all(
                                                        width: 1.0,
                                                        color:
                                                            AppColors.MISCHKA)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 10,
                                                  ),
                                                  child: MyDateTimeFormField(
                                                    dateTextStyle:
                                                        AppCss.raven16bold,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      hintStyle:
                                                          AppCss.raven16bold,
                                                      suffixIcon: Icon(
                                                          Icons.event_note),
                                                      hintText: "Select Dob",
                                                    ),
                                                    autovalidateMode:
                                                        AutovalidateMode.always,
                                                    validator: (e) => (e?.day ??
                                                                0) ==
                                                            1
                                                        ? 'Please not the first day'
                                                        : null,
                                                    onDateSelected:
                                                        (DateTime value) {
                                                      setState(() {
                                                        DOB = value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: Container(
                                                  child: Text("Cell phone",
                                                      style: AppCss
                                                          .raven14darkbold),
                                                ),
                                              ),
                                              Container(
                                                height: 41,
                                                margin: EdgeInsets.only(
                                                    top: 7,
                                                    bottom: 20,
                                                    right: 20),
                                                child: TextFormField(
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .deny(new RegExp(r"\s"))
                                                  ],
                                                  initialValue:
                                                      phoneNumber.toString(),
                                                  key: _cellPhoneKey,
                                                  cursorColor: AppColors.RAVEN,
                                                  validator: MultiValidator([
                                                    RequiredValidator(
                                                        errorText:
                                                            'Cell phone field is required'),
                                                  ]),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _cellPhoneKey.currentState
                                                          .validate();
                                                    });
                                                  },
                                                  onSaved: (e) => cellPhone = e,
                                                  style: AppCss.grey16bold,
                                                  decoration: InputDecoration(
                                                    errorStyle:
                                                        AppCss.red12medium,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 18,
                                                            left: 15,
                                                            right: 20),
                                                    hintText:
                                                        "Enter cell phone",
                                                    hintStyle:
                                                        AppCss.grey16medium,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Color(
                                                                    0xffD5D5D5))),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xffD5D5D5))),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xffD5D5D5))),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    errorBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Color(
                                                                    0xffDA4553))),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: Card(
                                        elevation: 04,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20, right: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Account information",
                                                        style:
                                                            AppCss.black18bold),
                                                    button(
                                                        true,
                                                        80,
                                                        33,
                                                        "Save",
                                                        AppCss.black14bold,
                                                        AppColors.AQUA_BLUE,
                                                        () {
                                                      submitProfile();
                                                    }, false),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 20),
                                                child: Text("Username",
                                                    style:
                                                        AppCss.raven14darkbold),
                                              ),
                                              Container(
                                                height: 41,
                                                margin: EdgeInsets.only(
                                                    top: 7,
                                                    bottom: 20,
                                                    right: 20),
                                                child: TextFormField(
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .deny(new RegExp(r"\s"))
                                                  ],
                                                  initialValue:
                                                      userName.toString(),
                                                  key: _userNameKey,
                                                  cursorColor: AppColors.RAVEN,
                                                  validator: MultiValidator([
                                                    RequiredValidator(
                                                        errorText:
                                                            'Username field is required'),
                                                  ]),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _userNameKey.currentState
                                                          .validate();
                                                    });
                                                  },
                                                  onSaved: (e) => fullName = e,
                                                  style: AppCss.grey16bold,
                                                  decoration: InputDecoration(
                                                    errorStyle:
                                                        AppCss.red12medium,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 25,
                                                            left: 15,
                                                            right: 20),
                                                    hintText: "Enter username",
                                                    hintStyle:
                                                        AppCss.grey16medium,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Color(
                                                                    0xffD5D5D5))),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xffD5D5D5))),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xffD5D5D5))),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text("Email address",
                                                    style:
                                                        AppCss.raven14darkbold),
                                              ),
                                              Container(
                                                height: 41,
                                                margin: EdgeInsets.only(
                                                    top: 7,
                                                    bottom: 20,
                                                    right: 20),
                                                child: TextFormField(
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .deny(new RegExp(r"\s"))
                                                  ],
                                                  initialValue:
                                                      emailAdd.toString(),
                                                  key: _emailKey,
                                                  cursorColor: AppColors.RAVEN,
                                                  validator: MultiValidator([
                                                    RequiredValidator(
                                                        errorText:
                                                            'Username or Email Address field is required'),
                                                  ]),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _emailKey.currentState
                                                          .validate();
                                                    });
                                                  },
                                                  onSaved: (e) => email = e,
                                                  style: AppCss.grey16bold,
                                                  decoration: InputDecoration(
                                                    errorStyle:
                                                        AppCss.red12medium,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 18,
                                                            left: 15,
                                                            right: 20),
                                                    hintText:
                                                        "Enter email address",
                                                    hintStyle:
                                                        AppCss.grey16medium,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Color(
                                                                    0xffD5D5D5))),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xffD5D5D5))),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xffD5D5D5))),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    errorBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Color(
                                                                    0xffDA4553))),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: Card(
                                        elevation: 04,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20, right: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Change Password",
                                                        style:
                                                            AppCss.black18bold),
                                                    button(
                                                        true,
                                                        80,
                                                        33,
                                                        "Save",
                                                        AppCss.black14bold,
                                                        AppColors.AQUA_BLUE,
                                                        () {
                                                      submitProfile();
                                                    }, false),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 20),
                                                child: Text("Current password",
                                                    style:
                                                        AppCss.raven14darkbold),
                                              ),
                                              Container(
                                                height: 41,
                                                margin: EdgeInsets.only(
                                                    top: 7,
                                                    bottom: 20,
                                                    right: 20),
                                                child: TextFormField(
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .deny(new RegExp(r"\s"))
                                                  ],
                                                  key: _currentPasswordKey,
                                                  cursorColor: AppColors.RAVEN,
                                                  validator: MultiValidator([
                                                    RequiredValidator(
                                                        errorText:
                                                            'Enter your Current password'),
                                                  ]),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _currentPasswordKey
                                                          .currentState
                                                          .validate();
                                                    });
                                                  },
                                                  onSaved: (e) =>
                                                      currentPassword = e,
                                                  style: AppCss.grey16medium,
                                                  decoration: InputDecoration(
                                                    errorStyle:
                                                        AppCss.red12medium,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 18,
                                                            left: 15,
                                                            right: 20),
                                                    hintText:
                                                        "Enter your Current password",
                                                    hintStyle:
                                                        AppCss.grey16medium,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Color(
                                                                    0xffD5D5D5))),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xffD5D5D5))),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xffD5D5D5))),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text("New password",
                                                    style:
                                                        AppCss.raven14darkbold),
                                              ),
                                              Container(
                                                height: 41,
                                                margin: EdgeInsets.only(
                                                    top: 7,
                                                    bottom: 20,
                                                    right: 20),
                                                child: TextFormField(
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .deny(new RegExp(r"\s"))
                                                  ],
                                                  key: _newPasswordKey,
                                                  cursorColor: AppColors.RAVEN,
                                                  validator: MultiValidator([
                                                    RequiredValidator(
                                                        errorText:
                                                            'Enter your New password'),
                                                  ]),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _newPasswordKey
                                                          .currentState
                                                          .validate();
                                                    });
                                                  },
                                                  onSaved: (e) =>
                                                      newPassword = e,
                                                  style: AppCss.grey16medium,
                                                  decoration: InputDecoration(
                                                    errorStyle:
                                                        AppCss.red12medium,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 18,
                                                            bottom: 17,
                                                            left: 15,
                                                            right: 20),
                                                    hintText:
                                                        "Enter your New password",
                                                    hintStyle:
                                                        AppCss.grey16medium,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Color(
                                                                    0xffD5D5D5))),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xffD5D5D5))),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xffD5D5D5))),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    errorBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Color(
                                                                    0xffDA4553))),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                    "Confirm new password",
                                                    style:
                                                        AppCss.raven14darkbold),
                                              ),
                                              Container(
                                                height: 41,
                                                margin: EdgeInsets.only(
                                                    top: 7,
                                                    bottom: 20,
                                                    right: 20),
                                                child: TextFormField(
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .deny(new RegExp(r"\s"))
                                                  ],
                                                  key: _confirmPasswordKey,
                                                  cursorColor: AppColors.RAVEN,
                                                  validator: MultiValidator([
                                                    RequiredValidator(
                                                        errorText:
                                                            'Enter your New password'),
                                                  ]),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _confirmPasswordKey
                                                          .currentState
                                                          .validate();
                                                    });
                                                  },
                                                  onSaved: (e) =>
                                                      confirmPassword = e,
                                                  style: AppCss.grey16medium,
                                                  decoration: InputDecoration(
                                                    errorStyle:
                                                        AppCss.red12medium,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 18,
                                                            bottom: 17,
                                                            left: 15,
                                                            right: 20),
                                                    hintText:
                                                        "Enter your New password",
                                                    hintStyle:
                                                        AppCss.grey16medium,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Color(
                                                                    0xffD5D5D5))),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xffD5D5D5))),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Color(
                                                                        0xffD5D5D5))),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    errorBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Color(
                                                                    0xffDA4553))),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ])
                                : Column(
                                    children: [
                                      personalinformation(firstName, lastName,
                                          phoneNumber, profilePicture),
                                      accountInformation(userName, emailAdd),
                                      changePassword(),
                                      InkWell(
                                        onTap: () {
                                          logOut();
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 20, bottom: 20),
                                          child: Card(
                                            elevation: 04,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20,
                                                            right: 20,
                                                            bottom: 20),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Sign out",
                                                              style: AppCss
                                                                  .black18bold,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ]),
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
            isnotificationpageactive = false,
            ismorepageactive = true,
            context));
  }

  Container changePassword() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
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
                padding: const EdgeInsets.only(top: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Change",
                          style: AppCss.black18bold,
                          overflow: TextOverflow.clip,
                        ),
                        Text(
                          "Password",
                          style: AppCss.black18bold,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                    button(true, 80, 33, "Edit", AppCss.lightblack14bold,
                        AppColors.WHITE, () {
                      setState(() {
                        edit = "edit";
                      });
                    }, true),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: AppCss.raven14meduim,
                    ),
                    SizedBox(
                      height: 05,
                    ),
                    Row(
                      children: [
                        passwordDots(),
                        SizedBox(
                          width: 05,
                        ),
                        passwordDots(),
                        SizedBox(
                          width: 05,
                        ),
                        passwordDots(),
                        SizedBox(
                          width: 05,
                        ),
                        passwordDots(),
                        SizedBox(
                          width: 05,
                        ),
                        passwordDots(),
                        SizedBox(
                          width: 05,
                        ),
                        passwordDots(),
                        SizedBox(
                          width: 05,
                        ),
                        passwordDots(),
                        SizedBox(
                          width: 05,
                        ),
                        passwordDots(),
                        SizedBox(
                          width: 05,
                        ),
                        passwordDots()
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container passwordDots() {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.RAVEN,
      ),
    );
  }

  Container accountInformation(userName, emailAdd) {
    return Container(
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
                padding: const EdgeInsets.only(top: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Account",
                          style: AppCss.black18bold,
                          overflow: TextOverflow.clip,
                        ),
                        Text(
                          "information",
                          style: AppCss.black18bold,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                    button(true, 80, 33, "Edit", AppCss.lightblack14bold,
                        AppColors.WHITE, () {
                      setState(() {
                        edit = "edit";
                      });
                    }, true),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: formField("Username", userName.toString()),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: formField("Email address", emailAdd.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container personalinformation(
      firstName, lastName, phoneNumber, profilePicture) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
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
                padding: const EdgeInsets.only(top: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(50)),
                      child: (profilePicture != null)
                          ? getpic(profilePicture)
                          : InkWell(
                              onTap: () {
                                chooseImage();
                              },
                              child: Image.asset(
                                  "assets/images/avatar/Avatar2.png")),
                    ),
                    button(true, 80, 33, "Edit", AppCss.lightblack14bold,
                        AppColors.WHITE, () {
                      setState(() {
                        edit = "edit";
                      });
                    }, true),
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
                child: formField("First Name", firstName.toString()),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: formField("Last Name", lastName.toString()),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: formField("Date of birth", "July 2, 2004"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: formField("Phone number", phoneNumber.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column formField(title, subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppCss.raven14meduim,
        ),
        SizedBox(
          height: 05,
        ),
        Text(
          subtitle,
          style: AppCss.raven16bold,
        ),
      ],
    );
  }
}

Widget getpic(profilePicture) {
  // print("Getting pic............");
  // print(profilePicture.toString());
  try {
    return Image.network(profilePicture);
  } catch (e) {
    print("somthing went wrong" + e);
    return Image.asset("assets/images/avatar/Avatar2.png");
  }
}
