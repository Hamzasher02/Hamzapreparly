import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // used for DateTime format
import 'package:shimmer/shimmer.dart';

import '../Widgets/pdf_reader.dart';
import '../controllers/pdfController.dart';
import '../models/pdfModel.dart';

class PdfListScreen extends StatefulWidget {
  final String chapterClicked; //  -----> compared with "pdfList.chapterid.id"

  const PdfListScreen({Key? key, required this.chapterClicked})
      : super(key: key);

  @override
  State<PdfListScreen> createState() => _PdfListScreenState();
}

class _PdfListScreenState extends State<PdfListScreen> {
  PdfController pdfController = Get.put(PdfController());

  // we take the dataType of 'myPdfList' as '<PdfList>?' because we are assigning all items to "myVideosList" and all those items belong to a list of type '<PdfList>?' in the Model class
  late RxList<PdfList>? myPdfList;

  @override
  void initState() {
    super.initState();

    // we are initializing 'myPdfList' with list of type '<PdfList>?' because we are assigning all items to "myPdfList" and all those items belong to a list of type '<PdfList>?' in the model Class
    myPdfList = RxList<PdfList>([]);

    ever(pdfController.pdfModelObj, (_) {
      List<PdfList> filteredPdfList = pdfController.pdfModelObj.value!.pdfList!
          .where((pdfCompareOBJ) =>
              pdfCompareOBJ.chapterid!.id == widget.chapterClicked)
          .toList();

      if (filteredPdfList.isEmpty) {
        // If the filteredPdfList is empty, meaning there are no matching PdfList objects for the clicked chapter, the code creates a new PdfList object with the message "No PDFs found for this chapter" and assigns it to the myPdfList property using the assignAll method.
        myPdfList?.assignAll([PdfList(name: "No PDFs found for this chapter")]);
        print("No PDFs found for this chapter");
      } else {
        myPdfList?.assignAll(filteredPdfList);
        printFilteredPdfList();
      }
    });
  }

  void printFilteredPdfList() {
    print("printing list of my filtered pdfs[myPdfList] in pdfListScreen:");
    for (var pdf in myPdfList!) {
      print(
          "Subject ID: ${pdf.id}, Name: ${pdf.name}, videoForeignKey: ${pdf.chapterid!.id}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text("PDF Reader"),
        ),
        body: Obx(() {
          if (pdfController.isLoading.value) {
            return Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade200,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 19,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return AspectRatio(
                            aspectRatio: 10 / 3,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.grey[100],
                              elevation: 6,
                              shadowColor: Colors.blueGrey.shade700,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade200,
                                highlightColor: Colors.grey.shade100,
                                child: ListTile(
                                  title: Container(
                                    height: 17,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  leading: Icon(
                                    Icons.picture_as_pdf,
                                    color: Colors.white,
                                    size: MediaQuery.of(context).size.width *
                                        0.08,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (myPdfList!.isEmpty) {
            return Center(
              child: Text(
                "Pdf files will be added soon",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Text(
                          "Recent Documents",
                          style: GoogleFonts.roboto().copyWith(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .fontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    ListView.builder(
                      itemCount: myPdfList!.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final pdfObj = myPdfList![index];

                        ///  ...... the dateTime format is causing null check error

                        // String dateString = pdfObj.updatedAt!.toString();  // The ! operator is used to tell the compiler that the updatedAt property is not null, so it can be safely accessed and converted to a string.
                        // DateTime dateTime = DateTime.parse(dateString);   // DateTime.parse(dateString) converts the string representation of the updatedAt date and time back into a DateTime object using the parse() method.
                        // DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss'); // DateFormat('yyyy-MM-dd HH:mm:ss') creates a DateFormat object that formats the date and time in the desired pattern: yyyy-MM-dd HH:mm:ss.
                        // String formattedDate = dateFormat.format(dateTime);      // dateFormat.format(dateTime) formats the dateTime object using the DateFormat object, returning a formatted string representation of the date and time.

                        if (pdfObj.name == "No PDFs found for this chapter") {
                          return Center(
                            child: Text(
                              "No PDFs found for this chapter",
                              style: GoogleFonts.nunito().copyWith(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .fontSize,
                              ),
                            ),
                          );
                        } else {
                          return AspectRatio(
                            aspectRatio: 10 / 3,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.grey[100],
                              elevation: 6,
                              shadowColor: Colors.blueGrey.shade700,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: ListTile(
                                onTap: () async {
                                  String pdfUrl = pdfObj.myFile
                                      .toString(); // the "url" of pdf clicked will now be passed to pdf reader
                                  String pdfTitle = pdfObj.name!;
                                  Get.to(
                                      () => PdfReader(
                                            PdfUrl: pdfUrl,
                                            PdfTitle: pdfTitle,
                                          ),
                                      transition: Transition.downToUp,
                                      duration:
                                          const Duration(milliseconds: 220));
                                },

                                title: Text(
                                  pdfObj.name!,
                                  style: GoogleFonts.nunito().copyWith(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .fontSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),

                                // subtitle: Text(                    // this widget display the datTime in the view to user
                                //     formattedDate,
                                //     style: GoogleFonts.nunito(color: Colors.grey).copyWith(
                                //       fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                                //     )
                                // ),

                                leading: Icon(
                                  Icons.picture_as_pdf,
                                  color: Colors.red,
                                  size:
                                      MediaQuery.of(context).size.width * 0.08,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
