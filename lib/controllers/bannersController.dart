import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/bannersModel.dart';
import '../utilities/api_endpoints.dart';
import 'logoutController.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();  //creating the instance (_prefs) of sharedPreferences

class BannerController extends GetxController {
  var banners = List<BannerList>.empty().obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  // When the _refresh function is called, it fetches the data again using the fetchCategoryList method, which will update the data in your categoryList observable list.
  // Future<void> refresh() async{
  //   // Fetch or refresh data again
  //   fetchBanners(); // Call your banners method again
  //   Future.delayed(const Duration(seconds: 1));
  // }

  void fetchBanners() async {
    try {

      final SharedPreferences prefs = await _prefs;    // we have assigned the private variable to the public variable "prefs" for accessibility

      Map<String, String> headers = {'Authorization': 'Bearer ${prefs.get('token')}'};

      Uri url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.banner);


      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {

        print("printing banner response.body: ${response.body}");

        final bannersModel = bannersModelFromJson(response.body);   // data firstly assigned to an object of model class
        print("Printing banner image source:");
        bannersModel.bannerList?.forEach((banner) {
          print(banner.bannerImage);
        });

        // Filter banners that have images
        final bannersWithImages = bannersModel.bannerList
            ?.where((banner) => banner.bannerImage != null && banner.bannerImage!.isNotEmpty)
            .toList();
        if (bannersWithImages != null && bannersWithImages.isNotEmpty) {
          banners.assignAll(bannersWithImages);
        }

      } else if (response.statusCode ==  400 ) {    // this condition works when token is Expired so we need to remove it from local storage

        LogoutController logoutController = Get.put(LogoutController());

       // var errrorMessage = "Token expired. Please log in again";

        logoutController.handleLogout();

      //  throw Exception(errrorMessage);

      } else {
        print('Request for banner failed with status: ${response.statusCode}.');

        var errorMessage = jsonDecode(response.body) ['message'] ?? "Unknown pdf error occurred";
        print("erroMessage: ${errorMessage.toString()}");
       // throw Exception(errorMessage);
      }
    }
    on Exception catch(e) {

      // Get.snackbar(
      //     "Error",
      //     e.toString(),
      //     duration: Duration(seconds: 4),
      //     backgroundColor: Colors.red,            // when 'backgroundGradient' is used then this 'backgroundColor' will not work
      //     titleText: Text("Notification"),       // will overwrite the 'Error'
      //     messageText: Text("${e.toString()}"),  //this will overwrite the e.toString() provided above
      //     colorText: Colors.black,
      //     backgroundGradient: const LinearGradient(colors: [Color(0xff004880),Colors.white]),
      //     snackPosition: SnackPosition.TOP,
      //     isDismissible: true,
      //     dismissDirection: DismissDirection.horizontal
      // );

    }
  }
}




