// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:preparely/utilities/sharedPrefernces/sharedPreferences.dart';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../models/gridViewModel.dart';
// import '../utilities/api_endpoints.dart';
// import '../utilities/internet_check.dart';
// import '../views/loginScreen.dart';
// import '../views/welcomeScreen.dart';
// import 'logoutController.dart';

// final Future<SharedPreferences> _prefs = SharedPreferences
//     .getInstance(); //creating the instance (_prefs) of sharedPreferences

// class GridViewController extends GetxController {
//   var isLoading = true.obs;
//   var categoryList = List<GridViewModel>.empty(growable: true)
//       .obs; //we created and empty list of type "CategoryList" and named as [categoryList] as per in the model class

//   @override
//   void onInit() {
//     fetchCategoryList(); // when the GridViewController is initialized in the "gridViewScreen()" so this onInit() method will be called automatically thus ensures to fetch data
//     super.onInit();
//   }

//   // When the _refresh function is called, it fetches the data again using the fetchCategoryList method, which will update the data in your categoryList observable list.
//   //  It's better to place the await Future.delayed after you've called the asynchronous function you want to delay.
//   //  This ensures that the function execution will pause for the specified duration before continuing.
//   // This way, the fetchCategoryList function will be called immediately, and after it's done executing, there will be a delay of 1 second before completing the refresh
//   @override
//   Future<void> refresh() async {
//     // Fetch or refresh data again
//     fetchCategoryList(); // Call your fetchCategoryList method again
//     await Future.delayed(const Duration(seconds: 1));
//   }

//   void fetchCategoryList() async {
//     try {
//       isLoading(true);

//       // checking if the internet is available or not to show a message "import 'package:preparely_app_project/utilities/internet_check.dart';"
//       bool isInternetAvailable =
//           await checkInternetAvailability(); // Check internet connectivity

//       if (!isInternetAvailable) {
//         Fluttertoast.showToast(
//           msg: "No internet connection",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Color(0xFFFFEB3B),
//           textColor: Colors.black,
//         );
//         return;
//       }

//       final SharedPreferences prefs = await _prefs;

//       var headers = {'Authorization': 'Bearer ${prefs.get('token')}'};
//       var url = Uri.parse(
//           ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.gridViewCatagories);

//       var response = await http.get(url, headers: headers);

//       print(
//           "response before checking status code: ${jsonDecode(response.body.toString())}");

//       if (response.statusCode == 200) {
//         List<dynamic> decodedJson = json.decode(response
//             .body); // the response coming from API is in the form of '<dynamic> [List]' thus we need to store it on list and then through a loop digOut single single item from the list and convert to model class
//         print(decodedJson.toString());
//         // The List 'models' of Type <GridViewModel> is created so that once the data from 'decodedJson' a dynamic list is converted to dataType of ModelClass so then the new data can only be stored in a list of dataType <GridViewModel>
//         List<GridViewModel> models =
//             []; // in this "model" list i will store all the items index-wise coming from "decodedJson List"
//         //// this function is running 'for-Loop' and bringing out each item index-wise from the "decodedJson" List and then passing each items through the "GridViewModel.fromJson()" and storing in the object of "GridViewModel" class then finally adding all the objects from "modelClassObj" into the "models" list.
//         decodedJson.forEach((jsonObj) {
//           final modelClassObj = GridViewModel.fromJson(jsonObj);
//           models.add(
//               modelClassObj); // the dataType of the objects in this 'modelClassObj' is type 'GridViewModel' now therefore we have to store them in a list of type <GridViewModel>
//           // we donot use "addAll" because single object at a time is added to "models List"
//         });

//         categoryList.assignAll(models);
//         // Now this line of code will store all the items in "models" list to "categoryList".
//         var id = decodedJson[0]["_id"];
//         SharedPreferencesHelper.storeToken(id);
//       } else if (response.statusCode == 400) {
//         // this condition works when token is Expired so we need to remove it from local storage

//         LogoutController logoutController = Get.put(LogoutController());

//         var errrorMessage = "Token expired. Please log in again";

//         logoutController.handleLogout();

//         // throw Exception(errrorMessage);

//         Get.snackbar("Error", errrorMessage,
//             duration: const Duration(seconds: 4),
//             backgroundColor: Colors.red,
//             // when 'backgroundGradient' is used then this 'backgroundColor' will not work
//             titleText:
//                 const Text("Notification", style: TextStyle(fontSize: 16)),
//             // will overwrite the 'Error'
//             messageText:
//                 Text(errrorMessage, style: const TextStyle(fontSize: 16)),
//             //this will overwrite the e.toString() provided above
//             colorText: Colors.black,
//             backgroundGradient:
//                 const LinearGradient(colors: [Color(0xff004880), Colors.white]),
//             isDismissible: true,
//             dismissDirection: DismissDirection.horizontal);
//       } else {
//         // print('Error statusCode is:  ${response.statusCode}');
//         // throw Exception("Error status code is ${response.statusCode}");
//         return;
//       }
//     }

//     // on Exception catch (e) {
//     //   Get.snackbar(
//     //       "Error",
//     //       e.toString(),
//     //       duration: const Duration(seconds: 4),
//     //       backgroundColor: Colors.red,
//     //       // when 'backgroundGradient' is used then this 'backgroundColor' will not work
//     //       titleText: const Text("Notification", style: TextStyle(fontSize: 16)),
//     //       // will overwrite the 'Error'
//     //       messageText: Text(e.toString(), style: const TextStyle(fontSize: 16)),
//     //       //this will overwrite the e.toString() provided above
//     //       colorText: Colors.black,
//     //       backgroundGradient: const LinearGradient(colors: [Color(0xff004880),Colors.white]),
//     //
//     //       isDismissible: true,
//     //       dismissDirection: DismissDirection.horizontal
//     //   );
//     // }

//     finally {
//       isLoading(false);
//     }
//   }
// }
