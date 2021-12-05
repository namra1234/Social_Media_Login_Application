import 'dart:convert';
import 'dart:io';
import 'package:http/src/response.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../common/buttonStyle.dart';
import '../../common/colorConstants.dart';
import '../../common/constants.dart';
import '../../common/textStyle.dart';
import '../../common/util.dart';
import '../../network/service.dart';
import '../../common/validation.dart';
import '../../view/registration/login.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  String _email;
  String _password;
  String _firstName;
  String _lastName;
  String data;
  bool _isObscure = false;
  bool _isObscureRepeat = false;
  final _formKey = GlobalKey<FormState>();
  bool isLoading=false;


  void snackbar(String msg) {
    var snackBar = SnackBar(
      content: Text(msg),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
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
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Constants.screenHeight / 11,
                      ),
                      Center(
                        child: Container(
                          height: Constants.screenHeight / 6,
                          child:SvgPicture.asset('assets/images/splashLogo.svg'),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Container(
                          child: Text('REGISTER',
                              style: CustomTextStyle.heading(
                                  size: 22,
                                  height: Constants.screenHeight,
                                  width: Constants.screenWidth)),
                        ),
                      ),
                      SizedBox(height: Constants.screenHeight / 30),
                      Text('First Name',
                          textAlign: TextAlign.left,
                          style: CustomTextStyle.mediumText(
                              fontcolor: ColorConstants.blackColor.withOpacity(0.8),
                              size: 16,
                              height: Constants.screenHeight,
                              width: Constants.screenWidth)),
                      SizedBox(height: Constants.screenHeight / 120),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: firstNameController,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          debugPrint('Something changed in Title Text Field');
                        },
                        decoration: InputDecoration(
                          hintText: "First Name",
                          border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                        ),
                        validator:(value) {
                          if (value.isEmpty) {
                            return "*First Name Required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: Constants.screenHeight / 40),
                      Text('Last Name',
                          textAlign: TextAlign.left,
                          style: CustomTextStyle.mediumText(
                              fontcolor: ColorConstants.blackColor.withOpacity(0.8),
                              size: 16,
                              height: Constants.screenHeight,
                              width: Constants.screenWidth)),
                      SizedBox(height: Constants.screenHeight / 120),
                      TextFormField(
                        controller: lastNameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          debugPrint('Something changed in Title Text Field');
                        },
                        decoration: InputDecoration(
                          hintText: "Last Name",
                          border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                        ),
                        validator:(value) {
                          if (value.isEmpty) {
                            return "*Last Name Required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: Constants.screenHeight / 40),
                      Text('Email Address',
                          textAlign: TextAlign.left,
                          style: CustomTextStyle.mediumText(
                              fontcolor: ColorConstants.blackColor.withOpacity(0.8),
                              size: 16,
                              height: Constants.screenHeight,
                              width: Constants.screenWidth)),
                      SizedBox(height: Constants.screenHeight / 120),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          debugPrint('Something changed in Title Text Field');
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your email",
                          border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                        ),
                        validator:(value) {
                          if (value.isEmpty) {
                            return "*Email Required";
                          } else if (!Validation.validateEmail(
                              value)) {
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
                        textInputAction: TextInputAction.next,
                        controller: passwordController,
                        obscureText: _isObscure ? false
                            : true,
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
                        validator: (value){
                          if (value.isEmpty) {
                            return "*Password Required";
                          } else if (!Validation.validatePassword(
                              value)) {
                            return "Enter Proper Password";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: Constants.screenHeight / 40),
                      Text('Repeat Password',
                          textAlign: TextAlign.left,
                          style: CustomTextStyle.mediumText(
                              fontcolor: ColorConstants.blackColor.withOpacity(0.8),
                              size: 16,
                              height: Constants.screenHeight,
                              width: Constants.screenWidth)),
                      SizedBox(height: Constants.screenHeight / 120),
                      TextFormField(
                        controller: repeatPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        obscureText: _isObscureRepeat ? false
                            : true,
                        onChanged: (value) {
                          debugPrint('Something changed in Title Text Field');
                        },
                        decoration: InputDecoration(
                          hintText: "Repeat your Password",
                          border:
                          OutlineInputBorder(borderRadius: BorderRadius.zero),
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          suffixIcon: IconButton(
                            icon: Icon(_isObscureRepeat
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscureRepeat = !_isObscureRepeat;
                              });
                            },
                          ),
                        ),
                        validator:(value) {
                          if (value.isEmpty) {
                            return "*Re-enter Password";
                          } else if (passwordController.text !=repeatPasswordController.text) {
                            return "*Password not matched";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: Constants.screenHeight / 40),
                      centerButton(Constants.screenHeight/15,Constants.screenWidth, ColorConstants.primaryColor,ColorConstants.whiteColor,BoxDecoration(
                        color: ColorConstants.primaryColor,
                      ),"REGISTER",CustomTextStyle.buttonText(size: 16,
                          height: Constants.screenHeight,
                          width: Constants.screenWidth),register),

                      SizedBox(height: Constants.screenHeight / 20),
                      Center(
                        child: Container(
                          child: Text('ALREADY HAVE ACCOUNT ?',
                              style: CustomTextStyle.normalText(
                                  size: 16,
                                  height: Constants.screenHeight,
                                  width: Constants.screenWidth)),
                        ),
                      ),
                      SizedBox(height: Constants.screenHeight / 70),
                      centerButton(Constants.screenHeight/15,Constants.screenWidth, Colors.white,ColorConstants.primaryColor,null,"LOGIN",CustomTextStyle.buttonWithNoBorder(),logIn),

                      SizedBox(height: Constants.screenHeight / 40),
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

   logIn() {
     FocusManager.instance.primaryFocus.unfocus();
     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
         LogInPage()), (Route<dynamic> route) => false);
  }

  // register_oauth () {
  //   final oauth1.Platform platform = oauth1.Platform(
  //
  //     // define client credentials (consumer keys)
  //       const String apiKey = 'LLDeVY0ySvjoOVmJ2XgBItvTV';
  //   const String apiSecret = 'JmEpkWXXmY7BYoQor5AyR84BD2BiN47GIBUPXn3bopZqodJ0MV';
  //   final oauth1.ClientCredentials clientCredentials =
  //   oauth1.ClientCredentials(apiKey, apiSecret);
  //
  //   )
  // }

  register() async {

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
    _firstName = firstNameController.text;
    _lastName = lastNameController.text;
    print("Email is $_email");
    print("Password is $_password");
    print("First name is $_firstName");
    print("Last name is $_lastName");
    dynamic body = {
      'first_name': _firstName,
      'user_name': _email,
      'email': _email,
      'password': _password,
      'last_name': _lastName,
      'meta_data[0][key]': 'deviceType',
      'meta_data[0][value]': map["device_type"].toString(),
      'meta_data[1][key]': 'deviceToken',
      'meta_data[1][value]': map["imei_number"].toString()
    };

    bool internet =
    await Servicereq.connectivityFunction(
        context);

    //api calling

    // if (internet) {
    //   Map<dynamic, dynamic> mobileApi = await Servicereq()
    //       .fetchdatapostRegister(
    //     url: ''
    //     , body: body,
    //   );
    //   print(mobileApi);
    //
    //
    //   if (mobileApi["status"] == "true") {
    //
        snackbar("Registration Successfully Comepleted");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) =>
                LogInPage()), (Route<dynamic> route) => false);
    //   } else {
    //     snackbar(mobileApi["message"]);
    //     print(
    //         "This username is already registered, please choose another one.");
    //   }
    // }

  // else
  // {
  // setState(() {
  // isLoading = false;
  // });
  // snackbar(validationMsg.noInternet);
}}
    /* Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LogInPage()),
    );*/


