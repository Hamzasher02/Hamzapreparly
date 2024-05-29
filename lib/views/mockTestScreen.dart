import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:preparely/views/quiz_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../components/MockTestContainer.dart';
import '../controllers/mockListController.dart';

class mockTestScreen extends StatefulWidget {
  final String subCategClickedId;
  final String screenTitle;

  const mockTestScreen({
    Key? key,
     required this.subCategClickedId,
    required this.screenTitle,
  }) : super(key: key);

  @override
  State<mockTestScreen> createState() => _mockTestScreenState();
}

class _mockTestScreenState extends State<mockTestScreen> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();  // this is to be used to automatically refresh the scren so that listview can display the list

  final mockListController = Get.put(MockListController());

  @override
  void initState() {
    super.initState();
    // Call the refresh method when the screen is accessed
    _refreshData();
  }

  Future<void> _refreshData() async {
    await mockListController.fetchData();

    if (!mockListController.isLoading.value) {
      await Future.delayed(Duration.zero); // Delay to ensure the loading state change is processed
      setState(() {});
    }

  }

  @override
  Widget build(BuildContext context) {
    // filter function to filter out items based on ID passed
    final filteredList = mockListController.mockData
        .where((item) => item['category'] == widget.subCategClickedId)
        .toList()
        .obs;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 7.5,
              right: 13,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Container(
                  width: 51.w,
                  height: 52.h,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SvgPicture.asset(
                      "assets/logos/splashScreenLogo.svg",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: ClipPath(
                      clipper:
                          MyCustomClipper(), //Customized Methdd called to implement the bezier curve

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
                                  spacing:
                                      -19, // using wrap() widget to reduce spacing between icons
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        print("notification working");
                                      },
                                      icon: Icon(
                                        Icons.notifications,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                                top: MediaQuery.of(context).size.height *
                                    0.021.h,
                                left:
                                    MediaQuery.of(context).size.width * 0.35.w,
                                child: FittedBox(
                                  child: SvgPicture.asset(
                                     "assets/logos/productsLogo.svg",
                                      fit: BoxFit.scaleDown,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.16,
                                      width: MediaQuery.of(context).size.width *
                                          0.30),
                                )),
                            Positioned(
                                bottom: 52,
                                left: 50.w,
                                child: Container(
                                  margin:
                                      EdgeInsets.only(top: 5.h, bottom: 4.h),
                                  width: 330.w,
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(20.r)),
                                )),
                            Positioned(
                              bottom: 33,
                              left: 50.w,
                              child: FittedBox(
                                child: Text(
                                  widget.screenTitle.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
/*
Note: Flex property divides screen into 4+2 = 6 parts then assign parts to each container accordingly
*/

                Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 3),
                          height: 60,
                          width: 340,
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Get your self prepared for the exams\nthrough video lessons, pdfs and Mcqs\nfor this chanpter.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black38,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035,
                                    ),
                              )),
                        ),

                        SizedBox(height: 10),

                        Expanded(
                          child: Obx(
                            () {
                              if (mockListController.isLoading.value) {
                                return Center(
                                  child: MockTestShimmerItem(),
                                );

                              }  else if (filteredList.isEmpty) {
                                return Center(
                                  child: Text("Mock Tests will be added soon"),
                                );
                              }else {
                                return ListView.builder(
                                  itemCount: filteredList.length,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final item = filteredList[index];
                                     return InkWell(
                                         onTap: () {
                                           String mockTestClicked = item['name']; // sending this 'name' of mock item is also very important so that the filterQuestionsByChapterId () in quiz screen can do comparison and filteration properly
                                           String mockItemName = item['name'];

                                           String source = 'mock'; // This variable source is very important for the QuizScreen to differentiate between normal mcqs and mock mcqs fetching function from controller

                                           Get.to(()=> QuizScreen(chapterClicked: mockTestClicked, screenTitle: mockItemName, source: source,));

                                         },
                                         child: MockTestContainer(text: item['name'],)  //The representation "item['name']" is used because the items in the filteredList are accessed as key-value pairs, where the name is obtained using the key 'name'.
                                     );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MockTestShimmerItem extends StatelessWidget {

  const MockTestShimmerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.16,
                  width: MediaQuery.of(context).size.width -35,
                  margin: EdgeInsets.only(top: 3.h,),    // creates distance between two widgets
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.white,
                  ),

                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade200,
                    highlightColor: Colors.grey.shade100,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15,),
                      child: Container(
                        height: 85.h,
                        // width: MediaQuery.of(context).size.width - 35,

                        // height: MediaQuery.of(context).size.height/12.h,
                        // width: MediaQuery.of(context).size.width /1.16.w,

                        padding: EdgeInsets.only(right: 10,),
                        margin: EdgeInsets.only(top: 7.h,),    // creates distance between two widgets
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Colors.lightBlue
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },),
        ],
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
