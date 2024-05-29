// ChapterScreen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:preparely/controllers/PdfApicontroller.dart';
import 'package:preparely/themefont/fontscolor.dart';
import 'package:preparely/views/chapterdummy.dart';

import '../controllers/Mdcatdetailcontroller.dart';
import '../controllers/chaptercontainerbysubjectidbased.dart';
import 'buttonpdfvideomcqs.dart';

class MDCATDetailScreen extends StatelessWidget {
  final String subcategoryId;
  final String subjectname;
  final String imageurl;

  MDCATDetailScreen({
    required this.subcategoryId,
    required this.subjectname,
    required this.imageurl,
  });

  @override
  Widget build(BuildContext context) {
    MDCATDetailController mdcatdetailController =
        Get.put(MDCATDetailController());

    return Scaffold(
      backgroundColor: const Color(0xff004880),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Container(
            height: MediaQuery.of(context).size.width * 0.6,
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
                Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back, color: Color(0xff004880)),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.network(
                        imageurl ?? '',
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              subjectname,
                              style: fontstyle.categoryName,
                            ),
                            SizedBox(
                              width: 100,
                              child: Divider(
                                height: 2,
                                color: Color(0xff004880),
                                thickness: 2.0,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: 200.w,
                              child: Text(
                                'Please Select From $subjectname',
                                style: TextStyle(),
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
            height: 400.h,
            child: FutureBuilder(
              future: mdcatdetailController.fetchMDCATDetail(subcategoryId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final chapters = mdcatdetailController.mdcatDetailData
                      .where((chapter) =>
                          chapter['subcategoryId'] != null &&
                          chapter['subcategoryId']['_id'] == subcategoryId)
                      .toList();
                  return ListView.builder(
                    itemCount: chapters.length,
                    itemBuilder: (context, index) {
                      final chapter = chapters[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: InkWell(
                            onTap: () {
                              Get.to(() => ChapterScreen(
                                  categoryId: chapter['_id'],
                                  subjectId: chapter['_id'],
                                  imageurl: chapter['uploadfile'] ?? '',
                                  subjectname: chapter['subject'] ??
                                      '', // Pass subject ID
                                  subjectfiledname: chapter['subject'] ?? ''));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(17),
                                  topRight: Radius.circular(17),
                                  bottomRight: Radius.circular(17),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100.w,
                                    height: 100.h,
                                    child: Image.network(
                                      chapter['uploadfile'] ?? '',
                                      width: 100,
                                      height: 100,
                                      scale: 1,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(17),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0.r),
                                    child: Text(
                                      chapter['subject'] ??
                                          '', // Access 'subject' instead of 'chapter'
                                      style: fontstyle.categoryFullName,
                                    ),
                                  )
                                ],
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
        ],
      ),
    );
  }
}
