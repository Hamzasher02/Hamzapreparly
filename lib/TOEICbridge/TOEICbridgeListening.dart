import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/McqsPdfsVideosSmallContainer.dart';
class TOEICbridgeListening extends StatefulWidget {
  const TOEICbridgeListening({Key? key}) : super(key: key);

  @override
  State<TOEICbridgeListening> createState() => _TOEICbridgeListeningState();
}

class _TOEICbridgeListeningState extends State<TOEICbridgeListening> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: 7.h,
              right: 19.w,

              child: Container(
                width: MediaQuery.of(context).size.width * 0.19.w,
                height: MediaQuery.of(context).size.width * 0.19.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Image.asset("assets/PreparelySmallLogo.png"),
              ),
            ),

            Column(
              children:[

                Expanded(
                  flex: 2,

                  child: ClipPath(

                      clipper: MyCustomClipper(),           //Customized Methdd called to implement the bezier curve

                      child: Container(

                        color: Color(0xff004880),
                        // height: 235,      // without Flex property this height and width is appropriate
                        // width: 411,
                        child: Stack(
                          children: [

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  spacing: -19,     // using wrap() widget to reduce spacing between icons
                                  children: [
                                    IconButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },

                                      icon: Icon(Icons.arrow_back, color: Colors.white,),
                                    ),

                                    IconButton(

                                      onPressed: (){print("notification working");},

                                      icon: Icon(Icons.notifications, color: Colors.white,),
                                    ),

                                  ],
                                ),

                              ],
                            ),

                            Positioned(
                                top: MediaQuery.of(context).size.height * 0.02.h,
                                left: MediaQuery.of(context).size.width * 0.32.w,
                                child:  Image.asset("assets/TOEIClogo.png",height: MediaQuery.of(context).size.width * 0.43.h,width: MediaQuery.of(context).size.width * 0.42.w)),

                            Positioned(
                                top: 196.h,
                                left: 50.w,
                                child: Container(margin: EdgeInsets.only(top: 5.h,bottom: 4.h),width: 330.w, height: 5.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r)),)
                            ),

                            Positioned(
                              top: 209.h,
                              left: 50.w,
                              child: Text('''Listening''',
                                style: TextStyle(fontSize: 20.sp, color: Colors.white),),
                            ),
                          ],),

                      )
                  ),
                ),
/*
Note: Flex property divides screen into 4+2 = 6 parts then assign parts to each container accordingly
*/

                Expanded(
                    flex: 4,

                    child: SingleChildScrollView(
                      child: Column(

                        children: [

                          Container(
                            height: 50,
                            width: 340,
                            child: Text("Get your self prepared for the exams\nthrough video lessons, pdfs and Mcqs\nfor this chanpter.",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black38,),),
                          ),

                          SizedBox(height: 0.1),

                          Column(
                            children: [
                              McqsPdfsVideosSmallContainer(image: 'assets/mcqs.png',  text: "MCQS",   onPress: (){} ),
                              McqsPdfsVideosSmallContainer(image: 'assets/pdf.png',   text: "PDFS" ,  onPress: (){} ),
                              McqsPdfsVideosSmallContainer(image: 'assets/videos.png',text: "VIDEOS", onPress: (){} ),
                            ],
                          )
                        ],
                      ),
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}












// Defining "MyCustomClipper" class to draw 'bazier curve'

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Getter method

    Path path = Path(); // Creating an instance for Path

/*
              // this way a complete imaginary path is drawn around the end points of a container
    path.lineTo(0, 0);                      // TopLeft Corner     [By default the container starts to draw line from this point where Width (x) = 0 & Height (y) = 0]
    path.lineTo(0, size.height);            // BottomLeft Corner  [then line goes toward Width (x) = 0 & Height (y) = size.height (max height)]
    path.lineTo(size.width, size.height);   // BottomRight Corner [Next line goes toward Width (x) = size.width & Height (y) = size.height (max height from top down)]
    path.lineTo(size.width, 0);             // TopRight Corner    [Finaly goes toward the last Point where Width (x) = size.width (max) & Height (y) = 0 (Because height is considered from top to bottom not from bottom to top)]
*/

    path.lineTo(
        0.0,
        size.height -
            60); //Bringing the control to starting point of the curve by mentioning the second point of contianer and by default the cursor draw a line from starting point to this point

    // Control Points are the Crest and Trough of the curve
    var firstControlPoint = Offset(size.width / 100, size.height - 24);
    var firstEndPoint =
    Offset(size.width / 8, size.height - 24); // Middle point of the curve
    path.quadraticBezierTo(
        firstControlPoint.dx,
        firstControlPoint.dy,
        firstEndPoint.dx,
        firstEndPoint
            .dy); // ... We must write the ControlPoints first then the EndPoints

    var secondControlPoint = Offset(
        size.width - (size.width / 4),
        size.height -
            24); // ... dividing the width into 3.25 parts so as to get the width of one part then subtracting that one part from total width so that we can reach the secondControlPoint
    var secondEndPoint = Offset(
        size.width - (size.width / 4),
        size.height -
            24); // This endPoint is mentioned for the Curve while the {{ path.lineTo(size.width, size.height - 40); }} is mentioned below to complete the path
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint =
    Offset(size.width - (size.width / 4) + 70, size.height - 24);
    var thirdEndPoint =
    Offset(size.width - (size.width / 4) + 70, size.height - 24);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    var fourthControlPoint =
    Offset(size.width - (size.width / 4) + 96, size.height - 24);
    var fourthEndPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(fourthControlPoint.dx, fourthControlPoint.dy,
        fourthEndPoint.dx, fourthEndPoint.dy);

    path.lineTo(size.width,
        size.height / 3 + 20); // drawing line near to TopRight corner

    //............Now taking Points Control and EndPoints for curve in the TopRight Corner..................
    var fifthControlPoint = Offset(size.width - 10, size.height / 3 - 10);
    var fifthEndPoint = Offset(size.width - 43, size.height / 3 - 10);
    path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy,
        fifthEndPoint.dx, fifthEndPoint.dy);

    var sixthControlPoint = Offset(size.width - 55, size.height / 3 - 10);
    var sixthEndPoint = Offset(size.width - 57, size.height / 3 - 10);
    path.quadraticBezierTo(sixthControlPoint.dx, sixthControlPoint.dy,
        sixthEndPoint.dx, sixthEndPoint.dy);

    var seventhControlPoint = Offset(size.width - 92, size.height / 3 - 6);
    var seventhEndPoint = Offset(size.width - 92, size.height / 4 - 27);
    path.quadraticBezierTo(seventhControlPoint.dx, seventhControlPoint.dy,
        seventhEndPoint.dx, seventhEndPoint.dy);

    var EigthControlPoint = Offset(size.width - 92, size.height / 4);
    var EigthEndPoint = Offset(size.width - 92, size.height / 4 - 34);
    path.quadraticBezierTo(EigthControlPoint.dx, EigthControlPoint.dy,
        EigthEndPoint.dx, EigthEndPoint.dy);

    var ninthControlPoint = Offset(size.width - 92, size.height / 4 - 34);
    var ninthEndPoint = Offset(size.width - 92, size.height / 4 + 6);
    path.quadraticBezierTo(ninthControlPoint.dx, ninthControlPoint.dy,
        ninthEndPoint.dx, ninthEndPoint.dy);

    var tenthControlPoint = Offset(size.width - 86, size.height / 4 - 60);
    var tenthEndPoint = Offset(size.width - 110, 0.0);
    path.quadraticBezierTo(tenthControlPoint.dx, tenthControlPoint.dy,
        tenthEndPoint.dx, tenthEndPoint.dy);

    // Paths must be completed for the imaginary line from start till the end

    path.lineTo(size.width, 0.0); // Drawing till TopRightCorner
    path.close(); // closing the container by reaching the starting point again

    return path; // returns the path you want to draw on the container
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true; // ..............  this true and false purpose is still unclear to me
  }
}
