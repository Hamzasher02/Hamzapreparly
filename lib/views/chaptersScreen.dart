import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../components/AppDrawer.dart';
import '../components/smallwhitecontainer.dart';
import '../controllers/chaptersController.dart';
import '../models/chaptersModel.dart';
import '../size_config.dart';
import 'McqsPdfsVideosScreen.dart';


class ChaptersScreen extends StatefulWidget {

  final String subjectClicked;         // these variables here are called using "widget."
  final String bannerName;
  final String bannerFullName;
  final String chapterLabelImage;

  const ChaptersScreen({Key? key,
    required this.subjectClicked,
    required this.bannerName,
    required this.bannerFullName,
    required this.chapterLabelImage
  }) : super(key: key);

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {

  ChaptersController chaptersController = Get.put(ChaptersController());

  late RxList<ChaptersModel> myChapters;

  @override
  void initState() {
    super.initState();

   myChapters = RxList<ChaptersModel> ([]); //initializing 'myChapters' list

    ever(chaptersController.chaptersList, (_) {
      myChapters.assignAll(
          chaptersController.chaptersList.where((chapterObj) =>
          chapterObj.subjectid!.id == widget.subjectClicked).toList()
      );
      printFilteredSubjects();
    });
  }

  void printFilteredSubjects() {
    print("printing list of my filtered subjects(mySubjects) in SubjectsScreen:");
    for (var chapter in myChapters) {
      print("Subject ID: ${chapter.id}, Name: ${chapter.name}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: Color(0xff004880),        // By deafault this color is assigned to the curved area as well
      body: SafeArea(
        child: Stack(
          children: [
            // Positioned(
            //   top: 7.5,
            //   right: 13,
            //   child: FittedBox(
            //     fit: BoxFit.cover,
            //     child: Container(
            //       width: 51.w,
            //       height: 52.h,
            //       decoration: const BoxDecoration(
            //           borderRadius: BorderRadius.all(Radius.circular(10)),
            //           color: Colors.white
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.all(3.0),
            //         child: SvgPicture.asset(
            //           "assets/logos/splashScreenLogo.svg",
            //           fit: BoxFit.scaleDown,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            Column(
                children:[

                  Expanded(
                    flex: 2,

                    child: Container(

                      decoration: BoxDecoration(
                          color: Color(0xff004880),
                          image: DecorationImage(
                            image: AssetImage('assets/appBackgroundImage/curveContainerWhite4.png'),
                            fit: BoxFit.fill,
                          )
                      ),
                      // height: 414.26,      // without Flex property this height and width is appropriate
                      // width: 310.44,

                      child: Column(
                        children: [

                          Builder(
                            builder: (context) {
                              return Container(
                                height: MediaQuery.of(context).size.width * 0.1,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      spacing: -12,     // using wrap() widget to reduce spacing between icons
                                      children: [

                                        IconButton(
                                          onPressed: (){
                                            Scaffold.of(context).openDrawer();
                                          },

                                          icon: Icon(Icons.menu, color: Color(0xff004880),),
                                        ),


                                        IconButton(

                                          onPressed: (){
                                            //print("notification working");

                                            print("printing each item of chaptersList in chaptersScreen:");
                                            for(var chapter in chaptersController.chaptersList) {
                                              print("chapter ID: ${chapter.id}, chapter Name: ${chapter.name}");
                                            }

                                            },

                                          icon: Icon(Icons.notifications, color: Color(0xff004880),),
                                        ),

                                      ],
                                    ),

                                  ],
                                ),
                              );
                            },
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                  width: 140.w,
                                  height: 140.h,
                                  padding: EdgeInsets.only(left: 26.w),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.w),
                                    child: Image.network(
                                      widget.chapterLabelImage,
                                       fit: BoxFit.cover,
                                 //     scale: 1.3,
                                    ),
                                  ),
                                ),

                                Container(
                                  width: 170.w,
                                  height: 125.h,
                                  margin: EdgeInsets.only(left: 20.w, bottom: 30.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: FittedBox(
                                              child: Text(
                                                widget.bannerName, maxLines: 2, overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                    color: Color(0xff004880,),
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.2,
                                                    fontSize: MediaQuery.of(context).size.width * 0.08,
                                                ),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),

                                      Container(margin: EdgeInsets.only(top: 3.h,bottom: 2.h),width: 170.w, height: 2.h, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20.r)),),

                                      Row(
                                        children: [
                                          //writing multiLine Text
                                          Flexible(
                                            child: FittedBox(
                                              fit: BoxFit.cover,
                                              child: RichText(   // before displaying the Cards of videos we will add some text in the body above so that we can define which section it is
                                                maxLines: 3, // Set the maximum number of lines to 2
                                                overflow: TextOverflow.ellipsis, // If the text overflows, show an ellipsis at the end
                                                text: TextSpan(style: Theme.of(context).textTheme.bodyLarge,
                                                  children: [
                                                    TextSpan(
                                                        text: '''Please Select\nany Topic\nfrom ''',
                                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                            color: const Color(0xff004880,),
                                                          letterSpacing: 1.2,
                                                          fontSize: MediaQuery.of(context).size.width * 0.036,
                                                        )
                                                    ),

                                                     TextSpan(
                                                         text: widget.bannerFullName,
                                                       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                           color: const Color(0xff004880), letterSpacing: 1.2, fontWeight: FontWeight.bold
                                                       )
                                                     ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],),

                    ),
                  ),
/*
Note: Flex property divides screen into 4+2 = 6 parts then assign parts to each container accordingly
*/
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      child: Container(
                        width: 430,

                        child: Obx(
                                () => chaptersController.isLoading.value
                                    ?  chaptersShimmerItem()

                                : myChapters.isEmpty? Padding(
                                  padding: EdgeInsets.only(top: SizeConfig.defaultSize * 10),
                                  child: Center(
                                    child: Text("Chapters will be added soon",style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16
                                    ),),
                                  ),
                                )

                                    : ListView.builder (
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: myChapters.length ?? 0,
                                  itemBuilder: (BuildContext context, int index) {
                                    ChaptersModel chaptersObj = myChapters[index];

                                    print("Filtered list of chapters creating is: ${chaptersObj.name.toString()}");

                                    return GestureDetector(
                                      onTap: (){
                                        String chapterId = chaptersObj.id!;
                                        String mcqsScreenTiltle = chaptersObj.name!;

                                        print("printing chapter clicked ${chaptersObj.id!}");

                                        Get.to( ()=> McqsPdfsVideosScreen(screenTitle: mcqsScreenTiltle, chapterClicked: chapterId,),  transition: Transition.downToUp,duration: const Duration(milliseconds: 220));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: SmallWhiteContainer(
                                            image: chaptersObj.chapterPic!,
                                            text: chaptersObj.name!,
                                        ),
                                      ),
                                    );
                                    },

                                )
                      ),
                    ),
                  )
                  )
                ]
            ),

          ],
        ),
      ),
    );
  }
}

class chaptersShimmerItem extends StatelessWidget {
  const chaptersShimmerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
     physics: const BouncingScrollPhysics(),
      child: Column(
       children: [
        Padding(
         padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
         child: Container(
          height: MediaQuery.of(context).size.width * 0.16,
          width: MediaQuery.of(context).size.width -35,
          margin: EdgeInsets.only(top: 20.h,),    // creates distance between two widgets
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.white,
          ),

          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 84.h,
                  width: 84.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                    ),
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2.3.w,
                      height: 15,
                      margin: EdgeInsets.only(left: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4,),
                    Container(
                      width: MediaQuery.of(context).size.width/2.3.w,
                      height: 15,
                      margin: EdgeInsets.only(left: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15,),
        child: Container(
          height: MediaQuery.of(context).size.width * 0.16,
          width: MediaQuery.of(context).size.width -35,
          margin: EdgeInsets.only(top: 20.h,),    // creates distance between two widgets
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.white,
          ),

          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 84.h,
                  width: 84.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                    ),
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2.3.w,
                      height: 15,
                      margin: EdgeInsets.only(left: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4,),
                    Container(
                      width: MediaQuery.of(context).size.width/2.3.w,
                      height: 15,
                      margin: EdgeInsets.only(left: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Container(
          height: MediaQuery.of(context).size.width * 0.16,
          width: MediaQuery.of(context).size.width -35,
          margin: EdgeInsets.only(top: 20.h,),    // creates distance between two widgets
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.white,
          ),

          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 84.h,
                  width: 84.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                    ),
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2.3.w,
                      height: 15,
                      margin: EdgeInsets.only(left: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4,),
                    Container(
                      width: MediaQuery.of(context).size.width/2.3.w,
                      height: 15,
                      margin: EdgeInsets.only(left: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: Container(
          height: MediaQuery.of(context).size.width * 0.16,
          width: MediaQuery.of(context).size.width -35,
          margin: EdgeInsets.only(top: 20.h,),    // creates distance between two widgets
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.white,
          ),

          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 84.h,
                  width: 84.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                    ),
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2.3.w,
                      height: 15,
                      margin: EdgeInsets.only(left: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4,),
                    Container(
                      width: MediaQuery.of(context).size.width/2.3.w,
                      height: 15,
                      margin: EdgeInsets.only(left: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    ],
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

