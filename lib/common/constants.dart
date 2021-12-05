import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'colorConstants.dart';


class Constants {
  static const int SPLASH_SCREEN_TIME = 2;
  static int processIndex = 0;


  static String appname = "Flutter App";
  static DateFormat commondateFormate = DateFormat("yyyy-MM-dd hh:mm:ss");
  static DateFormat ymdFormate = DateFormat("yyyy-MM-dd");
  static DateFormat dmytFormate = DateFormat("dd-MM-yyyy hh:mm:ss");
  static DateFormat dmyt1Formate = DateFormat("dd/MM/yyyy hh:mm:ss");
  static DateFormat dmythmFormate = DateFormat("dd-MM-yyyy hh:mm");
  static DateFormat dmythm1Formate = DateFormat("dd/MM/yyyy hh:mm");
  static DateFormat hmsFormate = DateFormat("hh:mm:ss");
  static DateFormat hmFormate = DateFormat("hh:mm");
  static double screenHeight,
      screenWidth,
      screenSize,
      textscaleFactor,
      blockSizeHorizontal,
      blockSizeVertical;

  static bool isVisible = false;

  static Widget buildProgressIndicator() {
    return Center(
      child: Container(
        width: Constants.screenWidth,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: ColorConstants.primaryColor,
            valueColor:
                new AlwaysStoppedAnimation<Color>(ColorConstants.whiteColor),
          ),
        ),
      ),
    );
  }

  static int page = 1;
  static int AllProductPage = 1;
  static String currentPage="";

}

class validationMsg {
  static String emailNotEnter = 'Enter email';
  static String noInternet = 'Please connect to the internet to continue.';
}

class reqserver {
  static String baseurl = 'https://team3.devhostserver.com/onetreeworld/';
  static String getBase1 = 'team3.devhostserver.com';
  static String getBase2 = '/onetreeworld/';

  // static String baseurl = 'http://68.183.179.16/onetreeworld/';
  static String consumerKey = 'ck_4e524982a35636177f18b94b037103dc1c1c11a5';
  static String consumerSecret = 'cs_aab9b3cb6538e30a6c2a659fcb4b013eab9ba526';
  static String imgbaseurl = 'http://guard-my-vote.s3.us-east-2.amazonaws.com/';

  static String loginUrl = 'auth/login';
  static String forgotpwdUrl = 'auth/forgot-password';
  static String getCMSpageUrl = 'get-cms-page-links';
  static String logoutUrl = 'auth/logout';
  static String getSurveyCountUrl = 'get-survey-count';
  static String getSurveyListUrl = 'get-survey-list';
  static String getSurveyQuestionUrl = 'get-survey-questions';
}
