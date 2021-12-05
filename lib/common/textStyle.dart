import 'dart:ui';

import 'package:flutter/material.dart';

import 'colorConstants.dart';

class CustomTextStyle {
  static TextStyle splashWelcome({double size, double height, double width}) {
    return TextStyle(
      fontFamily: 'SourceSansPro',
      fontSize: (size == null && size == '') ? 36 : (width * size) / 375,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      // lineHeight: 47px,
      letterSpacing: -0.01,
    );
  }

  static TextStyle heading({double size, double height, double width}) {
    return TextStyle(
      fontFamily: 'SansSourceSansPro',
      fontSize: (size == null && size == '') ? 48 : (width * size) / 375,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      // lineHeight: 47px,
      letterSpacing: -0.01,
    );
  }
    static TextStyle sourceSansHeadingText({double size, double height, double width,Color fontColor}) {
      return TextStyle(
        fontFamily: 'SourceSansPro',
        color:fontColor,
        fontSize: size,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.01,
      );
    }
  static TextStyle sourceSansPlantText({double size, double height, double width,Color fontColor}) {
    return TextStyle(
      fontFamily: 'SourceSansPro',
      color:fontColor,
      fontSize: size,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.01,
    );
  }
  static TextStyle buttonText({double size, double height, double width}) {
    return TextStyle(
      fontFamily: 'Poppins',
      color: Colors.white,
      fontSize: (size == null && size == '') ? 14 : (width * size) / 375,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      // lineHeight: 47px,
      letterSpacing: -0.01,
    );
  }

  static TextStyle buttonWithNoBorder(
      {double size, double height, double width}) {
    return TextStyle(
      fontFamily: 'Poppins',
      color: ColorConstants.primaryColor,
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      // lineHeight: 47px,
      letterSpacing: -0.01,
    );
  }
  static TextStyle buttonSmallWithNoBorder(
      {double size, double height, double width}) {
    return TextStyle(
      fontFamily: 'Poppins',
      color: ColorConstants.primaryColor,
      fontSize: 14,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      // lineHeight: 47px,
      letterSpacing: -0.01,
    );
  }

  static TextStyle mediumText({double size, double height, double width,Color fontcolor}) {
    return TextStyle(
      fontFamily: 'Poppins',
      color: fontcolor,
      fontSize: (size == null && size == '') ? 24 : (width * size) / 375,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      // lineHeight: 47px,
      letterSpacing: -0.01,
    );
  }

  static TextStyle mainScreenText({double size, double height, double width,Color textColor}) {
    return TextStyle(
      fontFamily: 'OpenSans',
      color: textColor,
      fontSize: (size == null && size == '') ? 24 : (width * size) / 375,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      // lineHeight: 47px,
      letterSpacing: -0.01,
    );
  }

  static TextStyle customText({double size, double height, double width}) {
    return TextStyle(
      fontFamily: 'Poppins',
      color: ColorConstants.primaryColor,
      fontSize: (size == null && size == '') ? 24 : (width * size) / 375,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      // lineHeight: 47px,
      letterSpacing: -0.01,
    );
  }

  static TextStyle normalText({double size, double height, double width}) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      // lineHeight: 47px,
      letterSpacing: -0.01,
    );
  }
}
