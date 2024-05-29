// import 'package:flutter/cupertino.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:preparely/controllers/Mdcatdetailcontroller.dart';
// import 'package:preparely/views/Hpastpaper.dart';
// import 'package:preparely/views/MdcatDetailScreen.dart';

// import '../themefont/fontscolor.dart';
// import 'Hmocktest.dart';

// class MDCATScreen extends StatefulWidget {
//   final RxList mdcatData;
//   final categoryname;
//   final categoryfullname;
//   final imageurl;
//   final categoryid;
//   const MDCATScreen(
//       {required this.mdcatData,
//       required this.categoryname,
//       this.categoryfullname,
//       this.imageurl,
//       required this.categoryid});

//   @override
//   State<MDCATScreen> createState() => _MDCATScreenState();
// }

// class _MDCATScreenState extends State<MDCATScreen> {
//   MDCATDetailController mdcatdetailController =
//       Get.put(MDCATDetailController());
//   Map<String, dynamic> selectedContainer = {};

//   @override
//   Widget build(BuildContext context) {
//     bool _isRotating = false;
//     return Scaffold(
//         backgroundColor: const Color(0xff004880),
//         body: Column(children: [
//           SizedBox(
//             height: 20.h,
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.width * 0.7,
//                 decoration: const BoxDecoration(
//                   color: Color(0xff004880),
//                   image: DecorationImage(
//                     image: AssetImage(
//                         'assets/appBackgroundImage/curveContainerWhite4.png'),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Builder(
//                       builder: (BuildContext context) {
//                         return SizedBox(
//                           height: MediaQuery.of(context).size.width * 0.1,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Wrap(
//                                 spacing: -12,
//                                 children: [
//                                   IconButton(
//                                     onPressed: () {
//                                       Scaffold.of(context).openDrawer();
//                                     },
//                                     icon: const Icon(
//                                       Icons.menu,
//                                       color: Color(0xff004880),
//                                     ),
//                                   ),
//                                   IconButton(
//                                     onPressed: () {},
//                                     icon: const Icon(
//                                       Icons.notifications,
//                                       color: Color(0xff004880),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.all(8.0.r),
//                           child: Image.network(
//                             widget.imageurl,
//                             width: 100.w, // Adjust the width as needed
//                             height: 100.h, // Adjust the height as needed
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.all(8.0.r),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       widget.categoryname,
//                                       style: fontstyle.categoryName,
//                                     ),
//                                     const SizedBox(
//                                       width: 100, // Adjust the width as needed
//                                       child: Divider(
//                                         height: 2,
//                                         color: Color.fromARGB(255, 10, 10, 10),
//                                         thickness: 2.0,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 250.w,
//                                       child: Text(
//                                         widget.categoryfullname ??
//                                             'Category Name Not Available',
//                                         softWrap: true,
//                                         overflow: TextOverflow.ellipsis,
//                                         maxLines: 2,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 195.h,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0.r),
//                   child: ListView.builder(
//                     itemCount: widget.mdcatData.length,
//                     itemBuilder: (context, index) {
//                       final item = widget.mdcatData[index];
//                       final categoryId = item['_id'];
//                       return Column(
//                         children: [
//                           Card(
//                             color: Colors.white,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(19.r)),
//                               child: ListTile(
//                                 onTap: () async {
//                                   setState(() {
//                                     _isRotating = true;
//                                   });
//                                   // Fetch MDCAT detail data based on categoryId
//                                   await mdcatdetailController
//                                       .fetchMDCATDetail(categoryId);
//                                   // Navigate to the next screen passing the fetched data
//                                   Get.to(() => MDCATDetailScreen(
//                                         imageurl: widget.imageurl,
//                                         categoryId: categoryId,
//                                         mdcatDetailData: mdcatdetailController
//                                             .mdcatDetailData,
//                                         fieldName: '${item['subname']}',
//                                         categoryname: widget.categoryname,
//                                       ))?.then((_) {
//                                     setState(() {
//                                       _isRotating = false;
//                                     });
//                                   });
//                                 },
//                                 title: Text("${item['subname']}"),
//                                 trailing: _isRotating
//                                     ? const RotationTransition(
//                                         turns: AlwaysStoppedAnimation(
//                                             0.5), // Change the value as needed for rotation
//                                         child: CircleAvatar(
//                                           backgroundColor: Color(0xff004880),
//                                           child: Icon(
//                                             Icons.arrow_forward_ios_rounded,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                       )
//                                     : const CircleAvatar(
//                                         backgroundColor: Color(0xff004880),
//                                         child: Icon(
//                                           Icons.arrow_forward_ios_rounded,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8.0.w),
//                 child: Card(
//                     child: ListTile(
//                   onTap: () {
//                     // Navigate to  the past paper screen
//                     Get.to(() => Mocktest(
//                           chapterId: widget.categoryid,
//                           subjectId: widget.categoryid,
//                         ));
//                   },
//                   title: Text("Mock Test"),
//                   trailing: CircleAvatar(
//                     backgroundColor: Color(0xff004880),
//                     child: Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: Colors.white,
//                     ),
//                   ),
//                 )),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8.0.w),
//                 child: Card(
//                     child: ListTile(
//                   onTap: () {
//                     // Navigate to  the past paper screen
//                     Get.to(() => PastPaper(
//                           chapterId: widget.categoryid,
//                           subjectId: widget.categoryid,
//                         ));
//                   },
//                   title: Text("Past paper"),
//                   subtitle: Text("${widget.categoryid}"),
//                   trailing: CircleAvatar(
//                     backgroundColor: Color(0xff004880),
//                     child: Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: Colors.white,
//                     ),
//                   ),
//                 )),
//               ),
//             ],
//           ),
//         ]));
//   }
// }
// ChapterScreen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:preparely/views/Hmocktest.dart';
import 'package:preparely/views/Hpastpaper.dart';
import 'package:preparely/views/MdcatDetailScreen.dart';
import '../controllers/Hdummycontroller.dart';

class Mdcatee extends StatelessWidget {
  final String categoryId;
  final String subjectId;
  final imageurl;
  final String subjectname;

  Mdcatee({
    required this.categoryId,
    required this.imageurl,
    required this.subjectId,
    required this.subjectname,
  });

  @override
  Widget build(BuildContext context) {
    DummyController dummyController = Get.put(DummyController());
    return Scaffold(
      backgroundColor: const Color(0xff004880),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.7,
                decoration: const BoxDecoration(
                  color: Color(0xff004880),
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/appBackgroundImage/curveContainerWhite4.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Builder(
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Wrap(
                                spacing: -12,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Scaffold.of(context).openDrawer();
                                    },
                                    icon: const Icon(
                                      Icons.menu,
                                      color: Color(0xff004880),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.notifications,
                                      color: Color(0xff004880),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.h, vertical: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.network(
                            imageurl?.toString() ?? '',
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${subjectname}",
                                  style: TextStyle(color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 100, // Adjust the width as needed
                                  child: Divider(
                                    height: 2,
                                    color: Colors.black,
                                    thickness: 2.0,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  width: 200,
                                  child: Text(
                                    'Please Select From ${subjectname}',
                                    style: TextStyle(color: Colors.black),
                                    maxLines: 4,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 210.h,
                child: FutureBuilder(
                  future: dummyController.fetchChapterDetail(categoryId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final chapters = dummyController.dummycontroller
                          .where((chapter) =>
                              chapter['categoryId']['_id'] == categoryId &&
                              chapter['categoryId']['examname'] == 'MDCAT')
                          .toList();
                      print('Number of chapters: ${chapters.length}');
                      print('Chapters: $chapters');
                      return ListView.builder(
                        itemCount: chapters.length,
                        itemBuilder: (context, index) {
                          final chapter = chapters[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0.r, vertical: 6.0),
                            child: Card(
                              child: ListTile(
                                onTap: () {
                                  Get.to(() => MDCATDetailScreen(
                                        imageurl: imageurl,
                                        subcategoryId: chapters[index]['_id'],
                                        subjectname: chapters[index]['subname'],
                                      ));
                                },
                                title: Text("${chapter['subname']}"),
                                trailing: CircleAvatar(
                                  backgroundColor: Color(0xff004880),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0.r, vertical: 6.0),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      // Navigate to  the mock test screen
                      Get.to(() => Mocktest(
                            chapterId: categoryId,
                            subjectId: categoryId,
                          ));
                    },
                    title: Text("Mock Test"),
                    trailing: CircleAvatar(
                      backgroundColor: Color(0xff004880),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0.r, vertical: 6.0),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      // Navigate to  the past paper screen
                      Get.to(() => PastPaper(
                            chapterId: categoryId,
                            subjectId: categoryId,
                            imageurl: imageurl,
                          ));
                    },
                    title: Text("Past paper"),
                    trailing: CircleAvatar(
                      backgroundColor: Color(0xff004880),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
