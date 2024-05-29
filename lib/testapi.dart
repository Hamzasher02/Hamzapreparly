// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'controllers/dropdowncontroller.dart'; // Make sure to import Get package
// // Import your dropdown controller

// class YourUiClass extends StatelessWidget {
//   final DropdownController dropdownController =
//       Get.find(); // Access the controller

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your App'),
//       ),
//       body: Obx(() {
//         // Use Obx to reactively update the UI when data changes
//         final dropdownList = dropdownController.dropdownList;

//         // Replace 'yourCategoryId' with the actual category ID you want to display
//         final filteredList = dropdownList
//             .where((item) => item.parentId == 'yourCategoryId')
//             .toList();

//         return ListView.builder(
//           itemCount: filteredList.length,
//           itemBuilder: (context, index) {
//             final item = filteredList[index];
//             return ListTile(
//               title: Text(item.subname ?? ''),
//               // Add other widgets to display other information
//             );
//           },
//         );
//       }),
//     );
//   }
// }
