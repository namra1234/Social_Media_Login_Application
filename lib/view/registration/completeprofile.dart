import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../common/buttonStyle.dart';
import '../../common/colorConstants.dart';
import '../../common/constants.dart';
import '../../common/textStyle.dart';
import '../../common/util.dart';
import '../../common/validation.dart';
import '../../network/service.dart';
import '../../view/bottomItem/mainscreen.dart';

class CompleteProfile extends StatefulWidget {
  String socialId;
  String socialType;

  CompleteProfile({Key key, this.socialId, this.socialType}) : super(key: key);

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  String _email;
  String _password;
  String _firstName;
  String _lastName;
  String data;
  final _formKey = GlobalKey<FormState>();

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
        body: Padding(
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
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Container(
                      child: Text('COMPLETE PROFILE',
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
                    controller: firstNameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      debugPrint('Something changed in Title Text Field');
                    },
                    decoration: InputDecoration(
                      hintText: "First Name",
                      border:
                          OutlineInputBorder(borderRadius: BorderRadius.zero),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    validator: (value) {
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
                      border:
                          OutlineInputBorder(borderRadius: BorderRadius.zero),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    validator: (value) {
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
                      border:
                          OutlineInputBorder(borderRadius: BorderRadius.zero),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "*Email Required";
                      } else if (!Validation.validateEmail(value)) {
                        return "*Enter Validate Email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Constants.screenHeight / 20),
                  centerButton(
                      Constants.screenHeight / 15,
                      Constants.screenWidth,
                      ColorConstants.primaryColor,
                      ColorConstants.whiteColor,
                      BoxDecoration(
                        color: ColorConstants.primaryColor,
                      ),
                      "DONE",
                      CustomTextStyle.buttonText(
                          size: 16,
                          height: Constants.screenHeight,
                          width: Constants.screenWidth),
                      save),
                  SizedBox(height: Constants.screenHeight / 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  save() async {
    FocusManager.instance.primaryFocus.unfocus();

    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return null;
    }
    _formKey.currentState.save();

    String deviceName = await Util.getDeviceInfo();
    List<String> deviceInfoList = await Util.getDeviceDetails();
    Map<String, dynamic> map = Map<String, dynamic>();
    map["device_name"] =
        deviceInfoList != null ? deviceInfoList[0] : deviceName;
    map["imei_number"] = deviceInfoList != null ? deviceInfoList[2] : "";
    map["device_type"] = Platform.isAndroid ? "A" : "I";

    _email = emailController.text.trim().toLowerCase();
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
      'user_social_id': widget.socialId,
      'user_social_type': widget.socialType,
      'last_name': _lastName,
      'meta_data[0][key]': 'deviceType',
      'meta_data[0][value]': map["device_type"].toString(),
      'meta_data[1][key]': 'deviceToken',
      'meta_data[1][value]': map["imei_number"].toString()
    };

    dynamic mobileApi = await Servicereq().fetchdatapostRegister(
      url: '',
      body: body,
    );
    print(mobileApi);
    if (mobileApi["status"] == "true") {
      snackbar("Data save Successfully");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainScreenPage()),
          (Route<dynamic> route) => false);
    } else {
      snackbar(mobileApi["message"]);
    }

    /* Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LogInPage()),
    );*/
  }
}
