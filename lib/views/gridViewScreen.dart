import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:preparely/controllers/dummygridcontroller.dart';
import 'package:preparely/views/MDcatScreen.dart';

import 'package:shimmer/shimmer.dart';

import '../components/AppDrawer.dart';
import '../controllers/bannersController.dart';
import '../controllers/Hdummycontroller.dart';
import '../size_config.dart';

class gridViewScreen extends StatefulWidget {
  gridViewScreen({Key? key}) : super(key: key);

  @override
  State<gridViewScreen> createState() => _gridViewScreenState();
}

class _gridViewScreenState extends State<gridViewScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<
      RefreshIndicatorState>(); // This global key is very important to use the refresh screen

  // GridViewController gridViewController = Get.put(GridViewController());
  BannerController bannerController = Get.put(BannerController());
  DummygridController dummygridController = Get.put(DummygridController());
  DummyController dummyController = Get.put(DummyController());
  // MDCATController mdcatController = Get.put(MDCATController());
  List levelid = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Call fetchData within initState
  }

  void fetchData() async {
    await dummygridController.fetchData(context);

    if (dummygridController.listgrid.isNotEmpty) {
      String categoryId = dummygridController.listgrid.first['_id'];
      await dummyController.fetchChapterDetail(categoryId);
    }

    print("this is my dumygridview ${dummygridController.listgrid.length}");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: const Color(0xff004880),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          await dummygridController.fetchData(context);
        },
        child: SafeArea(
          child: Stack(
            children: [
              Column(children: [
                Expanded(
                  flex: 2,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff004880),
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/appBackgroundImage/curveContainerWhite4.png'),
                            fit: BoxFit.fill,
                          )),
                      child: Obx(() {
                        if (bannerController.banners.isEmpty) {
                          return ShimmerGridBannerItem();
                        } else {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    height:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          spacing: -12,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Scaffold.of(context)
                                                    .openDrawer();
                                              },
                                              icon: const Icon(
                                                Icons.menu,
                                                color: Color(0xff004880),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.notifications,
                                                color: Color(0xff004880),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 7,
                                  right: 20,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.058,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    // Column for text
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.cover,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Preparely',
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: const Color(
                                                          0xff004880),
                                                      fontSize: SizeConfig
                                                              .defaultSize *
                                                          1.8),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        FittedBox(
                                          fit: BoxFit.cover,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              'A new way to learn',
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black,
                                                    fontSize:
                                                        SizeConfig.defaultSize *
                                                            0.73,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.029),
                                        FittedBox(
                                          fit: BoxFit.cover,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Learn through video lessons,\npdf documents,practice\nMCQs.',
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black,
                                                    fontSize: SizeConfig
                                                            .defaultSize *
                                                        0.8, // for responsive text based on screen height
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.26,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.125,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: bannerController
                                                .banners.isNotEmpty
                                            ? CarouselSlider(
                                                items: bannerController.banners
                                                    .expand((bannerOBJ) =>
                                                        bannerOBJ.bannerImage ??
                                                        [])
                                                    .map((imageURL) =>
                                                        Image.network(
                                                          imageURL,
                                                          fit: BoxFit.scaleDown,
                                                        ))
                                                    .toList(),
                                                options: CarouselOptions(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.26,
                                                  enableInfiniteScroll: true,
                                                  reverse: false,
                                                  autoPlay: true,
                                                  autoPlayInterval:
                                                      Duration(seconds: 4),
                                                  autoPlayAnimationDuration:
                                                      Duration(
                                                          milliseconds: 800),
                                                  autoPlayCurve:
                                                      Curves.fastOutSlowIn,
                                                  aspectRatio: 2.0,
                                                  enlargeCenterPage: true,
                                                  enlargeStrategy:
                                                      CenterPageEnlargeStrategy
                                                          .scale,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                ),
                                              )
                                            : const Center(
                                                child: Text(
                                                  "No banners",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      })),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Obx(() => dummygridController.isLoading.value
                        ? ShimmerGridItem()
                        : GridView.builder(
                            padding: EdgeInsets.all(12),
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0,
                            ),
                            itemCount: dummygridController.listgrid.length,
                            itemBuilder: (context, index) {
                              var categoryObj =
                                  dummygridController.listgrid[index];

                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => Mdcatee(
                                        categoryId: categoryObj[
                                            '_id'], // Change this line
                                        subjectId: categoryObj['_id'],
                                        subjectname: categoryObj['examname'],

                                        imageurl: categoryObj['logo'],
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.network(
                                          categoryObj['logo'] ?? '',
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.contain,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          categoryObj['examname']?.toString() ??
                                              '',
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          categoryObj['full_name']
                                                  ?.toString() ??
                                              '',
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })),
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class ShimmerGridBannerItem extends StatelessWidget {
  const ShimmerGridBannerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(
                  Icons.menu,
                ),
                Icon(
                  Icons.notifications,
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(
              left: 7,
              right: 20,
              bottom: MediaQuery.of(context).size.height * 0.058,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Column for text
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 20,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 13,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.029),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 8,
                        width: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 3),
                      child: Container(
                        height: 8,
                        width: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 3),
                      child: Container(
                        height: 8,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),

                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.26,
                    height: MediaQuery.of(context).size.height * 0.125,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerGridItem extends StatelessWidget {
  const ShimmerGridItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Shimmer.fromColors(
                baseColor: Colors.grey.shade200,
                highlightColor: Colors.grey.shade100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 7),
                      height: 10,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 11,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 11,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
// Defining "MyCustomClipper" class to draw 'bazier curve'

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Getter method

    Path path = Path();

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
