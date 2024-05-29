import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/Hpastpapercontroller.dart';

class PastPaper extends StatefulWidget {
  final String chapterId;
  final String subjectId;
  final imageurl;

  PastPaper({
    required this.chapterId,
    required this.imageurl,
    required this.subjectId,
  });

  @override
  _PastPaperState createState() => _PastPaperState();
}

class _PastPaperState extends State<PastPaper> {
  late PastPaperController pastPaperController;

  @override
  void initState() {
    super.initState();
    pastPaperController = Get.put(PastPaperController());
    pastPaperController.fetchPastPapers(widget.subjectId); // Fetch data here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff004880),
      body: Column(
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        widget.imageurl?.toString() ?? '',
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
                              // "${subjectname}",
                              'sdf',
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
                                // 'Please Select From ${subjectname}',
                                'df',
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
          Expanded(
            child: Obx(() {
              if (pastPaperController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (pastPaperController.hasError.value) {
                return Center(child: Text('Error fetching past papers'));
              } else {
                List<Map<String, dynamic>> papers = pastPaperController
                    .pastPapers
                    .where((paper) =>
                        paper['categoryId']['_id'] == widget.chapterId)
                    .toList();
                return ListView.builder(
                  itemCount: papers.length,
                  itemBuilder: (context, index) {
                    var paper = papers[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () =>
                            _navigateToPastPaperDetails(context, paper),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r)),
                          width: 200.w,
                          height: 80.h,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 80.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.blue[200],
                                  ),
                                  child: Image.asset(
                                    'assets/appBackgroundImage/pastpaperli.png',
                                    scale: 1.5,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(paper['papername']),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  void _navigateToPastPaperDetails(
      BuildContext context, Map<String, dynamic> paperDetails) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PastPaperDetailsScreen(paperDetails: paperDetails),
      ),
    );
  }
}

class PastPaperDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> paperDetails;

  PastPaperDetailsScreen({required this.paperDetails});

  @override
  _PastPaperDetailsScreenState createState() => _PastPaperDetailsScreenState();
}

class _PastPaperDetailsScreenState extends State<PastPaperDetailsScreen> {
  List<int?> selectedOptionIndex = [];
  int currentQuestionIndex = 0;
  List<bool> showCorrectAnswers = [];

  @override
  void initState() {
    super.initState();
    // Initialize the list of selected option indices and show correct answer flags
    selectedOptionIndex =
        List.generate(widget.paperDetails['questions'].length, (index) => null);
    showCorrectAnswers = List.generate(
        widget.paperDetails['questions'].length, (index) => false);
  }

  void _nextQuestion() {
    if (currentQuestionIndex < widget.paperDetails['questions'].length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var question = widget.paperDetails['questions'][currentQuestionIndex];
    var correctAnswerIndex = question['incorrect_answer'].length;
    return Scaffold(
      backgroundColor: Color(0xff004880),
      appBar: AppBar(
        backgroundColor: Color(0xff004880),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
                height: 80,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Image.asset('assets/appBackgroundImage/mh.png'),
                )),
          )
        ],
        title: Text(
          'Past Paper Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 247, 247, 247),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(17), topRight: Radius.circular(17))),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display current question index and total questions count
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${currentQuestionIndex + 1}/${widget.paperDetails['questions'].length}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff004880),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Question - ${currentQuestionIndex + 1}',
                        style: TextStyle(
                            color: const Color(0xff004880),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${question['question']}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  question['incorrect_answer'].length + 1,
                  (optionIndex) {
                    var isCorrectAnswer = optionIndex == correctAnswerIndex;
                    var optionText = isCorrectAnswer
                        ? question['correct_answer']
                        : question['incorrect_answer'][optionIndex];
                    var optionColor = Colors.white;
                    if (showCorrectAnswers[currentQuestionIndex]) {
                      if (selectedOptionIndex[currentQuestionIndex] ==
                          optionIndex) {
                        optionColor =
                            isCorrectAnswer ? Colors.green : Colors.red;
                      } else if (isCorrectAnswer) {
                        optionColor = Colors.green;
                      }
                    }
                    return Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: Container(
                        decoration: BoxDecoration(
                          color: optionColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: RadioListTile<int?>(
                          value: optionIndex,
                          groupValue: selectedOptionIndex[currentQuestionIndex],
                          onChanged: (value) {
                            setState(() {
                              selectedOptionIndex[currentQuestionIndex] = value;
                              showCorrectAnswers[currentQuestionIndex] = true;
                            });
                          },
                          title: Text(
                            '$optionText',
                            style: TextStyle(
                              color: showCorrectAnswers[currentQuestionIndex]
                                  ? (selectedOptionIndex[
                                                  currentQuestionIndex] ==
                                              optionIndex &&
                                          isCorrectAnswer
                                      ? Colors.black
                                      : Colors.black)
                                  : Colors.black,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 135, 190, 229),
                    )),
                    onPressed:
                        currentQuestionIndex > 0 ? _previousQuestion : null,
                    child: Text(
                      'Previous',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      Color(0xff004880),
                    )),
                    onPressed: currentQuestionIndex <
                            widget.paperDetails['questions'].length - 1
                        ? _nextQuestion
                        : null,
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
