import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'textStyle.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colorConstants.dart';

Widget centerButton(double height,double width,Color buttonColor,Color textColor,Decoration decoration, String buttonText,TextStyle customtextstyle,VoidCallback pressEvent)
{
  return Container(
    decoration:decoration==null? BoxDecoration(
        border: Border.all(color: ColorConstants.blackColor.withOpacity(0.2))): BoxDecoration(color: buttonColor),
    width: width,
    height: height,
    child: RaisedButton(
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      onPressed: pressEvent,
      color: buttonColor,
      textColor: textColor,
      child: Text(buttonText,
        style: customtextstyle,
      ),
    ),
  );
}
