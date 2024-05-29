//  Using controller without a Model Class
// ........................................ //
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../utilities/api_endpoints.dart';
import 'logoutController.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();  //creating the instance (_prefs) of sharedPreferences

fetchMockMcqs() async {

  final SharedPreferences prefs = await _prefs;

  Map<String, String> headers = {'Authorization': 'Bearer ${prefs.get('token')}'};

  Uri url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.mockQuestion);

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body.toString());

    print("data is loaded for mock mcqs: $data");

    //return data;
    return data;

  }  else if (response.statusCode ==  400 ) {    // this condition works when token is Expired so we need to remove it from local storage

    LogoutController logoutController = Get.put(LogoutController());

    var errrorMessage = "Token expired. Please log in again";

    logoutController.handleLogout();

    throw Exception(errrorMessage);

  }
}



/// .......................... SnackBar code ...........................//

// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Container(
// decoration: BoxDecoration(
// gradient: LinearGradient(
// colors: [Colors.red, Colors.orange],
// begin: Alignment.topLeft,
// end: Alignment.bottomRight,
// ),
// borderRadius: BorderRadius.circular(8.0),
// ),
// child: Padding(
// padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
// child: Text(
// 'Failed to fetch MCQs: $e',
// style: TextStyle(
// color: Colors.white,
// fontSize: 16.0,
// ),
// ),
// ),
// ),
// duration: Duration(seconds: 7),
// behavior: SnackBarBehavior.floating,
// action: SnackBarAction(
// label: 'Dismiss',
// textColor: Colors.white,
// onPressed: () {},
// ),
// ),
// );