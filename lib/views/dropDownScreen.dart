// import 'dart:math';

// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:preparely/utilities/sharedPrefernces/sharedPreferences.dart';
// import 'package:preparely/views/pastPapersScreen.dart';
// import 'package:preparely/views/subjectsScreen.dart';
// // 
// import '../controllers/dropdowncontroller.dart';
// import '../controllers/gridViewController.dart';
// import '../size_config.dart';
// import '../components/AppDrawer.dart';
// import '../components/divider.dart';
// import '../models/gridViewModel.dart';
// import 'mockTestScreen.dart';

// class dropDownScreen extends StatefulWidget {
//   final String clickedCatagory;
//   final String? categFullName;
//   final String labelImage;
//   List<GridViewModel>? childrenList;
//   dropDownScreen(
//       {Key? key,
//       required this.clickedCatagory,
//       required this.childrenList,
//       required this.categFullName,
//       required this.labelImage,
//       required RxList selectedData,
//       required String id,
//       required String addlevel})
//       : super(key: key);

//   @override
//   State<dropDownScreen> createState() => _dropDownScreenState();
// }

// class _dropDownScreenState extends State<dropDownScreen> {
//   final DropdownController dropdownController = Get.put(DropdownController());
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print(
//         "lenght of dropdownapi call ${dropdownController.dropdownList.length}");
//   }

//   // we introduce an expandedIndex variable to keep track of the index of the currently expanded dropdown
//   //  Initially, it is set to -1 to indicate that no dropdown is expanded.
//   int expandedIndex = -1;

//   GridViewController gridViewController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     // It help us to  make our UI responsive
//     SizeConfig().init(
//         context); // this 'piece of code' initializes all the 'late' variables in the 'size_config' file so that we can use 'defaultSize'

//     final double statusBarHeight = MediaQuery.of(context)
//         .padding
//         .top; // calculating height of statusBar and assigning to a variable
//     return Scaffold(
//       drawer: AppDrawer(),
//       backgroundColor: const Color(
//           0xff004880), // By deafault this color is assigned to the curved area as well
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Column(children: [
//               Expanded(
//                 flex: 2,
//                 child: Container(
//                   decoration: BoxDecoration(
//                       // color: Color(0xff004880),
//                       image: DecorationImage(
//                     image: AssetImage(
//                         'assets/appBackgroundImage/curveContainerWhite4.png'),
//                     fit: BoxFit.fill,
//                   )),
//                   child: Column(
//                     children: [
//                       Builder(
//                         builder: (context) {
//                           return Container(
//                             height: MediaQuery.of(context).size.width * 0.1,
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Wrap(
//                                   spacing:
//                                       -12, // using wrap() widget to reduce spacing between icons
//                                   children: [
//                                     IconButton(
//                                       onPressed: () {
//                                         Scaffold.of(context).openDrawer();
//                                       },
//                                       icon: Icon(
//                                         Icons.menu,
//                                         color: Color(0xff004880),
//                                       ),
//                                     ),
//                                     IconButton(
//                                       onPressed: () {
//                                         print("notification working");
//                                       },
//                                       icon: Icon(
//                                         Icons.notifications,
//                                         color: Color(0xff004880),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(bottom: 30),
//                             width: 140.w,
//                             height: 140.h,
//                             padding: EdgeInsets.only(left: 26.w),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(30.w),
//                               child: Image.network(widget.labelImage),
//                             ),
//                           ),
//                           Container(
//                             width: 170.w,
//                             height: 120.h,
//                             margin: EdgeInsets.only(left: 20.w, bottom: 30.h),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Flexible(
//                                       child: FittedBox(
//                                         child: Text(
//                                           widget.clickedCatagory,
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .titleMedium!
//                                               .copyWith(
//                                                   color: Color(0xff004880),
//                                                   fontWeight: FontWeight.bold,
//                                                   letterSpacing: 1.2),
//                                         ),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Container(
//                                   margin:
//                                       EdgeInsets.only(top: 3.h, bottom: 2.h),
//                                   width: 170.w,
//                                   height: 2.h,
//                                   decoration: BoxDecoration(
//                                       color: Colors.black,
//                                       borderRadius:
//                                           BorderRadius.circular(20.r)),
//                                 ),
//                                 Row(
//                                   children: [
//                                     //writing multiLine Text
//                                     Expanded(
//                                       child: Text(
//                                         widget.categFullName.toString(),
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyMedium!
//                                             .copyWith(color: Color(0xff004880)),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
// /*
// Note: Flex property divides screen into 4+2 = 6 parts then assign parts to each container accordingly
// */
//               Expanded(
//                 flex: 4,
//                 child: SizedBox(
//                   width: 430,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         SizedBox(height: 0.1),

//                         // Check if widget.childrenList is null or empty
//                         if (widget.childrenList == null ||
//                             widget.childrenList!.isEmpty)
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 top: SizeConfig.defaultSize * 10),
//                             child: Center(
//                               child: Text(
//                                 "Data will be added soon",
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 16),
//                               ),
//                             ),
//                           )
//                         else
//                           ListView.builder(
//                             shrinkWrap: true,
//                             scrollDirection: Axis.vertical,
//                             physics: BouncingScrollPhysics(),
//                             itemCount: widget.childrenList?.length ?? 0,
//                             itemBuilder: (context, index) {
//                               bool isExpanded = index == expandedIndex;

//                               final categoryObj = widget.childrenList![index];

//                               if ([
//                                 'mock',
//                                 'Mock',
//                                 'MOCK',
//                                 'MockTest',
//                                 'MockExam',
//                                 'Mock Test',
//                                 'Mock Exam',
//                                 'mock test'
//                               ].any((keyword) =>
//                                   categoryObj.name!.contains(keyword))) {
//                                 return Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 10),
//                                       child: AttractiveDivider(),
//                                     ), // Use the custom AttractiveDivider widget,

//                                     Container(
//                                       width: MediaQuery.of(context).size.width -
//                                           25,
//                                       decoration: BoxDecoration(
//                                           color: Colors
//                                               .white, // Add a white container
//                                           borderRadius:
//                                               BorderRadius.circular(12)),
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 12, horizontal: 8),
//                                       child: ListTile(
//                                         onTap: () {
//                                           String subCategClickedId =
//                                               categoryObj.id!;
//                                           String subCategName =
//                                               categoryObj.name!;
//                                           //  String labelImage = widget.labelImage;
//                                           String bannerName2 = categoryObj
//                                               .name!; // name of the BigBanner ie; NTS, NUMS, etc.
//                                           String bannerFullName2 =
//                                               categoryObj.fullName!;

//                                           print(
//                                               " subCategClicked: $subCategClickedId : $subCategName");

//                                           Get.to(
//                                               () => mockTestScreen(
//                                                     subCategClickedId:
//                                                         subCategClickedId,
//                                                     screenTitle: bannerName2,
//                                                   ),
//                                               transition: Transition.downToUp,
//                                               duration:
//                                                   Duration(milliseconds: 220));
//                                         },
//                                         title: Text(
//                                           categoryObj.name!,
//                                           style: TextStyle(
//                                               color: Colors.lightBlue[900],
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 19),
//                                         ),
//                                         visualDensity: VisualDensity(
//                                             horizontal: 0, vertical: -3),
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               } else if ([
//                                 'PAST PAPERS',
//                                 'Past Papers',
//                                 'papers',
//                                 'Papers',
//                                 'PAPERS',
//                                 'Past Exams',
//                                 'PAST EXAMS',
//                                 'past papers'
//                               ].any((keyword) =>
//                                   categoryObj.name!.contains(keyword))) {
//                                 return Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 10),
//                                       child: AttractiveDivider(),
//                                     ), // Use the custom AttractiveDivider widget,

//                                     Container(
//                                       width: MediaQuery.of(context).size.width -
//                                           25,
//                                       decoration: BoxDecoration(
//                                           color: Colors
//                                               .white, // Add a white container
//                                           borderRadius:
//                                               BorderRadius.circular(12)),
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 12, horizontal: 8),
//                                       child: ListTile(
//                                         onTap: () {
//                                           String subCategClickedId =
//                                               categoryObj.id!;
//                                           String subCategName =
//                                               categoryObj.name!;
//                                           //  String labelImage = widget.labelImage;
//                                           String bannerName2 = categoryObj
//                                               .name!; // name of the BigBanner ie; NTS, NUMS, etc.
//                                           // String bannerFullName2 = categoryObj.fullName!;

//                                           print(
//                                               " subCategClicked: $subCategClickedId : $subCategName");

//                                           // Get.to(()=> SubjectsScreen(subCategClickedId: subCategClickedId, bannerName: bannerName2, bannerFullName: bannerFullName2, labelImage: labelImage,), transition: Transition.downToUp,duration: Duration(milliseconds: 220));

//                                           Get.to(
//                                               () => PastPapersScreen(
//                                                     subCategClickedId:
//                                                         subCategClickedId,
//                                                     screenTitle: bannerName2,
//                                                   ),
//                                               transition: Transition.downToUp,
//                                               duration:
//                                                   Duration(milliseconds: 220));
//                                         },
//                                         title: Text(
//                                           categoryObj.name!,
//                                           style: TextStyle(
//                                               color: Colors.lightBlue[900],
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 19),
//                                         ),
//                                         visualDensity: VisualDensity(
//                                             horizontal: 0, vertical: -3),
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               } else {
//                                 return Padding(
//                                   padding:
//                                       EdgeInsets.symmetric(horizontal: 14.w),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.only(
//                                           bottomLeft: Radius.circular(12.r),
//                                           bottomRight: Radius.circular(12.r),
//                                           topLeft: Radius.circular(12.r),
//                                           topRight: Radius.circular(12.r)),
//                                     ),
//                                     margin: EdgeInsets.only(top: 12),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: [
//                                         Container(
//                                           //  margin: EdgeInsets.only(top: 18.h),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.only(
//                                                 bottomLeft:
//                                                     Radius.circular(12.r),
//                                                 bottomRight:
//                                                     Radius.circular(12.r),
//                                                 topLeft: Radius.circular(12.r),
//                                                 topRight:
//                                                     Radius.circular(12.r)),
//                                           ),

//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             mainAxisSize: MainAxisSize.max,
//                                             children: [
//                                               Expanded(
//                                                 child: Container(
//                                                   padding: EdgeInsets.symmetric(
//                                                       vertical: 3,
//                                                       horizontal: 8),
//                                                   decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8),
//                                                     color: Colors.white,
//                                                   ),
//                                                   child: ListTile(
//                                                       title: Text(
//                                                           categoryObj.name!,
//                                                           textAlign:
//                                                               TextAlign.start,
//                                                           style: TextStyle(
//                                                             fontSize: 20.sp,
//                                                             fontWeight:
//                                                                 FontWeight.w600,
//                                                             color: Color(
//                                                                 0xff004880),
//                                                             letterSpacing: 1,
//                                                           )),
//                                                       trailing:
//                                                           AnimatedRotation(
//                                                               turns: isExpanded
//                                                                   ? .5
//                                                                   : 0, // then the value = True is passed here and the icon is rotated
//                                                               duration: Duration(
//                                                                   milliseconds:
//                                                                       5),
//                                                               child: Icon(
//                                                                 Icons
//                                                                     .arrow_drop_down_circle_rounded,
//                                                                 size: 33,
//                                                                 color: Color(
//                                                                     0xff004880),
//                                                               )),

//                                                       // onTap: showForm ? handleCloseClick : handleOpenClick,
//                                                       onTap: () {
//                                                         setState(() {
//                                                           expandedIndex =
//                                                               isExpanded
//                                                                   ? -1
//                                                                   : index;
//                                                         });
//                                                       }),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         if (isExpanded) // if the 'isExpanded' variable is true then only Show the DropDown Below
//                                           Column(
//                                             children: [
//                                               Container(
//                                                 height: 5.h,
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width /
//                                                     1.09,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                           bottomLeft:
//                                                               Radius.circular(
//                                                                   30.r),
//                                                           bottomRight:
//                                                               Radius.circular(
//                                                                   30.r)),
//                                                   color: Color(0xff004880),
//                                                 ),
//                                               ),
//                                               Container(
//                                                 margin:
//                                                     EdgeInsets.only(top: 5.h),
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                     bottomLeft:
//                                                         Radius.circular(12.r),
//                                                     bottomRight:
//                                                         Radius.circular(12.r),
//                                                   ),
//                                                 ),

//                                                 // here we have passed the listTiles from the other screen
//                                                 child: Column(
//                                                   children: <Widget>[
//                                                     ListView.builder(
//                                                       shrinkWrap: true,
//                                                       physics:
//                                                           const BouncingScrollPhysics(),
//                                                       itemCount: categoryObj
//                                                               .children
//                                                               ?.length ??
//                                                           0,
//                                                       itemBuilder:
//                                                           (BuildContext context,
//                                                               int index) {
//                                                         final child = categoryObj
//                                                                 .children![
//                                                             index]; //// storing the sub children in each ListTile in the "child" object of the "CategoryList" class
//                                                         return ListTile(
//                                                           onTap: () {
//                                                             String
//                                                                 subCategClickedId =
//                                                                 categoryObj
//                                                                     .children![
//                                                                         index]
//                                                                     .id!;
//                                                             String
//                                                                 subCategName =
//                                                                 categoryObj
//                                                                     .children![
//                                                                         index]
//                                                                     .name!;
//                                                             String labelImage =
//                                                                 widget
//                                                                     .labelImage; // image passed from GridViewScreen again passed to subject screen
//                                                             String bannerName2 =
//                                                                 categoryObj
//                                                                     .name!; // name of the BigBanner ie; NTS, NUMS, etc.
//                                                             String
//                                                                 bannerFullName2 =
//                                                                 categoryObj
//                                                                     .children![
//                                                                         index]
//                                                                     .name!;

//                                                             print(
//                                                                 " subCategClicked : $subCategClickedId : $subCategName");

//                                                             Get.to(
//                                                                 () =>
//                                                                     SubjectsScreen(
//                                                                       subCategClickedId:
//                                                                           subCategClickedId,
//                                                                       bannerName:
//                                                                           bannerName2,
//                                                                       bannerFullName:
//                                                                           bannerFullName2,
//                                                                       labelImage:
//                                                                           labelImage,
//                                                                     ),
//                                                                 transition:
//                                                                     Transition
//                                                                         .downToUp,
//                                                                 duration: Duration(
//                                                                     milliseconds:
//                                                                         220));
//                                                           },
//                                                           title: Text(
//                                                             child.name!,
//                                                             style: TextStyle(
//                                                                 color: Colors
//                                                                     .black,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400),
//                                                           ),
//                                                           visualDensity:
//                                                               VisualDensity(
//                                                                   horizontal: 0,
//                                                                   vertical:
//                                                                       -3), // visualDensity: VisualDensity(horizontal: 0, vertical: -3) // this property is to reduce the space between ListTiles in Expansiontile widget
//                                                         );
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           )
//                                       ],
//                                     ),
//                                   ),
//                                 );

//                                 //   DropDownContainer(
//                                 //   ExpansionTileName: categoryObj.name!,
//                                 //   column: Column(
//                                 //     children: <Widget>[
//                                 //       ListView.builder(
//                                 //         shrinkWrap: true,
//                                 //         physics: const BouncingScrollPhysics(),
//                                 //         itemCount: categoryObj.children?.length ?? 0,
//                                 //         itemBuilder: (BuildContext context, int index) {
//                                 //           final child = categoryObj.children![index];        //// storing the sub children in each ListTile in the "child" object of the "CategoryList" class
//                                 //           return ListTile(
//                                 //             onTap: () {
//                                 //               String subCategClickedId = categoryObj.children![index].id!;
//                                 //               String subCategName = categoryObj.children![index].name!;
//                                 //               String labelImage = widget.labelImage;   // image passed from GridViewScreen again passed to subject screen
//                                 //               String bannerName2 = categoryObj.name!;    // name of the BigBanner ie; NTS, NUMS, etc.
//                                 //               String bannerFullName2 = categoryObj.children![index].name!;
//                                 //
//                                 //               print(" subCategClicked: $subCategClickedId : $subCategName");
//                                 //
//                                 //               Get.to(()=> SubjectsScreen(subCategClickedId: subCategClickedId, bannerName: bannerName2, bannerFullName: bannerFullName2, labelImage: labelImage,), transition: Transition.downToUp,duration: Duration(milliseconds: 220));
//                                 //
//                                 //             },
//                                 //             title: Text(
//                                 //               child.name!,
//                                 //               style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
//                                 //             ),
//                                 //             visualDensity: VisualDensity(horizontal: 0, vertical: -3),   // visualDensity: VisualDensity(horizontal: 0, vertical: -3) // this property is to reduce the space between ListTiles in Expansiontile widget
//                                 //           );
//                                 //         },
//                                 //       ),
//                                 //     ],
//                                 //   ),
//                                 // );
//                               }
//                             },
//                           ),

//                         Container(
//                           margin: EdgeInsets.only(bottom: 8.h),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ]),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Defining "MyCustomClipper" class to draw 'bazier curve'

// class MyCustomClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     // Getter method

//     Path path = Path(); // Creating an instance for Path

// /*
//               // this way a complete imaginary path is drawn around the end points of a container
//     path.lineTo(0, 0);                      // TopLeft Corner     [By default the container starts to draw line from this point where Width (x) = 0 & Height (y) = 0]
//     path.lineTo(0, size.height);            // BottomLeft Corner  [then line goes toward Width (x) = 0 & Height (y) = size.height (max height)]
//     path.lineTo(size.width, size.height);   // BottomRight Corner [Next line goes toward Width (x) = size.width & Height (y) = size.height (max height from top down)]
//     path.lineTo(size.width, 0);             // TopRight Corner    [Finaly goes toward the last Point where Width (x) = size.width (max) & Height (y) = 0 (Because height is considered from top to bottom not from bottom to top)]
// */

//     path.lineTo(
//         0.0,
//         size.height -
//             60); //Bringing the control to starting point of the curve by mentioning the second point of contianer and by default the cursor draw a line from starting point to this point

//     // Control Points are the Crest and Trough of the curve
//     var firstControlPoint = Offset(size.width / 100, size.height - 24);
//     var firstEndPoint =
//         Offset(size.width / 8, size.height - 24); // Middle point of the curve
//     path.quadraticBezierTo(
//         firstControlPoint.dx,
//         firstControlPoint.dy,
//         firstEndPoint.dx,
//         firstEndPoint
//             .dy); // ... We must write the ControlPoints first then the EndPoints

//     var secondControlPoint = Offset(
//         size.width - (size.width / 4),
//         size.height -
//             24); // ... dividing the width into 3.25 parts so as to get the width of one part then subtracting that one part from total width so that we can reach the secondControlPoint
//     var secondEndPoint = Offset(
//         size.width - (size.width / 4),
//         size.height -
//             24); // This endPoint is mentioned for the Curve while the {{ path.lineTo(size.width, size.height - 40); }} is mentioned below to complete the path
//     path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
//         secondEndPoint.dx, secondEndPoint.dy);

//     var thirdControlPoint =
//         Offset(size.width - (size.width / 4) + 70, size.height - 24);
//     var thirdEndPoint =
//         Offset(size.width - (size.width / 4) + 70, size.height - 24);
//     path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
//         thirdEndPoint.dx, thirdEndPoint.dy);

//     var fourthControlPoint =
//         Offset(size.width - (size.width / 4) + 96, size.height - 24);
//     var fourthEndPoint = Offset(size.width, size.height);
//     path.quadraticBezierTo(fourthControlPoint.dx, fourthControlPoint.dy,
//         fourthEndPoint.dx, fourthEndPoint.dy);

//     path.lineTo(size.width,
//         size.height / 3 + 20); // drawing line near to TopRight corner

//     //............Now taking Points Control and EndPoints for curve in the TopRight Corner..................
//     var fifthControlPoint = Offset(size.width - 10, size.height / 3 - 10);
//     var fifthEndPoint = Offset(size.width - 43, size.height / 3 - 10);
//     path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy,
//         fifthEndPoint.dx, fifthEndPoint.dy);

//     var sixthControlPoint = Offset(size.width - 55, size.height / 3 - 10);
//     var sixthEndPoint = Offset(size.width - 57, size.height / 3 - 10);
//     path.quadraticBezierTo(sixthControlPoint.dx, sixthControlPoint.dy,
//         sixthEndPoint.dx, sixthEndPoint.dy);

//     var seventhControlPoint = Offset(size.width - 92, size.height / 3 - 6);
//     var seventhEndPoint = Offset(size.width - 92, size.height / 4 - 27);
//     path.quadraticBezierTo(seventhControlPoint.dx, seventhControlPoint.dy,
//         seventhEndPoint.dx, seventhEndPoint.dy);

//     var EigthControlPoint = Offset(size.width - 92, size.height / 4);
//     var EigthEndPoint = Offset(size.width - 92, size.height / 4 - 34);
//     path.quadraticBezierTo(EigthControlPoint.dx, EigthControlPoint.dy,
//         EigthEndPoint.dx, EigthEndPoint.dy);

//     var ninthControlPoint = Offset(size.width - 92, size.height / 4 - 34);
//     var ninthEndPoint = Offset(size.width - 92, size.height / 4 + 6);
//     path.quadraticBezierTo(ninthControlPoint.dx, ninthControlPoint.dy,
//         ninthEndPoint.dx, ninthEndPoint.dy);

//     var tenthControlPoint = Offset(size.width - 86, size.height / 4 - 60);
//     var tenthEndPoint = Offset(size.width - 110, 0.0);
//     path.quadraticBezierTo(tenthControlPoint.dx, tenthControlPoint.dy,
//         tenthEndPoint.dx, tenthEndPoint.dy);

//     // Paths must be completed for the imaginary line from start till the end

//     path.lineTo(size.width, 0.0); // Drawing till TopRightCorner
//     path.close(); // closing the container by reaching the starting point again

//     return path; // returns the path you want to draw on the container
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true; // ..............  this true and false purpose is still unclear to me
//   }
// }
