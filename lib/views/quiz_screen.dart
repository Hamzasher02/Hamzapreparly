/// Note:

// 'setState' is used so that the new change made in the state of a variable can be implemented. Thus setState rebuilds the widget tree and the new
// ... change is implemented. While in statemanagement the concept is different. Like in this "Quiz_screen" all those places where setState is used,
// ... remove the setState and wrap them with 'OBX' and all the values that are to be updated in these setStates just write with them ".value" at the end.
// ... Then go and all these variables wrapped in setState whose value you are going to change, make them observable with '.obs'. And stateManagement will
// ... be ensured this way.



//........................................................................................................................................//
//........................................................................................................................................//

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preparely/views/result_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vibration/vibration.dart';

import '../const/colors.dart';
import '../const/colors.dart';
import '../const/images.dart';
import '../controllers/mcqsController.dart';
import '../controllers/mockMcqsController.dart';
import '../controllers/pastPapersMcqsController.dart';
import '../models/mcqsModel.dart';

class QuizScreen extends StatefulWidget {
  final String chapterClicked;    //  -----> compared with "pdfList.chapterid.id"
  final String screenTitle;
  final String? source;

  QuizScreen({Key? key,
    required this.chapterClicked,
    required this.screenTitle,
    this.source,

  }) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future quiz;

  @override
  void initState() {    // when we get into a stateful widget so initState function is automatically called and executed
    super.initState();

    //The context parameter is an instance of the BuildContext class. It contains information about the location of the widget within the widget tree, such as its parent and children, its position in the tree, and its theme. When you create a widget or call a function that needs to access information about the widget tree, you usually need to pass the BuildContext of the current widget as a parameter.
    //In the case, the "mcqsController.fetchMcqs(context)" function needs to show a Snackbar that is associated with the current context. The context is used to find the Scaffold widget that the Snackbar will be attached to, so it's necessary to pass it as a parameter.

    if(widget.source == 'mock') {

      quiz = fetchMockMcqs();

    } else if (widget.source == 'pastPaper') {
      quiz = fetchPastPaperMcqs();

    }else {

      quiz = fetchMcqs();   // initializing the "Future" value before the timer starts   // initializing the "Future" value before the timer starts

    }
    startTimer();   // when we get to this screen "Timer Starts"
  }

  @override
  void dispose() {    // when we get out of a stateful widget so dispose function is automatically called and executed
    super.dispose();
    timer!.cancel();   // when we get out of this screen timer stops
  }

  //i declared 'selectedMCQs' list outside of the build function and inside the State class so that this list will retain all selected MCQs otherwise if placed inside "build" method then selectedMCQs list will be overwritten with each new MCQ selected.
  List<Map<String, dynamic>> selectedMCQs = [];      //List selectedMCQs to store the selected MCQs as maps with details like the question, selected option, correct option, and result. We have added the selected MCQ to this list in both the correct and incorrect cases.

  int seconds = 60;  // variable created for timer
  Timer? timer;   // for this we import "import 'dart:async';"
  var currentQuestionIndex = 0;   // this variable is used to monitor the index of current question
  int points = 0;             // this variable is used to show final result to user

  late List<dynamic>? data;    // on this data List we will store the snapshot.data["results"]; in FutureBuilder() method  where "results" is a list inside the "data" Object of api_service class

  var isLoaded = false;

  bool _isTapEnabled = true;

  var optionsList = [];   // we will store the incorrect options inside it

  var optionsColor = [     //this method is not recommended for professional apps
    Colors.white,          // as we know we have max number of 5 MCQS options so we take 5 colors
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  Color progressColor = Colors.teal.shade300;  // initial color of the Circular progress indicator
  bool isTimeRunningOut = false;       // flag to indicate if time is running out ie; it is set to true if time goes to 30 or below

  startTimer() {
    // the 'duration' constant represents the time interval between each tick of the timer.
    const duration = Duration(seconds: 1);       //I added a const keyword to the duration variable declaration to make it a constant expression. This can help with performance because the Duration object doesn't need to be recreated every time the startTimer() function is called.
    timer = Timer.periodic(duration, (timer) {
      setState(() {
        if (seconds > 0) {         // when "startTimer" func is called the timer starts reducing each second from 60 and when gets to 0 then it executes else block
          seconds--;

          // Check if remaining time is 30 seconds or less. We check this so that we can change the color of Circular Progress Indicator after 30 seconds
          if (seconds <= 20) {
            isTimeRunningOut = true;
          }

        } else {      // This else block is executed when the timer is finished itself and gets to "0" from "60"
          if(currentQuestionIndex < data!.length - 1) {     // we subtracted 1 from total number of questions "data.length" because if (currentQuestionIndex == data.length) then an error is shown "not in inclusive range" as 'currentQuestionIndex' starts from "0" and if "data.length = 20" then range is from "0 to 19" so on 20th index MCQ you will get error
            timer.cancel();
            Future.delayed(const Duration(milliseconds: 100), (){
              isLoaded = false;   // isLoaded is made false so that the options can be updated and displayed according to the next screen question as optionsList can only be displayed if {isLoaded == true}

              // The "Duration(seconds: 1)" specifies the duration of delay before executing the callback function.
              // When the option is Clicked so after waiting for 1 second, the callback function will be executed and the currentQuestionIndex variable will be incremented by 1 and colors of the Options Containers will be reset
              currentQuestionIndex ++;       // the index of currentQuestion will keep incremented by 1 ++ until "data.length";
              resetColors();

              // Reset the flag ("isTimeRunningOut") and progress color when timer is finished
              isTimeRunningOut = false;
              progressColor = Colors.teal.shade300;

              timer.cancel();   // after I go to next Question so i want the timer to restart therefore i cancel it here
              seconds = 60;      // we make the seconds variable equal to 60 again for next Question
              startTimer();     // we restart the timer for next question
            });
          } else {
            saveSelectedMCQs(selectedMCQs);             //If there are no more questions remaining, the saveSelectedMCQs() function is called to save the selected MCQs. and navigates to the result_screen.

            Get.off(()=>
                ResultScreen(totalQuestions: data!.length, totalPoints: points, chapterClicked: widget.chapterClicked, screenTitle: widget.screenTitle, source: widget.source,),
                transition: Transition.downToUp,duration: const Duration(milliseconds: 220),
                preventDuplicates: true  //'preventDuplicates' parameter is set to true. This will prevent the user from going back to the previous screen by pressing the back button on the phone.
            );


          }
        }
      });
    });
  }

  void resetColors() {   //this method is created so that when we move to next screen so the color of all the selexted Boxes shall change back to white
    for (int i = 0; i < optionsColor.length; i++) {
      optionsColor[i] = Colors.white;
    }
  }

  List filterQuestionsByChapterId(dynamic allData, String chapterClicked) {   // the data and chapter clicked are arguments passed from bellow

    if (widget.source == 'mock') {

      List filteredQuestions = []; //The function creates an empty list called filteredQuestions, which will be used to store the questions that match the chapterClicked.
      for (var question in allData) {   // It then iterates over each question in data using a for loop.
        //For each question, the function checks whether the chapterid field of that question matches the chapterClicked ID. If the two IDs match, the function prints out the chapterid and adds that question to the filteredQuestions list using the add() method.
        if (question['mock'] == chapterClicked) {   // on the basis of Item name we do classification and filteration here
          filteredQuestions.add(question);
        }
      }
      return filteredQuestions.isEmpty
          ? [{'question': 'No questions found for this chapter'}]
          : filteredQuestions;

    } else if (widget.source == 'pastPaper') {

      List filteredQuestions = []; //The function creates an empty list called filteredQuestions, which will be used to store the questions that match the chapterClicked.
      for (var question in allData) {   // It then iterates over each question in data using a for loop.
        //For each question, the function checks whether the chapterid field of that question matches the chapterClicked ID. If the two IDs match, the function prints out the chapterid and adds that question to the filteredQuestions list using the add() method.
        if (question['pastpaper'] != null && question['pastpaper']['_id'] == chapterClicked) {   // on the basis of Item name we do classification and filteration here
          filteredQuestions.add(question);
        }
      }
      return filteredQuestions.isEmpty
          ? [{'question': 'No questions found for this chapter'}]
          : filteredQuestions;

    }else {

      List filteredQuestions = []; //The function creates an empty list called filteredQuestions, which will be used to store the questions that match the chapterClicked.
      for (var question in allData) {   // It then iterates over each question in data using a for loop.
        //For each question, the function checks whether the chapterid field of that question matches the chapterClicked ID. If the two IDs match, the function prints out the chapterid and adds that question to the filteredQuestions list using the add() method.
        if (question['chapterid']['_id'] == chapterClicked) {
          filteredQuestions.add(question);
        }
      }
      return filteredQuestions.isEmpty
          ? [{'question': 'No questions found for this chapter'}]
          : filteredQuestions;

    }

  }

  @override
  Widget build(BuildContext context) {       // every time the Timer will use setState{} so this build method will be created again and again and same way the request to "Future" will also go that many times
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/appBackgroundImage/adjustedBgMcq.png"),
                    fit: BoxFit.fill
                ),
                // gradient: LinearGradient(
                //     begin: Alignment.topCenter,   // so the color will work from top to bottom
                //     end: Alignment.bottomCenter,
                //     colors: [blue,darkBlue]
                // ), //providing custom colors to gradient
              ),

              child: FutureBuilder(
                future: quiz,    // this variable stores the returned future response of the API from api_service class's getQuiz() function.
                builder: (context, snapshot) {

                  if(snapshot.hasData && snapshot.data != null) {

                    List<dynamic>? allData = snapshot.data["questionList"];   // "questionList" is a list inside the "data" Object of mcqsController class
                    print("number of questions in all data is : ${allData!.length}");
                    print("print data of questionList : ${allData.toString()}");

                    List filteredQuestions = filterQuestionsByChapterId(allData, widget.chapterClicked);

                    data = filteredQuestions;   // assigning the filteredQuestions List to "data" list with dataType "List<dynamic>?"

                    print("filtered list: ${filteredQuestions}");
                    print("filtered list length: ${filteredQuestions.length}");

                    if (isLoaded ==  false) {     // optionsList will update when "isLoaded == false" so after moving to next screen of questions you need to make "isLoaded = false"

                      //When you retrieve the data from the API, it is stored in a list named data.
                      //
                      // Since both currentQuestionIndex and data are in the same scope, you can use the currentQuestionIndex variable to access the corresponding data from the data list.
                      //
                      // So, when you write optionsList = data[currentQuestionIndex]["incorrect_answers"], it means that you are accessing the currentQuestionIndex-th element from the data list and then getting the value of the "incorrect_answers" key from that element.

                      //here we stored incorrect answers on "optionslist" and then added the correct anwer this way every fourth option will be correct one.
                      optionsList = data![currentQuestionIndex]["incorrect_answer"];
                      optionsList.add(data![currentQuestionIndex]["correct_answer"]);
                      // we need to shuffle the options list otherwise every fourth answer will be correct
                      optionsList.shuffle();

                      print("printing optionsList: ${optionsList.toString()}");

                      isLoaded = true;  // we have made isLoaded = true so that on Set State "if(snapshot.hasData) {}" doesn't execute again
                    }

                    return  Column(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Column(
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                          "Question ${ currentQuestionIndex + 1 } / ${data!.length}",  // assigning dynamic numbers to MCQS
                                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                              fontFamily: "quick_semi",
                                              color: Colors.white
                                          )
                                      ),
                                    ),

                                    Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Text(
                                              "$seconds",
                                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                  fontFamily: "quick_semi",
                                                  color: Colors.white
                                              )
                                          ),

                                          SizedBox(
                                            width: size.width * 0.09,
                                            height: size.width * 0.09,
                                            //By wrapping CircularProgressIndicator with Transform.scale, it will scale down the size of the CircularProgressIndicator by 10%, which will ensure that it fits perfectly inside the Container.
                                            child: Transform.scale(
                                              scale:0.9,
                                              child: CircularProgressIndicator(
                                                value: seconds/60,   // after every second the value will keep on decreasing
                                                strokeWidth: 5,
                                                backgroundColor: Colors.white.withOpacity(0.9),

                                                // if "isTimeRunningOut == true" ie; timer is <= 30 so change color to 'pink' otherwise keep it as stored in 'progressColor' which is yellow
                                                valueColor: AlwaysStoppedAnimation(isTimeRunningOut ? Colors.pink.shade400 : progressColor),
                                              ),
                                            ),
                                          )
                                        ]
                                    ),

                                  ],
                                ),

                                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                                Container(
                                  width: MediaQuery.of(context).size.width * 1.2.w,
                                  height: MediaQuery.of(context).size.height * 0.21.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 3.w,color: Colors.white,style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(16.r),
                                      shape: BoxShape.rectangle,
                                      color: Colors.transparent
                                  ),

                                  child:  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: SingleChildScrollView(
                                        child: Text(
                                            data![currentQuestionIndex]['question'],
                                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                fontFamily: "quick_semi",
                                                color: Colors.white,
                                                fontSize: size.width *0.040
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 5,),

                                Visibility(
                                  visible: currentQuestionIndex < data!.length - 1,    // on the last mcq this button will disappear
                                  child: InkWell(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: lightgrey, width: 2)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          child: Text(
                                              "Next",
                                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                  fontFamily: "quick_semi",
                                                  color: Colors.white
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      // If current question is not the last one
                                      if (currentQuestionIndex < data!.length - 1) {
                                        // Move to next question using the code in the 'goToNextQuestion();'
                                        goToNextQuestion();
                                      } else {
                                        // Navigate to results screen if you are at the last question
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ResultScreen(
                                              totalQuestions: data!.length,
                                              totalPoints: points,

                                              chapterClicked: widget.chapterClicked,
                                              screenTitle: widget.screenTitle,
                                              source: widget.source,        // source will be sent to the result screen so that we can recognize which class mcqs we are dealing with
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),

                                // LayoutBuilder(  //the LayoutBuilder widget gives us the available height and width of the parent widget through the BoxConstraints parameter
                                //   builder: (BuildContext context, BoxConstraints constraints) {   //We then use these constraints to set the height and width of the Container widget and make it responsive.
                                //     return Container(                              //The AspectRatio widget scales the image within the fixed space, and the fit property of the Image widget is set to BoxFit.cover to ensure that the image fills the available space.
                                //       height: constraints.maxWidth * 0.35,
                                //       width: constraints.maxWidth * 0.35,
                                //       child: AspectRatio(
                                //         aspectRatio: 16 / 9,
                                //         child: Image.asset(
                                //           ideas,
                                //           fit: BoxFit.cover,
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),

                              ],
                            )
                        ),

                        Expanded(
                          flex: 4,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Column(children: [

                                ListView.builder(       //'hasSize' error will be given if you don't use shrinkWrap bc listView.builder is used inside the Column() widget
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: optionsList.length,     // taking length of optionsList having correct and incorrect options
                                  itemBuilder: (context, index) {

                                    var answer = data![currentQuestionIndex]["correct_answer"];   //storing the correct Answer of current MCQ on answer

                                    /// "correctIndex" will be reinitialized each time the onTap function is called and the widget is rebuilt.
                                    int correctIndex;   //first find the index of the correct answer and store it in a variable then we use it to give red and green colors to "Options"

                                    //. IgnorePointer can be useful in cases where we want to temporarily disable interaction with a widget, such as during an animation or when waiting for some asynchronous operation to complete.
                                    // When IgnorePointer is set to true, its child widget is not clickable and cannot respond to any touch or pointer events.
                                    return SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.09,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          Container(
                                            margin: EdgeInsets.only(top: size.height * 0.01),
                                            alignment: Alignment.center,
                                            height: 35,
                                            width: 35,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xff004880),
                                            ),
                                            child: Text(
                                              String.fromCharCode('A'.codeUnitAt(0) + index), // get the ASCII code of 'A' and add the current index to get the next letter
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),

                                          IgnorePointer(   // "IgnorePointer" is used here to ensure that the user cannot select more than one option for the same question, which could lead to incorrect results.
                                            ignoring: !_isTapEnabled,   //"IgnorePointer" widget will be used to ignore pointer events (such as taps) if the "_isTapEnabled" variable is false.
                                            child: GestureDetector(

                                              onTap: () async{

                                                //_isTapEnabled = false;     // disable tapping on options until the next question is displayed

                                                correctIndex = optionsList.indexOf(answer); //first find the index of the correct answer and store it in a variable then we use it to give red and green colors to "Options"

                                                //The mounted property is a flag in the State object that indicates whether the widget is currently in the widget tree.
                                                // Here,  the mounted check is used to avoid calling setState on an unmounted widget.
                                                // If the widget has been removed from the tree (i.e., if mounted is false), calling setState could lead to errors or unexpected behavior. So, in short, the mounted check is used as a safety measure to ensure that setState is only called when it is safe to do so.
                                                if (mounted) {

                                                  setState(() {
                                                    _isTapEnabled = false;  // disable tapping on options until the next question is displayed
                                                    if (optionsList[index] == answer) { // if selected option is correct
                                                      optionsColor[index] = Colors.green;

                                                      points = points + 1;   // at each correct MCQ the "Points = 0" will be incremented by 1

                                                      /// check if the selected question is already in the list before adding it so as to avoid repetition
                                                      selectedMCQs.add({
                                                        "question": data![currentQuestionIndex]["question"],
                                                        "selected_option": optionsList[index],
                                                        "correct_option": answer,
                                                        "result": "correct",
                                                      });



                                                    } else { // selected option is wrong

                                                      //The for loop iterates over each option in the optionsList and checks whether the index of the option matches with the selected index or the correct index.
                                                      for (int i = 0; i < optionsList.length; i++) {
                                                        if (i == index) {                     // If the index matches with the selected index, it means that the user has selected this option, so it is marked as red.
                                                          optionsColor[i] = Colors.red;
                                                        } else if (i == correctIndex) {     //If the index matches with the correct index, it means that this option is the correct answer, so it is marked as green.
                                                          optionsColor[i] = Colors.green;
                                                        } else {                           // If neither of the above conditions are met, it means that this option is a wrong answer, so it is marked as red.
                                                          optionsColor[i] = Colors.white;  //// reset incorrect options to white
                                                        }
                                                      }

                                                      _vibrate();

                                                      selectedMCQs.add({
                                                        "question": data![currentQuestionIndex]["question"],
                                                        "selected_option": optionsList[index],
                                                        "correct_option": answer,
                                                        "result": "incorrect",
                                                      });

                                                    }

                                                    // this loop runs untill all are displayed to user
                                                    if(currentQuestionIndex < data!.length - 1) {     // we subtracted 1 from total number of questions "data.length" because if (currentQuestionIndex == data.length) then an error is shown "not in inclusive range" as 'currentQuestionIndex' starts from "0" and if "data.length = 20" then range is from "0 to 19" so on 20th index MCQ you will get error
                                                      timer!.cancel(); // // after I go to next Question so i want the timer to restart therefore i cancel it here as soon as an option is clicked
                                                      Future.delayed(Duration(milliseconds: 100), (){  // "Future.delay" function is used so that one second delay is observed before going to next screen
                                                        isLoaded = false;   // isLoaded is made false so that the options can be updated and displayed according to the next screen question as optionsList can only be displayed if {isLoaded == true}

                                                        // The "Duration(seconds: 1)" specifies the duration of delay before executing the callback function.
                                                        // When the option is Clicked so after waiting for 1 second, the callback function will be executed and the currentQuestionIndex variable will be incremented by 1 and colors of the Options Containers will be reset
                                                        currentQuestionIndex ++;       // the index of currentQuestion will keep incremented by 1 ++ until "data.length";

                                                        // Reset the flag ("isTimeRunningOut") and progress color when timer is finished due to selection of an MCQ
                                                        isTimeRunningOut = false;
                                                        progressColor = Colors.teal.shade300;

                                                        resetColors();
                                                        seconds = 60;      // we make the seconds variable equal to 60 again for next Question
                                                        startTimer();     // we restart the timer for next question

                                                        _isTapEnabled = true;   // After the user has selected an option and the app is ready to move to the next question, the _isTapEnabled variable is set back to true so that the user can click on the options for the next question.
                                                      });
                                                    } else {

                                                      timer!.cancel(); // after we reach the last MCQ then the timer will cancel for good

                                                      ////If there are no more questions remaining, the code saves the selected MCQs and navigates to the review screen, just like before.
                                                      saveSelectedMCQs(selectedMCQs);   // I moved the logic ie; sharedPreferences that requires asynchronous operations outside of the setState function because "setState" is not meant to be used asynchronously.

                                                      // navigate to result screen with total points and total number of questions along with chapter clicked and screenTitle

                                                      Get.off(()=>
                                                          ResultScreen(
                                                            totalQuestions: data!.length,
                                                            totalPoints: points,
                                                            chapterClicked: widget.chapterClicked,
                                                            screenTitle: widget.screenTitle,
                                                            source: widget.source,        // source will be sent to the result screen so that we can recognize which class mcqs we are dealing with
                                                          ),
                                                          transition: Transition.downToUp,duration: const Duration(milliseconds: 220),
                                                          preventDuplicates: true  //'preventDuplicates' parameter is set to true. This will prevent the user from going back to the previous screen by pressing the back button on the phone.
                                                      );


                                                    }

                                                  });

                                                }


                                              },

                                              child: Container(
                                                alignment: Alignment.center,
                                                width: size.width - 90,
                                                padding: EdgeInsets.all(5),
                                                margin: EdgeInsets.only(top: size.height * 0.01),
                                                decoration: BoxDecoration(
                                                  color: optionsColor[index],    // giving color to each MCQ based on "index" in 'optionsColor[]'
                                                  borderRadius: BorderRadius.circular(12),
                                                  border: Border.all(width: 2.5,color: const Color(0xff004880),style: BorderStyle.solid),
                                                ),
                                                child: Text(
                                                    optionsList[index].toString(),  // text inside all options from API
                                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                                        fontFamily: "quick_bold",
                                                        color: blue     // assigning custom color
                                                    )
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    );

                                    // to disable onTap listener
                                    setState(() {
                                      _isTapEnabled = false;
                                    });

                                    // to re-enable onTap listener after some time
                                    Future.delayed(Duration(seconds: 1)).then((_) {
                                      setState(() {
                                        _isTapEnabled = true;
                                      });
                                    });
                                  },
                                ),
                                const SizedBox(height: 40),

                                InkWell(
                                  onTap: () {
                                    handleFinishButtonPress();   // this function is called on click of 'Finish' button
                                  },
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: const Color( 0xff004880), width: 2)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                        child: Text(
                                            "Quit",
                                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                              fontFamily: "quick_semi",
                                              color: const Color(0xff004880),
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                )

                              ],),
                            ),
                          ),
                        ),

                      ],
                    );


                  }  else if(snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }else {
                    return const Center(
                      child:
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Color(0xff004880)),
                      ),

                    );

                  }

                },
              )
          ),
        )
    );
  }


  //................. all these below methods are called outside the build method...............

  void _vibrate() {
    // vibrate for 500 milliseconds
    Vibration.vibrate(duration: 500);
  }

  Future<void> saveSelectedMCQs(List<Map<String, dynamic>> selectedMCQs) async {
    SharedPreferences prefsList = await SharedPreferences.getInstance();    // saving the list to shared preferences when the user finishes attempting all the MCQs.
    if (selectedMCQs.isEmpty) { // if no mcqs are selected
      await prefsList.setString("selected_mcqs", "You didnot select any option for the MCQs");
    } else {
      await prefsList.setString("selected_mcqs", json.encode(selectedMCQs));  //  // We have used json.encode to convert the list to a JSON string and stored it in shared preferences with the key "selected_mcqs".
    }
  }

  void clearPrefsList() async {    //this method that clears the selected_mcqs key in the shared preferences and navigates the user to the home screen
    SharedPreferences prefsList = await SharedPreferences.getInstance();
    await prefsList.remove("selected_mcqs");
    print("printing prefsList after deleting its data: ${prefsList.getString("selected_mcqs")}");
  }

  void handleFinishButtonPress() {     // this function is called as soon as the user clicks 'Finish' button
    ////If there are no more questions remaining, the code saves the selected MCQs and navigates to the review screen, just like before.
    saveSelectedMCQs(selectedMCQs);   // I moved the logic ie; sharedPreferences that requires asynchronous operations outside of the setState function because "setState" is not meant to be used asynchronously.

    //This code below calculates the total number of correct answers by filtering the list of selected MCQs (selectedMCQs) based on the "result" field of each question.
    // The length property is then called on this new iterable to get the total count of correct answers. This count is assigned to the points variable.
    points = selectedMCQs.where((mcq) => mcq["result"] == "correct").length;

    showFinishConfirmationDialog(context);

  }

  void showFinishConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you want to Quit?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();

              },
            ),
            TextButton(
              child: Text("Finish"),
              onPressed: () {
                timer!.cancel();  // this here will cancel the timer ie; stop it

                Navigator.of(context).pop();

                //Navigate to the result screen

                Get.off(()=>
                    ResultScreen(
                      totalQuestions: data!.length,
                      totalPoints: points,
                      chapterClicked: widget.chapterClicked,
                      screenTitle: widget.screenTitle,
                      source: widget.source,        // source will be sent to the result screen so that we can recognize which class mcqs we are dealing with
                    ),
                    transition: Transition.downToUp,duration: const Duration(milliseconds: 220),
                    preventDuplicates: true  //'preventDuplicates' parameter is set to true. This will prevent the user from going back to the previous screen by pressing the back button on the phone.
                );


              },
            ),
          ],
        );
      },
    );
  }

  void goToNextQuestion() {       // this function will skip the current question and go to Next question

    if (currentQuestionIndex < data!.length - 1) {
      timer!.cancel();

      setState(() {
        isLoaded = false;
        currentQuestionIndex++;
        resetColors();
        seconds = 60;
        startTimer();
        _isTapEnabled = true;
      });

    }
  }





}
