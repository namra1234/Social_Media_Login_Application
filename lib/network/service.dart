import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../common/constants.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

import '../common/AlertView.dart';

class Servicereq {
  connectivityFunc(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print('mobile');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print('wifi');
    } else if (connectivityResult == ConnectivityResult.none) {
      print('no connect');
      snackbar(validationMsg.noInternet,context);
    }
  }



    static Future<bool> connectivityFunction(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print('mobile');
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print('wifi');
      return true;
    } else if (connectivityResult == ConnectivityResult.none) {

      return false;
    }
  }

  void snackbar(String msg,BuildContext context) {
    var snackBar = SnackBar(
      content: Text(msg),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  Future<http.Response> fetchdata(
      {String method,
      String url,
      Map<String, String> body,
      BuildContext context}) async {
    connectivityFunc(context);

    String mainurl = reqserver.baseurl + url;
    var response = await http.post(Uri.parse(mainurl), body: jsonEncode(body));

    return response;
  }

  Future<http.Response> fetchdataget(
      {String method, String url, BuildContext context}) async {
    connectivityFunc(context);

    String mainurl = reqserver.baseurl + url;
    var response = await http.get(Uri.parse(mainurl));

    return response;
  }

  Future<Map> fetchdatapostRegister(
      {String method,
      String url,
      BuildContext context,
      Map<String, String> body}) async {
    connectivityFunc(context);
    var response;

    String mainurl = "https://team3.devhostserver.com/onetreeworld/" + url;

    // Initialize the API
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: mainurl,
        consumerKey: reqserver.consumerKey,
        consumerSecret: reqserver.consumerSecret);
    try {
      response = await wooCommerceAPI.postAsync(
        "customers",
        body,
      );
      Map<String, dynamic> res = response;

      if (res["message"] == null) {
        return {'status': 'true', 'message': ''};
      } else {
        return {'status': 'false', 'message': res["message"]};
      }
      // JSON Object with response
    } catch (e) {
      return {'status': 'false', 'message': e};
    }
  }

  Future<http.Response> fetchdatawithHeader(
      {String method,
      String url,
      Map<String, String> body,
      Map<String, String> header,
      BuildContext context}) async {
    connectivityFunc(context);
    String mainurl = reqserver.baseurl + url;
    print('main url${mainurl}');

    var response;
    if (body == null) {
      response = await http.post(Uri.parse(mainurl), headers: header);
    } else {
      response =
          await http.post(Uri.parse(mainurl), body: body, headers: header);
    }

    print('response${response.body}');
    print('status code${response.statusCode}');
    return response;
  }

  Future<http.Response> fetchPostdata(
      {String method,
      String url,
      Map<String, String> body,
      BuildContext context,
      Map<String, String> header}) async {
    connectivityFunc(context);
    String mainurl = reqserver.baseurl + url;
    print('get data');

    var res = await http.post(Uri.parse(mainurl), body: jsonEncode(body));

    return res;
  }
}
