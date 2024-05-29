import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preparely/controllers/Mdcatdetailcontroller.dart';
import 'package:preparely/controllers/chaptercontainerbysubjectidbased.dart';
import 'package:preparely/views/chapterdetailscreen.dart';

class chapterdetailScreen extends StatelessWidget {
  final String subjectId;

  chapterdetailScreen({required this.subjectId});

  @override
  Widget build(BuildContext context) {
    ChapterController controller = Get.put(ChapterController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Subjects'),
      ),
      body: Center(
        child: FutureBuilder(
          future: controller.fetchChapterDetail(subjectId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Display subjects in a ListView
              return ListView.builder(
                itemCount: controller.chapterDetailData.length,
                itemBuilder: (context, index) {
                  final subject = controller.chapterDetailData[index];
                  return ListTile(
                    title: Text(subject['subject']),
                    subtitle: Text(subject['_id']),
                    // onTap: () {
                    //   String selectedSubjectId =
                    //       controller.mdcatDetailData[index]['_id'];
                    //   Get.to(() =>
                    //       ChapterDetailScreen(subjectId: selectedSubjectId));
                    // },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
