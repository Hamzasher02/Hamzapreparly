import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class simpleBlueWhiteScreen extends StatefulWidget {
  const simpleBlueWhiteScreen({Key? key}) : super(key: key);

  @override
  State<simpleBlueWhiteScreen> createState() => _simpleBlueWhiteScreenState();
}

class _simpleBlueWhiteScreenState extends State<simpleBlueWhiteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea( // SafeArea will bring all the rows at a safe distance from eachother
      child: Scaffold(
        backgroundColor: Colors.white,        // By deafault this color is assigned to the curved area as well
        body: Column(
            children:[
              Expanded(
                  flex: 3,

                  child: ClipPath(

                      clipper: MyCustomClipper(),           //Customized Methdd called to implement the bezier curve

                      child: Container(

                        color: Color(0xff004880),
                        // height: 414.26,      // without Flex property this height and width is appropriate
                        // width: 310.44,

                        child: Column(
                          children: [

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Container(
                                    margin: EdgeInsets.only(top: 15.h, left: 33.w),
                                    child: Text("Question  /", style: TextStyle(color: Colors.white, fontSize: 22.sp),)
                                ),

                                Wrap(
                                  spacing: MediaQuery.of(context).size.width/2.4.w,     // using wrap() widget to reduce spacing between icons
                                  children: [

                                    IconButton(

                                      onPressed: (){print("notification working");},

                                      icon: Icon(Icons.notifications, color: Colors.white,),
                                    ),

                                    IconButton(
                                      onPressed: (){
                                        print("No further screens");
                                      },

                                      icon: Icon(Icons.arrow_forward, color: Colors.white,),
                                    ),
                                  ],
                                ),

                              ],
                            ),

                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 25.w,right: 25.w, top: 14.h),
                                  width: MediaQuery.of(context).size.width * 1.2.w,
                                  height: MediaQuery.of(context).size.width * 0.6.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 3.w,color: Colors.white,style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(16.r),
                                      shape: BoxShape.rectangle,
                                      color: Color(0xff004880)
                                  ),
                                ),
                                Positioned(
                                  top: 1.h,
                                  right: 18.w,
                                  height: 70.h,
                                  width: 70.w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                    ),
                                    child: Image.asset("assets/CircularSetting.png"),
                  ),
              ),

                                Positioned(
                                  top: 195.h,
                                  right: 33.w,
                                  child: Text("Quit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 21.sp),),
                                ),

                              ] ,
                            ),
                          ],),

                      )
                  )
              ),
/*
Note: Flex property divides screen into 4+2 = 6 parts then assign parts to each container accordingly
*/
              Expanded(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.only(top: 30.h),
                  width: MediaQuery.of(context).size.width.w / 1.2,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: CircleAvatar(
                          maxRadius: 21.r,
                          backgroundColor: Color(0xff004880),
                          child: Text("A", style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w500),),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 45.h),

                        child: CircleAvatar(
                          maxRadius: 21.r,
                          backgroundColor: Color(0xff004880),
                          child: Text("B", style: TextStyle(color: Colors.white, fontSize: 20.h, fontWeight: FontWeight.w500),),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 45.h),

                        child: CircleAvatar(
                          maxRadius: 21.r,
                          backgroundColor: Color(0xff004880),
                          child: Text("C", style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w500),),
                        ),
                      ),


                      Container(
                        margin: EdgeInsets.only(top: 45.h),

                        child: CircleAvatar(
                          maxRadius: 21.r,
                          backgroundColor: Color(0xff004880),
                          child: Text("D", style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w500),),
                        ),
                      ),

                    ],
                  ),
                ),
              )
            ]
        ),
      ),
    );
  }
}




// Defining "MyCustomClipper" class to draw 'bazier curve'
//This bezier curve is different ie; it has no curve at the top Right corner

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
