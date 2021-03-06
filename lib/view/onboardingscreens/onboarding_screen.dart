import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/colorConstants.dart';
import '../../common/constants.dart';
import '../../common/textStyle.dart';
import '../../view/registration/login.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _builPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.7, 0.9],
            colors: [
              Color(0xFF3594DD),
              Color(0xFF4563DB),
              Color(0xFF5036D5),
              Color(0xFF5B16D0),
            ],
          )),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => print('Skip'),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 15.0
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 600.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image:
                                AssetImage('assets/images/splashLogo.png'),
                                height: 250.0,
                                width: 250.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text("Tree",
                                style: CustomTextStyle.sourceSansHeadingText(
                                    size: 18,
                                    height: Constants.screenHeight,
                                    width: Constants.screenWidth,
                                    fontColor: ColorConstants.blackColor)),
                            SizedBox(height: 15.0),
                            Text("The numbers of trees an individual has planted is recorded in their account and digital badges are unlocked at different volume breaks. They have the ability to share this on social media to spread the message.",
                                textAlign: TextAlign.center,
                                style: CustomTextStyle.mainScreenText(
                                    textColor: ColorConstants.blackColor.withOpacity(0.5),
                                    size: 14,
                                    height: Constants.screenHeight,
                                    width: Constants.screenWidth)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image:
                                AssetImage('assets/images/splashLogo.png'),
                                height: 250.0,
                                width: 250.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text("Tree",
                                style: CustomTextStyle.sourceSansHeadingText(
                                    size: 18,
                                    height: Constants.screenHeight,
                                    width: Constants.screenWidth,
                                    fontColor: ColorConstants.blackColor)),
                            SizedBox(height: 15.0),
                            Text("detail",
                                textAlign: TextAlign.center,
                                style: CustomTextStyle.mainScreenText(
                                    textColor: ColorConstants.blackColor.withOpacity(0.5),
                                    size: 14,
                                    height: Constants.screenHeight,
                                    width: Constants.screenWidth)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image:
                                AssetImage('assets/images/splashLogo.png'),
                                height: 250.0,
                                width: 250.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text("Tree",
                                style: CustomTextStyle.sourceSansHeadingText(
                                    size: 18,
                                    height: Constants.screenHeight,
                                    width: Constants.screenWidth,
                                    fontColor: ColorConstants.blackColor)),
                            SizedBox(height: 15.0),
                            Text("detail",
                                textAlign: TextAlign.center,
                                style: CustomTextStyle.mainScreenText(
                                    textColor: ColorConstants.blackColor.withOpacity(0.5),
                                    size: 14,
                                    height: Constants.screenHeight,
                                    width: Constants.screenWidth)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _builPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text('')
              ],
            ),
          ),
        ),
      ),
     // bottomSheet: _currentPage == _numPages - 1
          // ? Container(
          //     height: 100.0,
          //     width: double.infinity,
          //     color: Colors.white,
          //     child: GestureDetector(
          //       onTap: () {
          //         Navigator.of(context)
          //             .push(MaterialPageRoute(builder: (context) => LogInPage()));
          //       },
          //       child: Center(
          //         child: Padding(
          //           padding: EdgeInsets.only(bottom: 30.0),
          //           child: Text(
          //             'Get started',
          //             style: TextStyle(
          //               color: ColorConstants.primaryColor,
          //               fontSize: 20.0,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   )
          // : Text(''),
    );
  }
}
