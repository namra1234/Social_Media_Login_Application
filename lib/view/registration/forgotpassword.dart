import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/svg.dart';
import '../../common/buttonStyle.dart';
import '../../common/colorConstants.dart';
import '../../common/constants.dart';
import '../../common/textStyle.dart';
import '../../common/validation.dart';
import '../../model/loginModel.dart';
import '../../network/service.dart';
import '../../view/registration/login.dart';
import '../../view/registration/register.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();


  String _email;



  String data;
  bool isLoading=false;
  String successMessage = '';

  // Facebook Sign In & Sign Out methods

  static final FacebookLogin facebookSignIn = new FacebookLogin();

  String _message;

  var profileData;


  void onLoginStatusChanged(bool _isSigningIn, {profileData}) {
    setState(() {
      this.profileData = profileData;
    });
  }

  void snackbar(String msg) {
    var snackBar = SnackBar(
      content: Text(msg),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus.unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: Constants.screenWidth / 20,
                right: Constants.screenWidth / 20,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(
                        height: Constants.screenHeight / 11,
                      ),
                      Center(
                        child: Container(
                          height: Constants.screenHeight / 6,
                          child: SvgPicture.asset('assets/images/splashLogo.svg'),
                        ),
                      ),
                      // SizedBox(
                      //   height: 8,
                      // ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text('Forgot Password',
                              style: CustomTextStyle.heading(
                                  size: 22,
                                  height: Constants.screenHeight,
                                  width: Constants.screenWidth)),
                        ),
                      ),
                      // SizedBox(height: Constants.screenHeight / 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
                        child: Text(
                            "Enter your email address or username, we will send you reset password link your registered email",
                            textAlign: TextAlign.center,
                            style: CustomTextStyle.mainScreenText(
                                textColor:
                                ColorConstants.blackColor.withOpacity(0.5),
                                size: 14,
                                height: Constants.screenHeight,
                                width: Constants.screenWidth)),
                      ),
                      SizedBox(height: Constants.screenHeight / 40),
                      Text('Email/Username',
                          textAlign: TextAlign.left,
                          style: CustomTextStyle.mediumText(
                              fontcolor:
                              ColorConstants.blackColor.withOpacity(0.8),
                              size: 16,
                              height: Constants.screenHeight,
                              width: Constants.screenWidth)),
                      SizedBox(height: Constants.screenHeight / 120),
                      TextFormField(
                        controller: emailController,
                        onChanged: (value) {
                          debugPrint('Something changed in Title Text Field');
                        },
                        decoration: InputDecoration(
                          hintText: "Email Address",
                          border:
                          OutlineInputBorder(borderRadius: BorderRadius.zero),
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "*Email Required";
                          } else if (!Validation.validateEmail(value)) {
                            return "*Enter Validate Email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: Constants.screenHeight / 30),
                      // SizedBox(height: Constants.screenHeight / 120),
                      // SizedBox(height: Constants.screenHeight / 40),
                      centerButton(
                          Constants.screenHeight / 15,
                          Constants.screenWidth,
                          ColorConstants.primaryColor,
                          ColorConstants.whiteColor,
                          BoxDecoration(
                            color: ColorConstants.primaryColor,
                          ),
                          "SEND EMAIL",
                          CustomTextStyle.buttonText(
                              size: 16,
                              height: Constants.screenHeight,
                              width: Constants.screenWidth),
                          sendEmail),
                      // SizedBox(
                      //   height: 14,
                      // ),

                      // Spacer(
                      //   flex: 1,
                      //
                      // ),
                      Padding(
                        padding:  EdgeInsets.only(top: Constants.screenHeight / 4.5,),
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                child: Text('ALREADY HAVE ACCOUNT ?',
                                    style: CustomTextStyle.normalText(
                                        size: 16,
                                        height: Constants.screenHeight,
                                        width: Constants.screenWidth)),
                              ),
                            ),
                            SizedBox(height: Constants.screenHeight / 80),
                            centerButton(
                                Constants.screenHeight / 15,
                                Constants.screenWidth,
                                Colors.white,
                                ColorConstants.primaryColor,
                                null,
                                "LOGIN NOW",
                                CustomTextStyle.buttonWithNoBorder(),
                                login),

                            SizedBox(height: Constants.screenHeight / 40),
                          ],
                        ),
                      ),

                      // SizedBox(
                      //   height: Constants.screenHeight / 40,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading ? true : false,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: ColorConstants.blackColor.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: ColorConstants.primaryColor,
                    valueColor: new AlwaysStoppedAnimation<Color>(ColorConstants.whiteColor),
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  login() {
    FocusManager.instance.primaryFocus.unfocus();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        LogInPage()), (Route<dynamic> route) => false);
  }

  sendEmail() async {
    FocusManager.instance.primaryFocus.unfocus();
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return null;
    }
    _formKey.currentState.save();
    setState(() {
      isLoading=true;
    });

    _email = emailController.text.trim().toLowerCase();
    dynamic body = {
      "apiName": "forgot_password",
      "user_email": _email,
    };

    //api calling

    // dynamic mobileApi = await Servicereq()
    //     .fetchdata(url: 'api_mobile.php', body: body, context: context);
    // print(mobileApi);
    //
    // if (mobileApi.statusCode == 200) {
    //   data = mobileApi.body;
    //   LoginModel logindata = LoginModel.fromJson(jsonDecode(mobileApi.body));
    //   print(logindata.success);
    //
    //   if (logindata.success == true) {
    //     setState(() {
    //       isLoading=false;
    //     });
    //     snackbar(logindata.message);
    //   } else {
    //     snackbar(logindata.message);
    //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    //         RegisterPage()), (Route<dynamic> route) => false);
    //   }
    // } else {
    //   snackbar("Something went wrong");
    // }
  }
}
