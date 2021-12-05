import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import '../../common/bottomBar.dart';
import '../../common/buttonStyle.dart';
import '../../common/colorConstants.dart';
import '../../common/constants.dart';
import '../../common/textStyle.dart';
import '../../model/shop.dart';
import '../../network/service.dart';

class MainScreenPage extends StatefulWidget {
  static int page = 0;

  @override
  _MainScreenPageState createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  List<ShopModel> shopModelList = [];
  ShopModel shopModel;
    bool isVisible = false,totalcheck=false;
  bool isLoading = true, lazyloader = false;
  ScrollController _sc = new ScrollController();
  int total=0;

  @override
  void initState() {
    fetchAllData();
    super.initState();
    // _sc.addListener(() {
    //   if (_sc.position.pixels == _sc.position.maxScrollExtent) {
    //
    //
    //     if(totalcheck)
    //     if(shopModelList?.length!=total) {
    //       setState(() {
    //         lazyloader = true;
    //         isLoading = true;
    //       });
    //       fetchAllData();
    //
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  fetchAllData() async {
    setState(() {
      isLoading=true;
    });
    dynamic products = await Servicereq().fetchdataget(
        url: "wp-json/wc/v3/products?consumer_key=" +
            reqserver.consumerKey +
            "&consumer_secret=" +
            reqserver.consumerSecret);
    totalcheck=true;
    total=int.parse(products.headers['x-wp-total']);
    List<dynamic> res = json.decode(products.body);
    List<ShopModel> tList=[];

    if (products.statusCode == 200) {
      List<dynamic> data = json.decode(products.body);

      int i=0;
      res.forEach((element) {

        if(i==4)
          return;


        shopModel = ShopModel.fromJson(element);
        tList.add(shopModel);
        i++;
      });

    }

    setState(() {
      lazyloader = false;
      isLoading = false;
      shopModelList.addAll(tList);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      bottomNavigationBar: Container(child: BottomBar()),
      body: SingleChildScrollView(
        controller: _sc,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: Constants.screenWidth,
                  height: Constants.screenHeight / 2.5,
                  child: Image.asset('assets/images/treeback.png',
                      fit: BoxFit.cover),
                ),
                Positioned(
                  top: Constants.screenHeight / 10,
                  left: Constants.screenWidth / 8,
                  right: Constants.screenWidth / 8,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/treeIcon.svg',
                        width: 60,
                      ),
                      SizedBox(width: Constants.screenWidth / 25),
                      Text('OneTreeWorld',
                          style: CustomTextStyle.sourceSansHeadingText(
                              size: 30,
                              height: Constants.screenHeight,
                              width: Constants.screenWidth,
                              fontColor: ColorConstants.whiteColor))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Constants.screenWidth / 14,
                    right: Constants.screenWidth / 14,
                    top: Constants.screenHeight / 4.5,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.customContainerColor,
                    ),
                    height: Constants.screenHeight / 2,
                    width: Constants.screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: Constants.screenHeight / 30,
                        ),
                        Text('FIGHTING CLIMATE CHANGE IN THE UK',
                            textScaleFactor: 0.9,
                            style: CustomTextStyle.mainScreenText(
                                textColor: ColorConstants.primaryColor,
                                size: 12,
                                height: Constants.screenHeight,
                                width: Constants.screenWidth)),
                        SizedBox(
                          height: Constants.screenHeight / 42,
                        ),
                        Text('OneTreeWorld',
                            style: CustomTextStyle.splashWelcome(
                                size: 30,
                                height: Constants.screenHeight,
                                width: Constants.screenWidth)),
                        SizedBox(
                          height: Constants.screenHeight / 200,
                        ),
                        Text('Carbon Neutral Delivery',
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              color: ColorConstants.blackColor.withOpacity(0.5),
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              // lineHeight: 47px,
                              letterSpacing: -0.01,
                            )),
                        SizedBox(
                          height: Constants.screenHeight / 40,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 18, right: 18),
                          child: RichText(
                            textAlign: TextAlign.center,
                            textScaleFactor: 0.90,
                            maxLines: 4,
                            text: TextSpan(
                              text:
                                  'We plant in our home country – the United Kingdom  ',
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                color:
                                    ColorConstants.blackColor.withOpacity(0.7),
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                // lineHeight: 47px,
                                letterSpacing: -0.01,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      '‘Offset your deliveries carbon emissions by planting a tree in the UK for 99p’',
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    // lineHeight: 47px,
                                    letterSpacing: -0.01,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Constants.screenHeight / 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: Constants.screenWidth / 5.5,
                              right: Constants.screenWidth / 5.5),
                          child: centerButton(
                              Constants.screenHeight / 15,
                              Constants.screenWidth,
                              ColorConstants.primaryColor,
                              ColorConstants.whiteColor,
                              BoxDecoration(
                                color: ColorConstants.primaryColor,
                              ),
                              "PLANT NOW",
                              CustomTextStyle.buttonText(
                                  size: 16,
                                  height: Constants.screenHeight,
                                  width: Constants.screenWidth),
                              plantNow),
                        ),
                        SizedBox(
                          height: Constants.screenHeight / 40,
                        ),
                        Text('Learn More',
                            style: TextStyle(
                              fontFamily: 'SansSourceSansPro',
                              fontSize: 14,
                              color: ColorConstants.primaryColor,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              // lineHeight: 47px,
                              letterSpacing: -0.01,
                            )),
                      ],
                    ),
                  ),
                ),
                /*       Positioned(
                  right: 1,
                  bottom: 2,
                  child: Container(
                    height: Constants.screenHeight / 10,
                    width: Constants.screenWidth / 3,
                    child: Image.asset('assets/images/leave.png'),
                  ),
                ),*/
                Padding(
                  padding: EdgeInsets.only(
                      left: Constants.screenWidth / 1.45,
                      top: Constants.screenHeight / 1.55),
                  child: Container(
                    height: Constants.screenHeight / 10,
                    width: Constants.screenWidth / 3,
                    child: Image.asset('assets/images/leave.png'),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: Constants.screenWidth / 14,
                right: Constants.screenWidth / 14,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Constants.screenHeight / 40,
                  ),
                  Text('PLANT A TREE - FIGHT CLIMATE CHANGE',
                      style: CustomTextStyle.mainScreenText(
                          textColor: ColorConstants.primaryColor,
                          size: 12,
                          height: Constants.screenHeight,
                          width: Constants.screenWidth)),
                  SizedBox(
                    height: Constants.screenHeight / 180,
                  ),
                  Text('How it works',
                      style: CustomTextStyle.sourceSansHeadingText(
                          size: 24,
                          height: Constants.screenHeight,
                          width: Constants.screenWidth,
                          fontColor: ColorConstants.blackColor)),
                  SizedBox(
                    height: Constants.screenHeight / 25,
                  ),
                  generatePurchaseFlow("assets/images/purchase.svg", "Purchase",
                      "At online retailer’s checkout you have the option to offset your carbon for 99p - this is used to plant a tree in the UK."),
                  generatePurchaseFlow("assets/images/delivery.svg", "Delivery",
                      "At online retailer’s checkout you have the option to offset your carbon for 99p - this is used to plant a tree in the UK."),
                  generatePurchaseFlow("assets/images/evidence.svg", "Evidence",
                      "At online retailer’s checkout you have the option to offset your carbon for 99p - this is used to plant a tree in the UK."),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset(
                            "assets/images/community.svg",
                            width: Constants.screenWidth / 7,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: Constants.screenWidth / 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Community",
                                style: CustomTextStyle.sourceSansHeadingText(
                                    size: 18,
                                    height: Constants.screenHeight,
                                    width: Constants.screenWidth,
                                    fontColor: ColorConstants.blackColor)),
                            SizedBox(
                              height: Constants.screenHeight / 120,
                            ),
                            Text(
                                "We arrange delivery to Farmers and the Woodland Trust. They plant the trees in the correct way.",
                                textAlign: TextAlign.left,
                                style: CustomTextStyle.mainScreenText(
                                    textColor: ColorConstants.blackColor
                                        .withOpacity(0.5),
                                    size: 14,
                                    height: Constants.screenHeight,
                                    width: Constants.screenWidth)),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                          top: Constants.screenHeight / 40,
                          left: Constants.screenWidth / 12,
                          right: Constants.screenWidth / 12,
                        ),
                        child: Image.asset('assets/images/uprtrees.png',
                            fit: BoxFit.cover)),
                    Image.asset('assets/images/lowertress.png',
                        fit: BoxFit.cover)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Constants.screenWidth / 14,
                    right: Constants.screenWidth / 14,
                    top: Constants.screenHeight / 4.5,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.primaryColor.withOpacity(0.9),
                    ),
                    height: Constants.screenHeight / 1.65,
                    width: Constants.screenWidth,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: Constants.screenWidth / 16,
                        right: Constants.screenWidth / 16,
                        top: Constants.screenHeight / 40,
                      ),
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Our Corporate Goal',
                                style: CustomTextStyle.sourceSansHeadingText(
                                    size: 24,
                                    height: Constants.screenHeight,
                                    width: Constants.screenWidth,
                                    fontColor: ColorConstants.whiteColor)),
                            SizedBox(
                              height: Constants.screenHeight / 100,
                            ),
                            Text(
                                'We aspire to be the most ethical business on the planet.',
                                style: CustomTextStyle.mainScreenText(
                                    textColor: ColorConstants.whiteColor,
                                    size: 14,
                                    height: Constants.screenHeight,
                                    width: Constants.screenWidth)),
                            SizedBox(
                              height: Constants.screenHeight / 30,
                            ),
                            Text("We aim to achieve this by:",
                                style: CustomTextStyle.sourceSansHeadingText(
                                    size: 14,
                                    height: Constants.screenHeight,
                                    width: Constants.screenWidth,
                                    fontColor: ColorConstants.whiteColor)),
                            SizedBox(
                              height: Constants.screenHeight / 48,
                            ),
                            for (int i = 0; i < 4; i++)
                              generateTextSpan("assets/images/arrow.svg",
                                  "footprint  plant trees and reduce their carbon footprin  plant trees and reduce their carbon footprin"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: Constants.screenHeight / 20,
                left: Constants.screenWidth / 12,
                right: Constants.screenWidth / 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Products",
                      textAlign: TextAlign.left,
                      style: CustomTextStyle.mainScreenText(
                          textColor: ColorConstants.primaryColor,
                          size: 12,
                          height: Constants.screenHeight,
                          width: Constants.screenWidth)),
                  SizedBox(
                    height: Constants.screenHeight / 80,
                  ),
                  Text('Shop',
                      style: CustomTextStyle.splashWelcome(
                          size: 24,
                          height: Constants.screenHeight,
                          width: Constants.screenWidth)),

                  SizedBox(
                    height: Constants.screenHeight / 20,
                  ),
                  // lazyloader ? _buildProgressIndicator() : Container(),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget generatePurchaseFlow(String img, String txtHeading, String detail) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SvgPicture.asset(
              img,
              width: Constants.screenWidth / 7,
            ),
            Dash(
                direction: Axis.vertical,
                length: 80,
                dashLength: 3,
                dashColor: ColorConstants.dashLineColor),
          ],
        ),
        SizedBox(
          width: Constants.screenWidth / 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(txtHeading,
                  style: CustomTextStyle.sourceSansHeadingText(
                      size: 18,
                      height: Constants.screenHeight,
                      width: Constants.screenWidth,
                      fontColor: ColorConstants.blackColor)),
              SizedBox(
                height: Constants.screenHeight / 120,
              ),
              Text(detail,
                  textAlign: TextAlign.left,
                  style: CustomTextStyle.mainScreenText(
                      textColor: ColorConstants.blackColor.withOpacity(0.5),
                      size: 14,
                      height: Constants.screenHeight,
                      width: Constants.screenWidth)),
            ],
          ),
        )
      ],
    );
  }

  Widget generateTextSpan(String img, String txt) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Constants.screenHeight / 48,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2),
            child: SvgPicture.asset(
              img,
              width: Constants.screenWidth / 30,
            ),
          ),
          SizedBox(
            width: Constants.screenWidth / 50,
          ),
          Expanded(
            child: Text(txt,
                textAlign: TextAlign.left,
                style: CustomTextStyle.mainScreenText(
                    textColor: ColorConstants.whiteColor,
                    size: 14,
                    height: Constants.screenHeight,
                    width: Constants.screenWidth)),
          ),
        ],
      ),
    );
  }

  plantNow() {}
}
