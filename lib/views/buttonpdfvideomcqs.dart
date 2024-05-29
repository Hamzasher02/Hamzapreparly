import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:preparely/themefont/fontscolor.dart';
import 'package:preparely/views/HMcqs.dart';
import 'package:preparely/views/pdfviewscfreen.dart';

import 'chapterdummy.dart';
import 'videoviewscreen.dart';

/// pdfurl.dart
class pdfvideoMcqsscreenbutton extends StatelessWidget {
  final String chapterid;
  final String subjectId;
  final chapterimageurl;
  final subjectname;

  const pdfvideoMcqsscreenbutton(
      {required this.chapterid,
      required this.subjectId,
      required this.subjectname,
      required this.chapterimageurl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            Padding(
              padding: EdgeInsets.all(18.0.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('assets/appBackgroundImage/Apic.png'),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/appBackgroundImage/curveMCqs.png'),
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
                                  icon: InkWell(
                                    onTap: () => Get.back(),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.notifications,
                                    color: Color.fromARGB(255, 255, 255, 255),
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
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.network(
                              chapterimageurl ?? '',
                              width: 100,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                            Padding(
                              padding: EdgeInsets.all(3.0.r),
                              child: SizedBox(
                                width: 300.w, // Adjust the width as needed
                                child: Divider(
                                  height: 30.h,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  thickness: 5.0,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${subjectname}',
                                  style: fontstyle.chaterFullName,
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(15.0.r),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => Mcqdata(
                          subjectId: subjectId,
                          chapterid: chapterid,
                          chaptername: subjectname,
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFAFD3FE),
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                    color: Color(0xff004880), width: 2.w)),
                            child: Padding(
                              padding: EdgeInsets.all(10.0.r),
                              child: Image.asset(
                                  'assets/appBackgroundImage/Mcqs.png'),
                            ),
                          ),
                        ),
                        Text(
                          "MCQ's",
                          style: TextStyle(
                            fontSize: 30.h,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff004880),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 80.sp,
                          color: Color(0xff004880),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0.r),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => PdfUrl(
                          chapterid: chapterid,
                          subjectId: subjectId,
                          subjectname: subjectname,
                          chapterimageurl: chapterimageurl,
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFAFD3FE),
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                    color: Color(0xff004880), width: 2.w)),
                            child: Padding(
                              padding: EdgeInsets.all(10.0.r),
                              child: Image.asset(
                                  'assets/appBackgroundImage/buttonpdf.png'),
                            ),
                          ),
                        ),
                        Text(
                          "PDF",
                          style: TextStyle(
                            fontSize: 30.h,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff004880),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 80.sp,
                          color: Color(0xff004880),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0.r),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => videoUrl(
                        chapterid: chapterid,
                        subjectId: subjectId,
                        subjectname: subjectname,
                        chapterimageurl: chapterimageurl));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFAFD3FE),
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                    color: Color(0xff004880), width: 2.w)),
                            child: Padding(
                              padding: EdgeInsets.all(10.0.r),
                              child: Image.asset(
                                  'assets/appBackgroundImage/play.png'),
                            ),
                          ),
                        ),
                        Text(
                          "video",
                          style: TextStyle(
                            fontSize: 30.h,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff004880),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 80.sp,
                          color: Color(0xff004880),
                        )
                      ],
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
