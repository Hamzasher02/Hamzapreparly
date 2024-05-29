import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../components/AppDrawer.dart';
import '../components/GeneralContainer.dart';
import '../controllers/subjectsController.dart';
import '../models/subjectsModel.dart';
import '../size_config.dart';
import 'chaptersScreen.dart';


class SubjectsScreen extends StatefulWidget {

  final String subCategClickedId;   // on the basis of this id passed here we will display the results of subjects after searching in the API.
   final String bannerName;
   final String bannerFullName;
   final String labelImage;

   SubjectsScreen({Key? key,
    required this.subCategClickedId,
    required this.bannerName,
    required this.bannerFullName,
     required this.labelImage
  }) : super(key: key);

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();  // This global key is very important to use the refresh screen


  SubjectsController subjectsController = Get.put(SubjectsController());

  late RxList<SubjectsModel> mySubjects;

  @override
  void initState() {
    super.initState();
    mySubjects = RxList<SubjectsModel> ([]);   //initializing 'myChapters' list
    // Listen to changes in subjectsController.subjectsList
    //Whenever "subjectsController.subjectsList" changes, the 'ever' function is called, which filters the list based on "subCategClickedId" and assigns the filtered list to "mySubjects".
    // This ensures that "mySubjects" is always up-to-date with the latest data from "subjectsController.subjectsList".
    ever(subjectsController.subjectsList, (_) {
      //when subjectsList changes, filter it based on subCategClickedId
      //'subjectObj' is declared here as the object of Model Class (SubjectsModel)
      mySubjects.assignAll(
        subjectsController.subjectsList.where((subjectObj) => subjectObj.catagoryid!.id == widget.subCategClickedId).toList());
      printFilteredSubjects();
    });
  }

  void printFilteredSubjects() {
    print("printing list of my filtered subjects(mySubjects) in SubjectsScreen:");
    for (var subject in mySubjects) {
      print("Subject ID: ${subject.id}, Name: ${subject.name}, subjectbanner: ${subject.subjectbanner}, status: ${subject.slug}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () async {
        await Future.wait([
          subjectsController.refresh(), // Refresh GridViewController
          // bannerController.refresh(),   // Refresh BannerController
        ]);
      },
      child: Scaffold(
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

                                              print("printing each item of subjectsList in SubjectsScreen:");
                                              for (var subject in subjectsController.subjectsList) {
                                                print("Subject ID: ${subject.id}, Name: ${subject.name}");
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

                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                  width: 140.w,
                                  height: 140.h,
                                  padding: EdgeInsets.only(left: 26.w),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.w),
                                      child: Image.network(widget.labelImage)),
                                ),

                                Container(
                                  width: 170.w,
                                  height: 120.h,
                                  margin: EdgeInsets.only(left: 20.w, bottom: 30.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                              child: FittedBox(
                                                  child: Text(
                                                    widget.bannerName, maxLines: 2, overflow: TextOverflow.ellipsis,    //if text overflows so "..." are shown instead
                                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Color(0xff004880),fontWeight: FontWeight.bold, letterSpacing: 1.2),
                                                  ),
                                                fit: BoxFit.cover,
                                              )
                                          ),
                                        ],
                                      ),

                                      Container(margin: EdgeInsets.only(top: 3.h,bottom: 2.h),width: 170.w, height: 2.h, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20.r)),),

                                      Row(
                                        children: [
                                          Flexible(
                                            child: FittedBox(
                                              child: Text(
                                                widget.bannerFullName, maxLines: 2, overflow: TextOverflow.ellipsis,
                                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xff004880), letterSpacing: 1.2)
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
                                  () => subjectsController.isLoading.value

                                      ?  subjectsShimmerItem()

                                      : mySubjects.isEmpty? Padding(
                                    padding: EdgeInsets.only(top: SizeConfig.defaultSize * 10),
                                    child: Center(
                                      child: Text("Subjects will be added soon",style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16
                                      ),),
                                    ),
                                  )

                                      : Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: ListView.builder(

                                    shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: mySubjects.length ?? 0,
                                        itemBuilder: (BuildContext context, int index) {
                                          SubjectsModel subjectsObj =  mySubjects[index];   //creating object of 'CategoryList' class and storing the filteredList to be displayed on it
                                             print("list creating is: ${subjectsObj.name.toString()}");
                                               return Padding(
                                                 padding: const EdgeInsets.symmetric(horizontal: 15),
                                                 child: InkWell(
                                                   onTap: () {
                                                     String subjectClicked = subjectsObj.id!;
                                                     String bannerName = subjectsObj.catagoryid!.name!;
                                                     String bannerFullName = subjectsObj.name!;
                                                     String chapterLabelImage = subjectsObj.subjectbanner!;

                                                     Get.to( ( )=> ChaptersScreen(
                                                       subjectClicked: subjectClicked,
                                                       bannerName: bannerName,
                                                       bannerFullName: bannerFullName,
                                                       chapterLabelImage: chapterLabelImage,
                                                     ),
                                                         transition: Transition.downToUp,duration: const Duration(milliseconds: 220)
                                                     );
                                                   },
                                                   child: GeneralContainer(
                                                       image: subjectsObj.subjecticon!,
                                                       text: subjectsObj.name!,
                                                       onPress: () {
                                                         String subjectClicked = subjectsObj.id!;
                                                         String bannerName = subjectsObj.catagoryid!.name!;
                                                         String bannerFullName = subjectsObj.name!;
                                                         String chapterLabelImage = subjectsObj.subjectbanner!;

                                                         Get.to( ( )=> ChaptersScreen(
                                                           subjectClicked: subjectClicked,
                                                           bannerName: bannerName,
                                                           bannerFullName: bannerFullName,
                                                           chapterLabelImage: chapterLabelImage,
                                                         ),
                                                             transition: Transition.downToUp,duration: const Duration(milliseconds: 220)
                                                         );
                                                       }
                                                   ),
                                                 ),
                                               );
                                        },
                                  ),
                                      )

                          ),
                        ),
                      ),
                    )
                  ]
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class subjectsShimmerItem extends StatelessWidget {
  const subjectsShimmerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15,),
                  child: Container(
                    height: MediaQuery.of(context).size.height/12.h,
                    width: MediaQuery.of(context).size.width /1.16.w,

                    margin: EdgeInsets.only(top:20.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                    ),

                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.grey.shade100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 100.h,
                            width: MediaQuery.of(context).size.width/4.7.w ,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: Colors.white,
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
            padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
            child: Container(
              height: MediaQuery.of(context).size.height/12.h,
              width: MediaQuery.of(context).size.width /1.16.w,

              margin: EdgeInsets.only(top:23.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.white,
              ),

              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade200,
                highlightColor: Colors.grey.shade100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 100.h,
                      width: MediaQuery.of(context).size.width/4.7.w ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
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
            padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
            child: Container(
              height: MediaQuery.of(context).size.height/12.h,
              width: MediaQuery.of(context).size.width /1.16.w,

              margin: EdgeInsets.only(top:23.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.white,
              ),

              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade200,
                highlightColor: Colors.grey.shade100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 100.h,
                      width: MediaQuery.of(context).size.width/4.7.w ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
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
            padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
            child: Container(
              height: MediaQuery.of(context).size.height/12.h,
              width: MediaQuery.of(context).size.width /1.16.w,

              margin: EdgeInsets.only(top:23.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.white,
              ),

              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade200,
                highlightColor: Colors.grey.shade100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 100.h,
                      width: MediaQuery.of(context).size.width/4.7.w ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
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

