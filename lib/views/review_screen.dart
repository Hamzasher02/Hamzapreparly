import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'McqsPdfsVideosScreen.dart';

class ReviewScreen extends StatefulWidget {

  final String screenTitle;
  final String chapterClicked;

  final String? source;

  const ReviewScreen({super.key,
    required this.screenTitle,     //// ------> this same chapters screen title will also be passed on exit from quiz app.
    required this.chapterClicked,   ////  -----> this id is passed here so that on exit from MCQs user can be redirected to the same chapter's 'McqsPdfsVideoScreen'.
    this.source
  });

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {

  List<Map<String, dynamic>> selectedMCQs = [];

  int currentMCQIndex = 0;

  @override
  void initState() {
    super.initState();

    loadSelectedMCQs();
  }

  Future<void> loadSelectedMCQs() async {
    SharedPreferences prefsList = await SharedPreferences.getInstance();
    String? selectedMCQsJson = prefsList.getString("selected_mcqs");
    if (selectedMCQsJson != null) {
      selectedMCQs = List<Map<String, dynamic>>.from(json.decode(selectedMCQsJson));
      print("Selected MCQs: $selectedMCQs");
      setState(() {});
    }
  }

  void clearPrefsList() async {    //this method that clears the selected_mcqs key in the shared preferences and navigates the user to the home screen
    SharedPreferences prefsList = await SharedPreferences.getInstance();
    await prefsList.remove("selected_mcqs");
    print("printing prefsList after deleting its data: ${prefsList.getString("selected_mcqs")}");
  }


  @override
  Widget build(BuildContext context) {
    if (selectedMCQs.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Review Screen"),
          backgroundColor: const Color(0xff004880),
          actions: [
            IconButton(
              onPressed: () {
                clearPrefsList();

                if(widget.source == 'mock') {

                  Get.back();

                } else if (widget.source == 'pastPaper') {

                  Get.back();

                } else {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return McqsPdfsVideosScreen(screenTitle: widget.screenTitle, chapterClicked: widget.chapterClicked);   // on exit from quiz app we will be redirected to 'McqsPdfsVideosScreen' screen for the same chapter which we are already in because we passed the same 'id' back
                  },));
                }

              },
              icon: Icon(Icons.close),
            ),
          ],
        ),

        body: Center(
          child: Text("No MCQs selected for review."),
        ),
      );
    }

    Map<String, dynamic> mcq = selectedMCQs[currentMCQIndex];
    String question = mcq["question"];
    String selectedOption = mcq["selected_option"];
    String correctOption = mcq["correct_option"];
    String result = mcq["result"];

    print("Selected Option: $selectedOption");
    print("Correct Option: $correctOption");
    print("Result: $result");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Review"),
        backgroundColor: const Color(0xff004880),
        actions: [
          IconButton(
            onPressed: () {
              clearPrefsList();

              if(widget.source == 'mock') {

                Get.back();

              } else if (widget.source == 'pastPaper') {

                Get.back();

              } else {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return McqsPdfsVideosScreen(screenTitle: widget.screenTitle, chapterClicked: widget.chapterClicked);   // on exit from quiz app we will be redirected to 'McqsPdfsVideosScreen' screen for the same chapter which we are already in because we passed the same 'id' back
                },));
              }

            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Question ${currentMCQIndex + 1}",
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,

                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    question,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Selected Option: \n\n$selectedOption",
                    style: TextStyle(fontSize: 20.0, color: result == "correct" ? Colors.green : Colors.red),
                  ),

                  SizedBox(height: 8.0),
                  Text(
                    "\nCorrect Option: \n\n$correctOption",
                    style: TextStyle(fontSize: 20.0, color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.blueGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                  onPressed: currentMCQIndex == 0 ? null : () => setState(() => currentMCQIndex--),
                ),
                Text(
                  "${currentMCQIndex + 1} / ${selectedMCQs.length}",
                  style: TextStyle(fontSize: 20.0,color: Colors.white),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                  onPressed: currentMCQIndex == selectedMCQs.length - 1 ? null : () => setState(() => currentMCQIndex++),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
