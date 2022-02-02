import 'package:flutter/material.dart';

const FontWeight w100 = FontWeight.w100; //Thin
const FontWeight w200 = FontWeight.w200; //ExtraLight
const FontWeight w300 = FontWeight.w300; //Light
const FontWeight w400 = FontWeight.w400; //Regular
const FontWeight w500 = FontWeight.w500; //Medium
const FontWeight w600 = FontWeight.w600; //SemiBold
const FontWeight w700 = FontWeight.w700; //Bold
const FontWeight w800 = FontWeight.w800; //ExtraBold
const FontWeight w900 = FontWeight.w900; //Black

class AppColors {
  static const Color AQUA_BLUE = Color(0xFF57C5FF); // #57C5FF
  static const Color BUNKER = Color(0xFF20252B); // #20252B
  static const Color WHITE = Color(0xFFFFFFFF); // #FFFFFF
  static const Color PINK = Color(0xFFF539A5); // #F539A5
  static const Color MISCHKA = Color(0xFFAAB2BD); // #AAB2BD
  static const Color CYAN_BLUE = Color(0xFF4671C6); // #4671C6
  static const Color MANDY = Color(0xffDA4553); //#DA4553
  static const Color RAVEN = Color(0xff656D78); //#656D78
  static const Color DENIM = Color(0xff1C63C1); //#1C63C1
  static const Color YELLOW = Color(0xffFDC00F); //#FDC00F
  static const Color SKY = Color(0xff0785B7); //#0785B7
  static const Color LIGHT_BLACK = Color(0xff434A54); //#434A54
  static const Color LIGHT_GREY = Color(0xff707070); //#707070
  static const Color SHADOWCOLOR = Color(0xFF0000001A); // #33333326
}

class AppCss {
  static final grey12medium = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w500,
      color: AppColors.RAVEN,
      fontSize: 12.0);
  static final greylight16medium = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w500,
      color: AppColors.MISCHKA,
      fontSize: 16.0);
  static final greylight12semimedium = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w600,
      color: AppColors.MISCHKA,
      fontSize: 12.0);
  static final grey7bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.RAVEN,
      fontSize: 7.0);
  static final red12medium = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w500,
      color: AppColors.MANDY,
      fontSize: 12.0);
  static final black30bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.BUNKER,
      fontSize: 30.0);
  static final black32bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.BUNKER,
      fontSize: 32.0);
  static final black16medium = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w500,
      color: AppColors.BUNKER,
      fontSize: 16.0);
  static final black16regular = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w400,
      color: AppColors.BUNKER,
      fontSize: 16.0);

  static final aquablue16regular = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w400,
      color: AppColors.AQUA_BLUE,
      fontSize: 16.0);
  static final black16boldunderline = TextStyle(
      decoration: TextDecoration.underline,
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.BUNKER,
      fontSize: 16.0);
  static final white18bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.WHITE,
      fontSize: 18.0);
  static final black20bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.BUNKER,
      fontSize: 20.0);
  static final black21bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.BUNKER,
      fontSize: 21.0);
  static final black22bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.BUNKER,
      fontSize: 22.0);
  static final grey16medium = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w500,
      color: AppColors.MISCHKA,
      fontSize: 16.0);
  static final grey16bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.LIGHT_GREY,
      fontSize: 16.0);
  static final lightgrey16bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.LIGHT_GREY,
      fontSize: 16.0);
  static final lightgrey16regular = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w400,
      color: AppColors.LIGHT_GREY,
      fontSize: 16.0);
  static final raven16bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.RAVEN,
      fontSize: 16.0);
  static final grey14bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w600,
      color: AppColors.MISCHKA,
      fontSize: 14.0);
  static final grey18bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.MISCHKA,
      fontSize: 18.0);
  static final yellow14bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w600,
      color: AppColors.YELLOW,
      fontSize: 14.0);
  static final black16bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.BUNKER,
      fontSize: 16.0);
  static final black18bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.BUNKER,
      fontSize: 18.0);
  static final black14bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.BUNKER,
      fontSize: 14.0);

  static final black12medium = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w500,
      color: AppColors.BUNKER,
      fontSize: 12.0);
  static final black12bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.BUNKER,
      fontSize: 12.0);
  static final black12regular = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w500,
      color: AppColors.BUNKER,
      fontSize: 12.0);

  static final red14bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.MANDY,
      fontSize: 14.0);
  static final raven12meduim = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w500,
      color: AppColors.RAVEN,
      fontSize: 12.0);
  static final raven14meduim = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w500,
      color: AppColors.RAVEN,
      fontSize: 14.0);
  static final raven15meduim = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w500,
      color: AppColors.RAVEN,
      fontSize: 15.0);

  static final raven14bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.RAVEN,
      fontSize: 14.0);
  static final raven14darkbold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w900,
      color: AppColors.RAVEN,
      fontSize: 14.0);
  static final raven14regular = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w400,
      color: AppColors.RAVEN,
      fontSize: 14.0);
  static final raven12bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.RAVEN,
      fontSize: 12.0);
  static final raven7bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.RAVEN,
      fontSize: 7.0);
  static final denim12italic = TextStyle(
      fontFamily: 'Raleway',
      fontStyle: FontStyle.italic,
      color: AppColors.DENIM,
      fontSize: 12.0);
  static final denim16bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: w700,
      color: AppColors.DENIM,
      fontSize: 16.0);
  static final sky16bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w700,
      color: AppColors.SKY,
      fontSize: 16.0);
  static final lightblack30bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w700,
      color: AppColors.LIGHT_BLACK,
      fontSize: 30.0);
  static final lightblack10bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w700,
      color: AppColors.LIGHT_BLACK,
      fontSize: 10.0);
  static final lightblack14bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w700,
      color: AppColors.LIGHT_BLACK,
      fontSize: 14.0);
  static final lightblack16bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w700,
      color: AppColors.LIGHT_BLACK,
      fontSize: 16.0);
  static final white8bold = TextStyle(
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w700,
      color: AppColors.WHITE,
      fontSize: 8.0);
}
