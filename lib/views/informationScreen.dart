import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class informationScreen extends StatefulWidget {
  const informationScreen({Key? key}) : super(key: key);

  @override
  State<informationScreen> createState() => _informationScreenState();
}

class _informationScreenState extends State<informationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        backgroundColor: Color(0xff004880),

        body: Stack(
          children: [
            Positioned(
              top: 7,
              right: 15,

              child:  Container(
                width: 56,
                height: 57,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  "assets/logos/splashScreenLogo.svg",
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),

            Column(
                children:[

                  Expanded(
                    flex: 3,

                    child: ClipPath(

                        clipper: MyCustomClipper(),           //Customized Methdd called to implement the bezier curve

                        child: Container(
                          color: Colors.white,
                          // height: 414.26,      // without Flex property this height and width is appropriate
                          // width: 310.44,

                          child: Stack(
                            children: [

                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      spacing: -12,     // using wrap() widget to reduce spacing between icons
                                      children: [
                                        IconButton(
                                          onPressed: (){
                                            print("working");
                                          },

                                          icon: InkWell(
                                            onTap: () {Get.back();},
                                              child: Icon(Icons.arrow_back, color: Color(0xff004880),)
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),

                              Positioned(         // instead of Position widget you can use Expanded widget in the Column() before Image.asset
                                                  // thus Expanded() will occupy all space and the image of HeadsetGirl will attach to base of white Container
                                  left: 73.w,
                                  bottom: 22.h,
                                  child: Image.asset("assets/HeadsetGirl.png",)
                                  // assets/logos/HeadsetGirl2.svg    ----> SVG image
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
                    child: Container(
                      // color: Color(0xff004880),    // color copied from "Adobe XD"
                      width: MediaQuery.of(context).size.width,

                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 23.h),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Container(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: MediaQuery.of(context).size.width * 0.62,

                                  child: Text("If you have any",textAlign: TextAlign.center, style: TextStyle(         fontSize: 18.5,           height: 1.5 , fontWeight: FontWeight.w500,   color: Color(0xFFE0F2F1),)),
                                ),

                                Container(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: MediaQuery.of(context).size.width * 0.62,

                                  child: Text("questions or suggestions",textAlign: TextAlign.center, style: TextStyle(         fontSize: 18.5,           height: 1.5 , fontWeight: FontWeight.w500,   color: Color(0xFFE0F2F1),)),
                                ),

                                Container(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: MediaQuery.of(context).size.width * 0.62,

                                  child: Text("or feedback",textAlign: TextAlign.center, style: TextStyle(         fontSize: 18.5,           height: 1.5 , fontWeight: FontWeight.w500,   color: Color(0xFFE0F2F1),)),
                                ),

                                Container(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: MediaQuery.of(context).size.width * 0.62,

                                  child: Text("about our app",textAlign: TextAlign.center, style: TextStyle(         fontSize: 18.5,           height: 1.5 , fontWeight: FontWeight.w500,   color: Color(0xFFE0F2F1),)),
                                ),

                                Container(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  width: MediaQuery.of(context).size.width * 0.62,

                                  child: Text("do not hesitate to",textAlign: TextAlign.center, style: TextStyle(         fontSize: 18.5,           height: 1.5 , fontWeight: FontWeight.w500,   color: Color(0xFFE0F2F1),)),
                                ),

                                Container(
                                  height: MediaQuery.of(context).size.height * 0.04,
                                  width: MediaQuery.of(context).size.width * 0.62,

                                  child: Text("contact us at",textAlign: TextAlign.center, style: TextStyle(         fontSize: 18.5,           height: 1.5 , fontWeight: FontWeight.w500,   color: Color(0xFFE0F2F1),)),
                                ),

                                Container(
                                  height: MediaQuery.of(context).size.height * 0.07,
                                  width: MediaQuery.of(context).size.width * 0.75,

                                  margin: EdgeInsets.only(top: 30),
                                  child: Text("steamminds.apps@gmail.com",textAlign: TextAlign.center, style: TextStyle(         fontSize: 18.5,           height: 1.5 , fontWeight: FontWeight.w500,   color: Colors.lightBlueAccent,)),
                                ),


                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ]
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
  Path getClip(Size size) {          // Getter method

    Path path = Path();              // Creating an instance for Path

/*
              // this way a complete imaginary path is drawn around the end points of a container
    path.lineTo(0, 0);                      // TopLeft Corner     [By default the container starts to draw line from this point where Width (x) = 0 & Height (y) = 0]
    path.lineTo(0, size.height);            // BottomLeft Corner  [then line goes toward Width (x) = 0 & Height (y) = size.height (max height)]
    path.lineTo(size.width, size.height);   // BottomRight Corner [Next line goes toward Width (x) = size.width & Height (y) = size.height (max height from top down)]
    path.lineTo(size.width, 0);             // TopRight Corner    [Finaly goes toward the last Point where Width (x) = size.width (max) & Height (y) = 0 (Because height is considered from top to bottom not from bottom to top)]
*/

    path.lineTo(0.0, size.height - 60);  //Bringing the control to starting point of the curve by mentioning the second point of contianer and by default the cursor draw a line from starting point to this point

    // Control Points are the Crest and Trough of the curve
    var firstControlPoint = Offset(size.width/100, size.height - 24);
    var firstEndPoint = Offset(size.width/8, size.height - 24);          // Middle point of the curve
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);   // ... We must write the ControlPoints first then the EndPoints

    var secondControlPoint = Offset(size.width - (size.width /4), size.height - 24);   // ... dividing the width into 3.25 parts so as to get the width of one part then subtracting that one part from total width so that we can reach the secondControlPoint
    var secondEndPoint = Offset(size.width - (size.width /4), size.height -24);                 // This endPoint is mentioned for the Curve while the {{ path.lineTo(size.width, size.height - 40); }} is mentioned below to complete the path
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint = Offset(size.width - (size.width /4) + 70, size.height - 24);
    var thirdEndPoint = Offset(size.width - (size.width /4) + 70, size.height - 24);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy, thirdEndPoint.dx, thirdEndPoint.dy);

    var fourthControlPoint = Offset(size.width - (size.width /4) + 96, size.height -24);
    var fourthEndPoint = Offset(size.width , size.height);
    path.quadraticBezierTo(fourthControlPoint.dx, fourthControlPoint.dy, fourthEndPoint.dx, fourthEndPoint.dy);

    path.lineTo(size.width, size.height /3 + 20);   // drawing line near to TopRight corner

    //............Now taking Points Control and EndPoints for curve in the TopRight Corner..................
    var fifthControlPoint = Offset(size.width - 10, size.height / 3 - 10);
    var fifthEndPoint = Offset(size.width - 43, size.height /3 - 10);
    path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy, fifthEndPoint.dx, fifthEndPoint.dy);

    var sixthControlPoint = Offset(size.width - 55, size.height / 3 - 10 );
    var sixthEndPoint = Offset(size.width - 57, size.height /3 - 10);
    path.quadraticBezierTo(sixthControlPoint.dx, sixthControlPoint.dy, sixthEndPoint.dx, sixthEndPoint.dy);

    var seventhControlPoint = Offset(size.width - 92, size.height / 3 - 6);
    var seventhEndPoint = Offset(size.width - 92, size.height /4 - 27);
    path.quadraticBezierTo(seventhControlPoint.dx, seventhControlPoint.dy, seventhEndPoint.dx, seventhEndPoint.dy);


    var EigthControlPoint = Offset(size.width - 92, size.height / 4);
    var EigthEndPoint = Offset(size.width - 92, size.height / 4 - 34);
    path.quadraticBezierTo(EigthControlPoint.dx, EigthControlPoint.dy, EigthEndPoint.dx, EigthEndPoint.dy);

    var ninthControlPoint = Offset(size.width - 92, size.height / 4 - 34);
    var ninthEndPoint = Offset(size.width - 92, size.height / 4 + 6);
    path.quadraticBezierTo(ninthControlPoint.dx, ninthControlPoint.dy, ninthEndPoint.dx, ninthEndPoint.dy);


    var tenthControlPoint = Offset(size.width - 86, size.height / 4 - 60);
    var tenthEndPoint = Offset(size.width - 110 , 0.0);
    path.quadraticBezierTo(tenthControlPoint.dx, tenthControlPoint.dy, tenthEndPoint.dx, tenthEndPoint.dy);





    // Paths must be completed for the imaginary line from start till the end

    path.lineTo(size.width, 0.0);    // Drawing till TopRightCorner
    path.close();       // closing the container by reaching the starting point again


    return path;                  // returns the path you want to draw on the container
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper)
  {
    return true;               // ..............  this true and false purpose is still unclear to me
  }

}

