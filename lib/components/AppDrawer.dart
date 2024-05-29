import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../controllers/logoutController.dart';
import '../controllers/userProfileController.dart';
import '../views/gridViewScreen.dart';
import '../views/informationScreen.dart';
import '../views/privacyPolicy.dart';
import '../views/termsOfService.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  LogoutController logoutController = Get.put(LogoutController());
  UserProfileController userProfileController =
      Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: SvgPicture.asset(
                      'assets/drawerImages/drawerBannerSvg.svg',
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Material(
                      elevation: 7,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: InkWell(
                                onTap: () => Get.back(),
                                child: Icon(
                                  Icons.close,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Obx(
                              () => userProfileController.isLoading.value
                                  ? const ShimmerItem()
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              userProfileController
                                                  .firstName.value,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.038,
                                                      letterSpacing: 0.9),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              userProfileController
                                                  .lastName.value,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.038,
                                                      letterSpacing: 0.9),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          userProfileController.email.value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.031,
                                              ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 5, top: 5, bottom: 5),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Container(
                                height: 50.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: SvgPicture.asset(
                                    'assets/drawerImages/profile.svg',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 30,
          ),
          Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.offAll(() => gridViewScreen());
                      },
                      child: Container(
                        color: Colors.grey[100],
                        child: Row(
                          children: [
                            Padding(
                              //   padding: const EdgeInsets.only(left: 18),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 18),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Container(
                                  height: 37.h,
                                  width: 37.w,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff004880),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.r))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SvgPicture.asset(
                                      'assets/drawerImages/homeLogo.svg',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 13),
                              child: Text(
                                'Home',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        // fontSize: MediaQuery.of(context).size.width *0.038,
                                        letterSpacing: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const informationScreen());
                      },
                      child: Container(
                        color: Colors.grey[100],
                        child: Row(
                          children: [
                            Padding(
                              //padding: const EdgeInsets.only(left: 18),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 18),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Container(
                                  height: 37.h,
                                  width: 37.w,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff004880),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.r))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SvgPicture.asset(
                                      'assets/drawerImages/contactUs.svg',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 13),
                              child: Text(
                                'Contact us',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        // fontSize: MediaQuery.of(context).size.width *0.038,
                                        letterSpacing: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const PrivacyPolicy());
                      },
                      child: Container(
                        color: Colors.grey[100],
                        child: Row(
                          children: [
                            Padding(
                              //  padding: const EdgeInsets.only(left: 18),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 18),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Container(
                                  height: 37.h,
                                  width: 37.w,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff004880),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.r))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SvgPicture.asset(
                                      'assets/drawerImages/privacyPolicy.svg',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 13),
                              child: Text(
                                'Privacy Policy',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        // fontSize: MediaQuery.of(context).size.width *0.038,
                                        letterSpacing: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const TermsConditions());
                      },
                      child: Container(
                        color: Colors.grey[100],
                        child: Row(
                          children: [
                            Padding(
                              //   padding: const EdgeInsets.only(left: 18),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 18),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Container(
                                  height: 37.h,
                                  width: 37.w,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff004880),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.r))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SvgPicture.asset(
                                      'assets/drawerImages/terms.svg',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 13),
                              child: Text(
                                'Terms and Conditions',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        // fontSize: MediaQuery.of(context).size.width *0.038,
                                        letterSpacing: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: Container(
                        color: Colors.grey[100],
                        child: Row(
                          children: [
                            Padding(
                              //   padding: const EdgeInsets.only(left: 18),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 18),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Container(
                                  height: 37.h,
                                  width: 37.w,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff004880),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.r))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SvgPicture.asset(
                                      'assets/drawerImages/rateUs.svg',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 13),
                              child: Text(
                                'Rate Us',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        // fontSize: MediaQuery.of(context).size.width *0.038,
                                        letterSpacing: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: Container(
                        color: Colors.grey[100],
                        child: Row(
                          children: [
                            Padding(
                              //  padding: const EdgeInsets.only(left: 18),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 18),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Container(
                                  height: 37.h,
                                  width: 37.w,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff004880),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.r))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SvgPicture.asset(
                                      'assets/drawerImages/shareApp.svg',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 13),
                              child: Text(
                                'Share App',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        // fontSize: MediaQuery.of(context).size.width *0.038,
                                        letterSpacing: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        // Close the drawer first
                        Get.back();

                        // Show the loading dialog
                        Get.dialog(
                          AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(
                                  color: Color(0xff004880),
                                ),
                                SizedBox(height: 14),
                                Text("Logging Out ..."),
                              ],
                            ),
                          ),
                          barrierDismissible:
                              false, // Prevent dialog from being dismissed by tapping outside
                        );

                        // Perform the sign-out process
                        logoutController.handleLogout();
                      },
                      child: Container(
                        color: Colors.grey[100],
                        child: Row(
                          children: [
                            Padding(
                              //  padding: const EdgeInsets.only(left: 18),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 18),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Container(
                                  height: 37.h,
                                  width: 37.w,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff004880),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.r))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SvgPicture.asset(
                                      'assets/drawerImages/signOut.svg',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 13),
                              child: Text(
                                'Sign Out',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        // fontSize: MediaQuery.of(context).size.width *0.038,
                                        letterSpacing: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );

    // .....................Test Drawer ...................
    // Drawer(
    //   child: Column(
    //     children: [
    //       Container(
    //         width: 310.w,
    //         child: DrawerHeader(
    //           decoration: BoxDecoration(
    //             color: Colors.green,
    //           ),
    //           child: Text(
    //             'Navigation Drawer',
    //             style: TextStyle(fontSize: 20.sp),
    //           ),
    //         ),
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.person),
    //         title: Text(
    //           ' My Profile ',
    //           style:
    //           TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
    //         ),
    //         onTap: () {
    //           Navigator.pop(context);
    //         },
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.book),
    //         title: Text(
    //           ' My Course ',
    //           style:
    //           TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
    //         ),
    //         onTap: () {
    //           Navigator.pop(context);
    //         },
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.workspace_premium),
    //         title: Text(
    //           ' Go Premium ',
    //           style:
    //           TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
    //         ),
    //         onTap: () {
    //           Navigator.pop(context);
    //         },
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.video_label),
    //         title: Text(
    //           ' Saved Videos ',
    //           style:
    //           TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
    //         ),
    //         onTap: () {
    //           Navigator.pop(context);
    //         },
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.edit),
    //         title: Text(
    //           ' Edit Profile ',
    //           style:
    //           TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
    //         ),
    //         onTap: () {
    //           Navigator.pop(context);
    //         },
    //       ),
    //       ListTile(
    //           leading: Icon(Icons.logout),
    //           title: Text(
    //             ' LogOut',
    //             style: TextStyle(
    //                 color: Colors.red,
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 16.sp),
    //           ),
    //           onTap: () { //logout happens in future always so we use async
    //
    //             logoutController.handleLogout();   //this function will call the logout API
    //
    //           }
    //       ),
    //     ],
    //   ),
    // );
  }
}

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade100,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 10,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ), // added a child with fixed width and height to show the shimmer effect

                  SizedBox(
                    height: 2,
                  ),

                  Container(
                    height: 7,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ), // added a child with fixed width and height to show the shimmer effect
                ],
              ),
            ],
          )),
    );
  }
}
