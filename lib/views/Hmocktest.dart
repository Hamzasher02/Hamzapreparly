import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/Hmocktestcontroller.dart';

class Mocktest extends StatefulWidget {
  final String chapterId;
  final String subjectId;

  Mocktest({
    required this.chapterId,
    required this.subjectId,
  });

  @override
  _MocktestState createState() => _MocktestState();
}

class _MocktestState extends State<Mocktest> {
  late MocktestController hMocktestController;

  @override
  void initState() {
    super.initState();
    hMocktestController = Get.put(MocktestController());
    hMocktestController.fetchmocktest(widget.subjectId); // Fetch data here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MockTest'),
      ),
      body: Obx(() {
        if (hMocktestController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (hMocktestController.hasError.value) {
          return Center(child: Text('Error fetching past papers'));
        } else {
          List<Map<String, dynamic>> papers = hMocktestController.pastPapers
              .where((paper) => paper['categoryId']['_id'] == widget.chapterId)
              .toList();
          return ListView.builder(
            itemCount: papers.length,
            itemBuilder: (context, index) {
              var paper = papers[index];
              return ListTile(
                title: Text(paper['mockname']),
                onTap: () {
                  _navigateToPastPaperDetails(context, paper);
                },
              );
            },
          );
        }
      }),
    );
  }

  void _navigateToPastPaperDetails(
      BuildContext context, Map<String, dynamic> paperDetails) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MocktestDetailScreen(paperDetails: paperDetails),
      ),
    );
  }
}

class MocktestDetailScreen extends StatefulWidget {
  final Map<String, dynamic> paperDetails;

  MocktestDetailScreen({required this.paperDetails});

  @override
  _MocktestDetailScreenState createState() => _MocktestDetailScreenState();
}

class _MocktestDetailScreenState extends State<MocktestDetailScreen> {
  List<int?> selectedOptionIndex = [];
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the list of selected option indices
    selectedOptionIndex =
        List.generate(widget.paperDetails['questions'].length, (index) => null);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Mock Test Details'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}/${widget.paperDetails['questions'].length}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "${question['question']}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                question['incorrect_answer'].length,
                (optionIndex) {
                  var option = question['incorrect_answer'][optionIndex];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selectedOptionIndex[currentQuestionIndex] ==
                                  optionIndex
                              ? Colors.green
                              : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: RadioListTile<int?>(
                        value: optionIndex,
                        groupValue: selectedOptionIndex[currentQuestionIndex],
                        onChanged: (value) {
                          setState(() {
                            selectedOptionIndex[currentQuestionIndex] = value;
                          });
                        },
                        title: Text('$option'),
                      ),
                    ),
                  );
                },
              )..add(
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selectedOptionIndex[currentQuestionIndex] ==
                                  question['incorrect_answer'].length
                              ? Colors.green
                              : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: RadioListTile<int?>(
                        value: question['incorrect_answer'].length,
                        groupValue: selectedOptionIndex[currentQuestionIndex],
                        onChanged: (value) {
                          setState(() {
                            selectedOptionIndex[currentQuestionIndex] = value;
                          });
                        },
                        title: Text('${question['correct_answer']}'),
                      ),
                    ),
                  ),
                ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed:
                      currentQuestionIndex > 0 ? _previousQuestion : null,
                  child: Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: currentQuestionIndex <
                          widget.paperDetails['questions'].length - 1
                      ? _nextQuestion
                      : null,
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
