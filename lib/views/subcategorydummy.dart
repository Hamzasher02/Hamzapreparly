import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Assuming you have a DummyController
import 'package:preparely/controllers/Hdummycontroller.dart';
import 'package:preparely/size_config.dart';
import 'package:preparely/themefont/fontscolor.dart';
import 'package:preparely/views/gridViewScreen.dart';
import 'package:preparely/views/subjectsScreen.dart';

class Dropdownlistscreen extends StatefulWidget {
  final String imageUrl;
  final String categoryname;
  final String categoryfullname;
  final String id;
  // final String addlevel;
  final RxList selectedData;

  Dropdownlistscreen({
    Key? key, // Added Key parameter
    required this.imageUrl,
    required this.categoryname,
    required this.categoryfullname,
    required this.id,
    // required this.addlevel,
    required this.selectedData,
  }) : super(key: key);

  @override
  State<Dropdownlistscreen> createState() => _DropdownlistscreenState();
}

class _DropdownlistscreenState extends State<Dropdownlistscreen> {
  List<bool> isDropdownVisibleList = [];

  @override
  void initState() {
    super.initState();
    // Initialize the visibility list
    isDropdownVisibleList =
        List<bool>.filled(widget.selectedData.length, false);
    // print(widget.addlevel);
    print(
        "this is my the  sub category id and their level ${widget.selectedData.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff004880),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.7,
                  decoration: const BoxDecoration(
                    color: Color(0xff004880),
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/appBackgroundImage/curveContainerWhite4.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Builder(
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.width * 0.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Wrap(
                                  spacing: -12,
                                  children: [
                                    // IconButton(
                                    //   onPressed: () {
                                    //     Scaffold.of(context).openDrawer();
                                    //   },
                                    //   icon: const Icon(
                                    //     Icons.menu,
                                    //     color: Color(0xff004880),
                                    //   ),
                                    // ),
                                    // IconButton(
                                    //   onPressed: () {},
                                    //   icon: const Icon(
                                    //     Icons.notifications,
                                    //     color: Color(0xff004880),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Image.network(
                            widget.imageUrl,
                            width: 100, // Adjust the width as needed
                            height: 100, // Adjust the height as needed
                            fit: BoxFit.contain,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.categoryname),
                                const SizedBox(
                                  width: 100, // Adjust the width as needed
                                  child: Divider(
                                    height: 2,
                                    color: Color.fromARGB(255, 10, 10, 10),
                                    thickness: 2.0,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(widget.categoryfullname),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                GetBuilder<DummyController>(
                  builder: (controller) {
                    if (widget.selectedData.isEmpty) {
                      return Text('the data is not available');
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: widget.selectedData.length,
                          itemBuilder: (context, index) {
                            var subcategory = widget.selectedData[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        // Toggle the visibility of the clicked dropdown
                                        isDropdownVisibleList[index] =
                                            !isDropdownVisibleList[index];
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      height: 50,
                                      child: ListTile(
                                        trailing: CircleAvatar(
                                            backgroundColor:
                                                FontColors.mainbluecolor,
                                            child: isDropdownVisibleList[index]
                                                ? Icon(
                                                    Icons.keyboard_arrow_up,
                                                    color: FontColors
                                                        .mainwhitlecolor,
                                                  )
                                                : Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: FontColors
                                                        .mainwhitlecolor,
                                                  )),
                                        title: Text(subcategory['subname']
                                                ?.toString() ??
                                            ''),
                                      ),
                                    ),
                                  ),
                                  if (isDropdownVisibleList[index])
                                    Container(
                                      height:
                                          200, // Adjust the height as needed
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      child: Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(() => SubjectsScreen(
                                                subCategClickedId:
                                                    '${widget.selectedData}',
                                                bannerName: '',
                                                bannerFullName:
                                                    'bannerFullName',
                                                labelImage: 'labelImage'));
                                          },
                                          child: Text(
                                            widget
                                                    .selectedData[index]
                                                        ['chapter']
                                                    .isNotEmpty
                                                ? widget.selectedData[index]
                                                        ['chapter'][0]
                                                        ['chapter']
                                                    .toString()
                                                : 'No chapter available',
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
