import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:lottie/lottie.dart';
import 'package:preparely/views/review_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/colors.dart';
import 'McqsPdfsVideosScreen.dart';
import 'mockTestScreen.dart';

class ResultScreen extends StatefulWidget {
  final String chapterClicked;    //  -----> compared with "pdfList.chapterid.id"
  final String screenTitle;
  final String? source;


  final int totalQuestions;
  final int totalPoints;

  ResultScreen({
    Key? key,
    required this.totalQuestions,
    required this.totalPoints,
    required this.chapterClicked,
    required this.screenTitle,
    this.source
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {


  Future<LottieBuilder> _loadGoodPerformance() async {
    return Lottie.asset(
        'assets/lottie/wellDone.json',
        repeat: true,
        fit: BoxFit.cover
    );
  }

  Future<LottieBuilder> _loadPoorPerformance() async {
    return Lottie.asset(
        'assets/lottie/ohNo.json',
        //  height: 150,
        repeat: true,
        fit: BoxFit.cover
    );
  }

  // this code can be used to load sound effect

  // Future<void> loadFile() async {
  //   String fileAssetPath = 'packages/myapp/raw/correct.mp3';
  //   final ByteData fileData = await rootBundle.load(fileAssetPath);
  //   final List<int> fileBytes = fileData.buffer.asUint8List();
  //   // Do something with the file bytes
  // }

  void clearPrefsList() async {    //this method that clears the selected_mcqs key in the shared preferences and navigates the user to the home screen
    SharedPreferences prefsList = await SharedPreferences.getInstance();
    await prefsList.remove("selected_mcqs");
    print("printing prefsList after deleting its data: ${prefsList.getString("selected_mcqs")}");
  }

  @override
  Widget build(BuildContext context) {
    final double scorePercentage = widget.totalPoints / widget.totalQuestions * 100;
    final String message =
    scorePercentage >= 60 ? "Congratulations!" : "Better luck next time";

    var size = MediaQuery.of(context).size;

    //Note: that the onBackPressed method is part of the WillPopScope widget, so you'll need to wrap your screen with a WillPopScope widget to override this method:
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color( 0xff004880),
          title: Text("Result Screen",),
          automaticallyImplyLeading: false, // set this property to false to remove the default back arrow

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
              icon: Icon(Icons.close,size: 26,),
            ),
          ],
        ),

        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  height: scorePercentage >= 60 ? 150 : 150,
                  width: scorePercentage >= 60 ? 150 : 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color : scorePercentage >= 60 ? Colors.green.withOpacity(0.6) : Colors.red.withOpacity(0.6),
                    border: Border.all(width: 2, color: Colors.white),
                  ),
                  child: Center(
                    child: FutureBuilder<LottieBuilder> (
                      future: scorePercentage >= 60 ? _loadGoodPerformance() : _loadPoorPerformance(),
                      builder: (BuildContext context, AsyncSnapshot<LottieBuilder> snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data!;
                        }
                        else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Text(
                  scorePercentage >= 60 ? "Congratulations!" : "Best of luck next time",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "${widget.totalPoints} / ${widget.totalQuestions}",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 30),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return  ReviewScreen(
                          screenTitle: widget.screenTitle,
                          chapterClicked: widget.chapterClicked,
                          source: widget.source,        // source will be sent to the result screen so that we can recognize which class mcqs we are dealing with
                        );
                      },));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width - 100,
                      padding: EdgeInsets.all(18),
                      margin: EdgeInsets.only(bottom: size.height * 0.03),
                      decoration: BoxDecoration(
                          color: const Color( 0xff004880),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Text(
                          "Review",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontFamily: "quick_bold",
                              color: Colors.white     // assigning custom color
                          )
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

}

