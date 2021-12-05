import 'package:all_projects/view/bottomItem/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'constants.dart';
import 'colorConstants.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          child: Column(
            children: [
              Constants.isVisible
                  ? Container(
                      height: Constants.screenHeight / 10,
                      // width: 150,
                      //color: Colors.green,
                      child: Column(
                        children: [
                          Container(
                            height: 3,
                            decoration: BoxDecoration(
                              //color: Color(0xFFF6F7FB),
                              color: Colors.grey.withOpacity(0.2),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Color(0xFFF6F7FB),

                                    //color: Colors.grey[350],
                                    blurRadius: 7.0,
                                    offset: Offset(0.0, 0.75))
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {

                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Constants.screenHeight / 130,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: Constants.screenWidth / 20,
                                        height: Constants.screenHeight / 20,
                                        child: SvgPicture.asset(
                                            'assets/images/goal@2x.svg'),
                                      ),
                                      Container(
                                        child: Text(
                                          'OUR GOAL',
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {

                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Constants.screenHeight / 130,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: Constants.screenWidth / 20,
                                        height: Constants.screenHeight / 20,
                                        child: SvgPicture.asset(
                                            'assets/images/pledge@2x.svg'),
                                      ),
                                      Container(
                                        child: Text(
                                          'OUR PLEDGE',
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {

                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Constants.screenHeight / 130,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: Constants.screenWidth / 20,
                                        height: Constants.screenHeight / 20,
                                        child: SvgPicture.asset(
                                            'assets/images/accreditation@2x.svg'),
                                      ),
                                      Container(
                                        child: Text(
                                          'ACCREDITATION',
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {

                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Constants.screenHeight / 130,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: Constants.screenWidth / 20,
                                        height: Constants.screenHeight / 20,
                                        child: SvgPicture.asset(
                                            'assets/images/parteners@2x.svg'),
                                      ),
                                      Container(
                                        child: Text(
                                          'PARTENERS',
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(),
              Container(
                height: 3,
                decoration: BoxDecoration(
                  //color: Color(0xFFF6F7FB),
                  color: Colors.grey.withOpacity(0.2),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Color(0xFFF6F7FB),

                        //color: Colors.grey[350],
                        blurRadius: 7.0,
                        offset: Offset(0.0, 0.75))
                  ],
                ),
              ),
              // Divider(
              //
              //   height: 1,
              //   thickness: 2,
              //   color: Colors.grey.withOpacity(0.4),
              // ),
              Container(
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   boxShadow: <BoxShadow>[
                //     BoxShadow(
                //         color: Colors.black54,
                //         blurRadius: 5.0,
                //         offset: Offset(0.0, 0.75)
                //     )
                //   ],
                // ),

                height: Constants.screenHeight / 9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: Constants.screenWidth / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              if (Constants.currentPage != "HOME") {
                                Constants.currentPage = "HOME";
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => MainScreenPage()),
                                    (Route<dynamic> route) => false);
                                setState(() {
                                  Constants.isVisible = false;
                                });
                              }
                            },
                            child: Container(
                              //  width: Constants.screenWidth / 6,
                              // height: Constants.screenWidth / 6,

                              padding: EdgeInsets.symmetric(
                                vertical: Constants.screenHeight / 130,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: Constants.screenWidth / 20,
                                    height: Constants.screenHeight / 20,
                                    child: SvgPicture.asset(
                                        'assets/images/Home@2x.svg'),
                                  ),
                                  Container(
                                    child: Text(
                                      'HOME',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Constants.screenWidth / 36,
                          ),
                          InkWell(
                            onTap: () {

                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Constants.screenHeight / 130,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: Constants.screenWidth / 20,
                                    height: Constants.screenHeight / 20,
                                    child: SvgPicture.asset(
                                        'assets/images/Shop@2x.svg'),
                                  ),
                                  Container(
                                    child: Text(
                                      'SHOP',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        openContainer();
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: Constants.screenWidth / 7,
                          height: Constants.screenWidth / 7,
                          decoration: BoxDecoration(
                              color: ColorConstants.primaryColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Constants.isVisible
                              ? Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ),
                    Container(
                      width: Constants.screenWidth / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {

                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Constants.screenHeight / 130,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: Constants.screenWidth / 20,
                                    height: Constants.screenHeight / 20,
                                    child: SvgPicture.asset(
                                        'assets/images/About_us@2x.svg'),
                                  ),
                                  Container(
                                    child: Text(
                                      'ABOUT US',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Constants.screenWidth / 24,
                          ),
                          InkWell(
                            onTap: () {

                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Constants.screenHeight / 130,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: Constants.screenWidth / 20,
                                    height: Constants.screenHeight / 20,
                                    child: SvgPicture.asset(
                                        'assets/images/Profile@2x.svg'),
                                  ),
                                  Container(
                                    child: Text(
                                      'PROFILE',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    // Container(
                    //   padding: EdgeInsets.symmetric(
                    //     vertical: Constants.screenHeight / 130,
                    //   ),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Container(
                    //         width: Constants.screenWidth / 20,
                    //         height: Constants.screenHeight / 20,
                    //         child:
                    //         SvgPicture.asset('assets/images/Home@2x.svg'),
                    //       ),
                    //       Container(
                    //         child: Text(
                    //           'HOME',
                    //           style: TextStyle(
                    //             fontSize: Constants.screenHeight / 55,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void openContainer() {
    if (Constants.isVisible) {
      setState(() {
        Constants.isVisible = false;
      });
    } else {
      setState(() {
        Constants.isVisible = true;
      });
    }
  }
}
