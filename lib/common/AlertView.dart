
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
class alertOpen{
 static showAlertOnebtn({BuildContext context,String title,String message,String btnTitle}) {
  
  clickbtn()
  {
    Navigator.pop(context);
    if(message=='Password changed successfully') {
      Navigator.pop(context);
    }
    else if(message=='User profile updated successfully'){
      Navigator.pop(context);
    }



  }

   if (Platform.isAndroid) {

   Widget okButton = FlatButton(
     child: Text(btnTitle),
     onPressed: () {
       clickbtn();
       },
   );

   // set up the AlertDialog
   AlertDialog alert = AlertDialog(
     title: Text(title),
     content: Text(message),
     actions: [
       okButton,
     ],
   );

   // show the dialog

   showDialog(
     context: context,
     builder: (BuildContext context) {
       return alert;
     },
   );
   } else if (Platform.isIOS) {
     // iOS-specific code

     CupertinoAlertDialog alert =  CupertinoAlertDialog(
     title: Container(
         height: 30,
         child: new Text(title)),
     content: new Text(message),
     actions: <Widget>[
       CupertinoDialogAction(
         isDefaultAction: true,
         child: Text(btnTitle),
         onPressed: (){
          clickbtn();
           },
       )
]
   );

     showDialog(
       context: context,
       builder: (BuildContext context) {
         return alert;
       },
     );
   }



/*

   Widget okButton = FlatButton(
      child: Text(btnTitle),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
*/
  }
}