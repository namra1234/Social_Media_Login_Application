import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import '../../common/buttonStyle.dart';
import '../../common/colorConstants.dart';
import '../../common/constants.dart';
import '../../common/textStyle.dart';
import '../../common/util.dart';
import '../../common/validation.dart';
import '../../model/facebook/modelFacebookData.dart';
import '../../model/google/google_sign_in.dart';
import '../../model/loginModel.dart';
import '../../network/service.dart';
import '../../view/bottomItem/mainscreen.dart';
import '../../view/registration/register.dart';
import 'completeprofile.dart';
import 'forgotpassword.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _email;
  String _password;

  bool _isObscure = false;
  bool isLoading=false;
  Model_Facebook data;

  String successMessage = '';
  bool _isSigningIn = false;
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  // Facebook Sign In & Sign Out methods

  String _message;
  var profileData;

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
                  child:
                  Form(
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
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Container(
                            child: Text('LOGIN',
                                style: CustomTextStyle.heading(
                                    size: 22,
                                    height: Constants.screenHeight,
                                    width: Constants.screenWidth)),
                          ),
                        ),
                        SizedBox(height: Constants.screenHeight / 30),
                        Text('Email/Username',
                            textAlign: TextAlign.left,
                            style: CustomTextStyle.mediumText(
                                fontcolor: ColorConstants.blackColor.withOpacity(0.8),
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
                        SizedBox(height: Constants.screenHeight / 40),
                        Text('Password',
                            textAlign: TextAlign.left,
                            style: CustomTextStyle.mediumText(
                                fontcolor: ColorConstants.blackColor.withOpacity(0.8),
                                size: 16,
                                height: Constants.screenHeight,
                                width: Constants.screenWidth)),
                        SizedBox(height: Constants.screenHeight / 120),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          obscureText: _isObscure ? false : true,
                          controller: passwordController,
                          onChanged: (value) {
                            debugPrint('Something changed in Title Text Field');
                          },
                          decoration: InputDecoration(
                            hintText: "Enter your Password",
                            border:
                            OutlineInputBorder(borderRadius: BorderRadius.zero),
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "*Password Required";
                            } else if (!Validation.validatePassword(value)) {
                              return "Enter Proper Password";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Constants.screenHeight / 120),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()),
                                    (Route<dynamic> route) => false);
                          },
                          child: Text('Forgot your Password ?',
                              textAlign: TextAlign.left,
                              style: CustomTextStyle.customText(
                                  size: 16,
                                  height: Constants.screenHeight,
                                  width: Constants.screenWidth)),
                        ),
                        SizedBox(height: Constants.screenHeight / 40),
                        centerButton(
                            Constants.screenHeight / 15,
                            Constants.screenWidth,
                            ColorConstants.primaryColor,
                            ColorConstants.whiteColor,
                            BoxDecoration(
                              color: ColorConstants.primaryColor,
                            ),
                            "LOGIN",
                            CustomTextStyle.buttonText(
                                size: 16,
                                height: Constants.screenHeight,
                                width: Constants.screenWidth),
                            logIn),
                        SizedBox(
                          height: 14,
                        ),
                        Center(
                          child: Container(
                            child: Text('OR LOGIN USING',
                                style: CustomTextStyle.normalText(
                                    size: 16,
                                    height: Constants.screenHeight,
                                    width: Constants.screenWidth)),
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: _facebookLoginFunc,
                              child: Container(
                                width: Constants.screenWidth / 7,
                                child: SvgPicture.asset('assets/images/facebook.svg'),
                              ),
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            InkWell(
                              onTap: () async {
                                signInWithGoogle().then((result) {
                                  print('Google sign in : ${result}');
                                  if (result != null) {
                                    print('Google sign in : ${result}');
                                    String socialName = name;
                                    String socialEmail = email;
                                    String socialID = googleId;
                                    String socialType = 'G';
                                    if (socialEmail == null || socialEmail == "") {
                                      signOutGoogle();
                                    } else {
                                      //Todo api calling of checksocial media
                                      print("success");
                                      checksocialMedialLogin(socialID, socialType);
                                      // _checkSocialRegistration(googleId, 0);
                                    }
                                  }
                                });

                                // User user =
                                //     await Authentication.signInWithGoogle(context: context);
                                // print(user.uid);
                              },
                              child: Container(
                                width: Constants.screenWidth / 7,
                                child: SvgPicture.asset('assets/images/google.svg'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        Center(
                          child: Container(
                            child: Text('DON’t HAVE ACCOUNT ?',
                                style: CustomTextStyle.normalText(
                                    size: 16,
                                    height: Constants.screenHeight,
                                    width: Constants.screenWidth)),
                          ),
                        ),
                        SizedBox(height: Constants.screenHeight / 40),
                        centerButton(
                            Constants.screenHeight / 15,
                            Constants.screenWidth,
                            Colors.white,
                            ColorConstants.primaryColor,
                            null,
                            "REGISTER NOW",
                            CustomTextStyle.buttonWithNoBorder(),
                            register),
                        SizedBox(
                          height: Constants.screenHeight / 40,
                        ),
                      ],
                    ),
                  )
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
        ),
      ),
    );
  }


  register() {
    FocusManager.instance.primaryFocus.unfocus();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => RegisterPage()),
        (Route<dynamic> route) => false);
  }

  logIn() async {
    FocusManager.instance.primaryFocus.unfocus();
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return null;
    }
    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    String deviceName = await Util.getDeviceInfo();
    List<String> deviceInfoList = await Util.getDeviceDetails();
    Map<String, dynamic> map = Map<String, dynamic>();
    map["device_name"] =
    deviceInfoList != null ? deviceInfoList[0] : deviceName;
    map["imei_number"] = deviceInfoList != null ? deviceInfoList[2] : "";
    map["device_type"] = Platform.isAndroid ? "A" : "I";

    _email = emailController.text.trim().toLowerCase();
    _password = passwordController.text;
    print("Email is $_email");
    print("Password is $_password");
    dynamic body = {
      "apiName": "user_login",
      "deviceToken": map["imei_number"].toString(),
      "deviceType": map["device_type"].toString(),
      "password": _password,
      "userName": _email,
    };

    bool internet =
    await Servicereq.connectivityFunction(
        context);

    setState(() {
      isLoading = false;
      snackbar("Login Successful");
    });
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MainScreenPage()),
                  (Route<dynamic> route) => false);

    //api calling
  //   if (internet) {
  //   dynamic mobileApi = await Servicereq()
  //       .fetchdata(url: 'api_mobile.php', body: body, context: context);
  //   print(mobileApi);
  //   String data;
  //
  //   if (mobileApi.statusCode == 200) {
  //     data = mobileApi.body;
  //     LoginModel logindata = LoginModel.fromJson(jsonDecode(mobileApi.body));
  //     print(logindata.success);
  //     setState(() {
  //       isLoading = true;
  //     });
  //
  //     if (logindata.success == true) {
  //
  //
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (context) => MainScreenPage()),
  //               (Route<dynamic> route) => false);
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       snackbar(logindata.message);
  //     }
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     print("StatusCode error");
  //   }
  // }else
  //   {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     snackbar(validationMsg.noInternet);
  //   }
  }

  _facebookLoginFunc() async {
    FocusManager.instance.primaryFocus.unfocus();
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        // ignore: unrelated_type_equality_checks
        final FacebookAccessToken accessToken = result.accessToken;
        final graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${result.accessToken.token}'));
        print(graphResponse.body);
        Map userMap = jsonDecode(graphResponse.body);
        var user = Model_Facebook.fromJson(userMap);
        data = user;
        String socialName = user.name;
        String socialEmail = user.email;
        String socialType = "F";
        String socialID = user.id;
        if (socialEmail == null || socialEmail == "") {
          facebookSignIn.logOut();
        } else {
          checksocialMedialLogin(socialID, socialType);
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Facebook login cancelled by user =>');
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        print('Facebook login error => ${result.errorMessage}');
        break;
    }
  }

  void _showMessage(String message) {
    setState(() {
      _isSigningIn = true;

      _message = message;
    });
  }

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

  checksocialMedialLogin(String socialid, String socialtype) async {
    var body = {
      "apiName": "check_social",
      "user_social_id": socialid,
      "user_social_type": socialtype
    };

    //api calling

    // var response = await Servicereq().fetchPostdata(
    //     method: 'get', url: 'api_mobile.php', body: body, context: context);

    // if (response.statusCode == 200) {
    //   dynamic data = jsonDecode(response.body);
    //   print("You have entered Valid API name");
    //
    //   if (data["register_process"]) {
    //     snackbar("Please compelete your profile");
    //     Navigator.of(context).pushAndRemoveUntil(
    //         MaterialPageRoute(
    //             builder: (context) => CompleteProfile(
    //                   socialId: socialid,
    //                   socialType: socialtype,
    //                 )),
    //         (Route<dynamic> route) => false);
    //   } else {
    //     Navigator.of(context).pushAndRemoveUntil(
    //         MaterialPageRoute(builder: (context) => MainScreenPage()),
    //         (Route<dynamic> route) => false);
    //   }
    // } else {
    //   String message = jsonDecode(response.body);
    //   snackbar("something went wrong");
    //   setState(() {});
    // }
  }
}
