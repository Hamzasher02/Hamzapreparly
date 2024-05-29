// ChapterScreen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:preparely/controllers/PdfApicontroller.dart';
import 'package:preparely/themefont/fontscolor.dart';

import '../controllers/chaptercontainerbysubjectidbased.dart';
import 'buttonpdfvideomcqs.dart';

class ChapterScreen extends StatelessWidget {
  final String categoryId;
  final String subjectId;
  final subjectname;
  final imageurl;
  final subjectfiledname;

  ChapterScreen(
      {required this.categoryId,
      required this.subjectId,
      required this.imageurl,
      required this.subjectname,
      required this.subjectfiledname});

  @override
  Widget build(BuildContext context) {
    ChapterController chapterController = Get.put(ChapterController());

    return Scaffold(
        backgroundColor: const Color(0xff004880),
        body: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                      padding: EdgeInsets.all(12.0.r),
                      child: InkWell(
                        onTap: () => Get.back(),
                        child: Icon(Icons.arrow_back, color: Color(0xff004880)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            imageurl,
                            width: 100.w, // Adjust the width as needed
                            height: 100.h, // Adjust the height as needed
                            fit: BoxFit.contain,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${subjectname}",
                                  style: fontstyle.categoryName,
                                ),
                                const SizedBox(
                                  width: 100, // Adjust the width as needed
                                  child: Divider(
                                    height: 2,
                                    color: Color(0xff004880),
                                    thickness: 2.0,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  width: 200.w,
                                  child: Text(
                                    'Please Slect From ${subjectfiledname + " " + subjectname}',
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
                    future: chapterController.fetchChapterDetail(subjectId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                'Error fetching chapters: ${snapshot.error}'));
                      } else {
                        print(
                            'Chapter detail data: ${chapterController.chapterDetailData}');
                        final chapters = chapterController.chapterDetailData
                            .where((chapter) =>
                                chapter != null &&
                                chapter['subject'] != null &&
                                chapter['subject']['_id'] == subjectId)
                            .toList();

                        print('Filtered chapters: $chapters');
                        return ListView.builder(
                          itemCount: chapters.length,
                          itemBuilder: (context, index) {
                            final chapter = chapters[index];
                            print('Chapter: $chapter');
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => pdfvideoMcqsscreenbutton(
                                          chapterid: chapter['_id'],
                                          subjectId: subjectId,
                                          chapterimageurl:
                                              chapter['uploadfile'],
                                          subjectname: chapter['chapter'],
                                        ));
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
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.only(
                                              bottomRight:
                                                  Radius.circular(17.r),
                                            ),
                                          ),
                                          child: Image.network(
                                            chapter['uploadfile'] ?? '',
                                            width: 100.w,
                                            height: 100.h,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0.r),
                                          child: Text(
                                            chapter['chapter'] ?? '',
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
                  )),
            ],
          ),
        ]));
  }
}
