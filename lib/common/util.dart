import 'dart:io';
import 'dart:math';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';

import 'DeviceId.dart';
import 'ImeiPlugin.dart';
import 'constants.dart';

class Util {
  
  static DateTime stringDatetoDateTime(String date,{DateFormat dateFormat}) 
  {    
        DateFormat df;
    if(dateFormat==null || dateFormat=="")
    {
      df=Constants.commondateFormate;
    }
    else
    {
      df=dateFormat;
    }

    DateTime parsedDate = df.parse(date);
    return parsedDate;   
  }

  static String dateTimeDatetoString(DateTime date,{DateFormat dateFormat}) 
  {    
    DateFormat df;
    if(dateFormat==null || dateFormat=="")
    {
      df=Constants.commondateFormate;
    }
    else
    {
      df=dateFormat;
    }

    String dateString = df.format(date);
    return dateString;   
  }

    static DateTime currentDate()
  {    
    return DateTime.now();   
  }


    static DateTime getBeforeDateTime({DateTime date,int days=0,int hours=0,int minutes=0,int seconds=0})
  {    
    if(date==null)
    {
      date=currentDate();
    }
    DateTime beforeDate=date.subtract(new Duration(days: days,hours: hours,minutes: minutes,seconds: seconds));
    return beforeDate;   
  }

   static DateTime getAfterDateTime({DateTime date,int days=0,int hours=0,int minutes=0,int seconds=0})
  {    
    if(date==null)
    {
      date=currentDate();
    }

    DateTime afterDate = date.add(new Duration(days: days,hours: hours,minutes: minutes,seconds: seconds));  
    return  afterDate;
  }


  static Future<String> getDeviceInfo() async {
    String _platformImei = "";
    String _deviceName = "";

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _deviceName = androidInfo.model;
      _platformImei = androidInfo.id;
      print('tag' + '---Running on androidInfo---${androidInfo.model}');
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      _deviceName = iosInfo.utsname.machine;
//      _deviceName = iosInfo.utsname.id;
      print('tag' + '---Running on iosInfo-----${iosInfo.utsname.machine}');
    }
    return _deviceName;
  }

  static Future<List<String>> getDeviceDetails() async {
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }

//if (!mounted) return;
    //print('Failed to get platform version',""deviceName);

    return [deviceName, deviceVersion, identifier];
  }

  static Future<String> initDeviceId() async {
    String deviceid;
    String imei;
    String meid;

//    deviceid = await DeviceId.getID;
    try {
      imei = await DeviceId.getIMEI;
      meid = await DeviceId.getMEID;
      print("---11111-----" +
          'Your deviceid: $deviceid\nYour IMEI: $imei\nYour MEID: $meid');
    } catch (e) {
      print("--------" + e.message);
    }
  }

  static Future<String> getIMEI() async {
    String platformImei;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformImei =
      await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
    } catch (error) {
      print('tag' + ".....error...." + error.toString());
      platformImei = 'Failed to get platform version.';
    }

    return platformImei;
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  static Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }

}
