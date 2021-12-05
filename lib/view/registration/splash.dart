import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/textStyle.dart';

import '../../common/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loginCheck();
  }

  void loginCheck() async {
    //   WidgetsFlutterBinding.ensureInitialized();
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   var loginStatus = prefs.getBool('isLoggedin');

    //   // var loginStatus= false;
    //   Constants.loggedInUserID = FirebaseAuth.instance.currentUser?.uid;
    //   if (loginStatus == null) loginStatus = false;
    //   if (loginStatus) {
    //     Constants.myName = prefs.getString('myName');
    //     Constants.myEmail = prefs.getString('myEmail');
    //     Constants.loggedInUserID = prefs.getString('loggedInUserID');
    //   }
    var _duartion = new Duration(
      seconds: Constants.SPLASH_SCREEN_TIME,
    );
    Timer(_duartion, () async {


          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) =>
                  LogInPage()), (Route<dynamic> route) => false);


    });
  }

  @override
  Widget build(BuildContext context) {
    Constants.screenWidth = MediaQuery.of(context).size.width;
    Constants.screenHeight = MediaQuery.of(context).size.height;
    Constants.textscaleFactor = MediaQuery.of(context).textScaleFactor;
    Constants.blockSizeHorizontal = Constants.screenWidth / 100;
    Constants.blockSizeVertical = Constants.screenHeight / 17;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: Constants.screenHeight / 4.2,
                child: Image.asset('assets/images/splashLogo.png'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Center(
                child: Container(
                  child: Text('All Project Sample',
                      style: CustomTextStyle.splashWelcome(
                          size: 30,
                          height: Constants.screenHeight,
                          width: Constants.screenWidth)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
