import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:preparely/themefont/fontscolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; // Import the pdfviewer package
import '../controllers/PdfApicontroller.dart';

class PdfUrl extends StatelessWidget {
  final String chapterid;
  final String subjectId;
  final chapterimageurl;
  final subjectname;

  PdfUrl(
      {required this.chapterid,
      required this.subjectId,
      required this.subjectname,
      required this.chapterimageurl});

  @override
  Widget build(BuildContext context) {
    PdfDController pdfDController = Get.put(PdfDController());

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
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                const Icon(
                                  Icons.notifications,
                                  color: Color.fromARGB(255, 255, 255, 255),
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
                            Image.asset(
                                'assets/appBackgroundImage/pdfimage.png'),
                            Padding(
                              padding: EdgeInsets.all(3.0.r),
                              child: SizedBox(
                                width: 300.w, // Adjust the width as needed
                                child: Divider(
                                  height: 30.h,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  thickness: 2.0,
                                ),
                              ),
                            ),
                            Text(
                              '${subjectname}',
                              style: TextStyle(color: Colors.white),
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
          Expanded(
            child: FutureBuilder(
              future: pdfDController.fetchPdfDetail(subjectId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error fetching chapters'));
                } else {
                  final chapters = pdfDController.pdfdata
                      .where(
                          (chapter) => chapter['chapter']['_id'] == chapterid)
                      .toList();
                  return ListView.builder(
                    itemCount: chapters.length,
                    itemBuilder: (context, index) {
                      final chapter = chapters[index];
                      return Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: GestureDetector(
                          onTap: () {
                            showOptionDialog(context, chapter['uploadfile']);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(17)),
                              height: 145.h,
                              width: 358.w,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0.r),
                                    child: Container(
                                      height: 100.h,
                                      width: 80.w,
                                      child: Image.asset(
                                          'assets/appBackgroundImage/pdfimage.png'),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(17.r)),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0.r),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Pdf 0${index + 1}",
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          "${chapter['chapter']['chapter']}",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: FontColors.mainbluecolor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Container(
                                          height: 50.h,
                                          width: 200,
                                          decoration: BoxDecoration(
                                              color: FontColors.mainbluecolor,
                                              borderRadius:
                                                  BorderRadius.circular(17.r)),
                                          child: Center(
                                            child: Text('View Pdf',
                                                style: TextStyle(
                                                    color: FontColors
                                                        .mainwhitlecolor)),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
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

  void showOptionDialog(BuildContext context, String pdfUrl) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Preparly'),
        content: Text('Choose an option:'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              viewPDF(pdfUrl); // View PDF using syncfusion_flutter_pdfviewer
            },
            child: Text('View PDF'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              launchPDF(pdfUrl); // Download PDF using url_launcher
            },
            child: Text('Download PDF'),
          ),
        ],
      ),
    );
  }

  void viewPDF(String url) {
    Get.to(() => PdfViewerPage(pdfUrl: url));
  }

  void launchPDF(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class PdfViewerPage extends StatelessWidget {
  final String pdfUrl;

  PdfViewerPage({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: SfPdfViewer.network(
        pdfUrl,
      ),
    );
  }
}
