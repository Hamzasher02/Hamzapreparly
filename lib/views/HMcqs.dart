import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/HMcqscontroller.dart';

class Mcqdata extends StatefulWidget {
  final String chapterid;
  final String subjectId;
  final chaptername;

  Mcqdata({
    required this.chapterid,
    required this.subjectId,
    required this.chaptername,
  });

  @override
  _McqdataState createState() => _McqdataState();
}

class _McqdataState extends State<Mcqdata> {
  late MsqsDController mcqsDController;
  Map<int, String?> selectedOption = {};
  Map<int, String> correctAnswer = {};
  Map<int, bool> answerShown = {};

  @override
  void initState() {
    super.initState();
    mcqsDController = Get.put(MsqsDController());
    mcqsDController.fetchMcqsDetail(widget.subjectId); // Fetch data here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff004880),
      appBar: AppBar(
        backgroundColor: Color(0xff004880),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Title(
            color: Colors.white,
            child: Text(
              '${widget.chaptername ?? ''}',
              style: TextStyle(color: Colors.white),
            )),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.all(4.0.r),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r)),
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Image.asset('assets/appBackgroundImage/mh.png'),
                )),
          ),
        ],
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 8.h),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            child: Obx(() {
              if (mcqsDController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (mcqsDController.hasError.value) {
                return Center(child: Text('Error fetching MCQs'));
              } else {
                List<Map<String, dynamic>> chapters = mcqsDController.mcqsData
                    .where((chapter) =>
                        chapter['chapter']['_id'] == widget.chapterid)
                    .toList();
                return ListView.builder(
                  itemCount: chapters.length,
                  itemBuilder: (context, index) {
                    correctAnswer[index] = chapters[index]['correct_answer'];
                    answerShown[index] ??= false;
                    selectedOption[index] ??= '';

                    final options =
                        (chapters[index]['incorrect_answer'] as List<dynamic>)
                            .cast<String?>()
                            .followedBy([correctAnswer[index]]).toList();

                    return Card(
                      elevation: 1,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${chapters[index]['questionId']} :"
                              "${chapters[index]['question']}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var option in options)
                                  ListTile(
                                    title: Text(
                                      option!,
                                      style: TextStyle(
                                        color: selectedOption[index] ==
                                                correctAnswer[index]
                                            ? option == correctAnswer[index]
                                                ? Colors.green
                                                : Colors.red
                                            : answerShown[index]!
                                                ? option == correctAnswer[index]
                                                    ? Colors.green
                                                    : Colors.red
                                                : Colors.black,
                                      ),
                                    ),
                                    leading: Checkbox(
                                      value: selectedOption[index] == option,
                                      onChanged: (value) {
                                        setState(() {
                                          if (value!) {
                                            selectedOption[index] = option;
                                          } else {
                                            selectedOption[index] = null;
                                          }
                                          if (option != correctAnswer[index]) {
                                            answerShown[index] = true;
                                          }
                                        });
                                      },
                                      activeColor: Colors
                                          .blue, // Change active color here
                                      checkColor: Colors
                                          .white, // Change check color here
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ),
      ]),
    );
  }
}
