import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/pdfModel.dart';
import '../utilities/api_endpoints.dart';
import '../utilities/internet_check.dart';
import 'logoutController.dart';

final Future<SharedPreferences> _prefs = SharedPreferences
    .getInstance(); //creating the instance (_prefs) of sharedPreferences

class PdfController extends GetxController {
  final pdfModelObj = Rx<PdfModel?>(
      null); // Creating an observable object of Model class to store all data of Model class on it. The initial value of the object is set to null to avoid garbage value.
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();

    fetchPdfFunc();
  }

  void fetchPdfFunc() async {
    try {
      isLoading(true);

      // checking if the internet is available or not to show a message "import 'package:preparely_app_project/utilities/internet_check.dart';"
      bool isInternetAvailable =
          await checkInternetAvailability(); // Check internet connectivity

      if (!isInternetAvailable) {
        Fluttertoast.showToast(
          msg: "No internet connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color(0xFFFFEB3B),
          textColor: Colors.black,
        );
        return;
      }

      final SharedPreferences prefs = await _prefs;

      Map<String, String> headers = {
        'Authorization': 'Bearer ${prefs.get('token')}'
      };

      Uri url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.pdf);

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        print("printing pdf response.body: ${response.body}");

        var jsonResponse = response.body;

        pdfModelObj.value = pdfModelFromJson(jsonResponse);

        print("this data is coming from controller: ");
        for (var pdfItem in pdfModelObj.value!.pdfList!) {
          print(
              "PDF ID: ${pdfItem.id}, Title: ${pdfItem.name}, chapterID: ${pdfItem.chapterid!.name}, Url: ${pdfItem.myFile.toString()}");
        }
      } else if (response.statusCode == 400) {
        // this condition works when token is Expired so we need to remove it from local storage

        LogoutController logoutController = Get.put(LogoutController());

        var errrorMessage = "Token expired. Please log in again";

        logoutController.handleLogout();

        throw Exception(errrorMessage);
      } else {
        print('Request for pdf failed with status: ${response.statusCode}.');
        print("failed to load pdfs");

        var errorMessage = jsonDecode(response.body)['message'] ??
            "Unknown pdf error occurred";
        print("erroMessage: ${errorMessage.toString()}");
        throw Exception(errorMessage);
      }
    } on Exception catch (e) {
      Get.snackbar("Error", e.toString(),
          duration: Duration(seconds: 4),
          backgroundColor: Colors
              .red, // when 'backgroundGradient' is used then this 'backgroundColor' will not work
          titleText: const Text("Notification"), // will overwrite the 'Error'
          messageText: Text(e
              .toString()), //this will overwrite the e.toString() provided above
          colorText: Colors.black,
          backgroundGradient:
              const LinearGradient(colors: [Color(0xff004880), Colors.white]),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal);
    } finally {
      isLoading(false);
    }
  }
}
