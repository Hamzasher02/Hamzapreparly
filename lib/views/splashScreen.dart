//Splash Screen.................. screen that opens by default when you open the app and exits after defined time

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/gridViewController.dart';
import 'gridViewScreen.dart';
import 'welcomeScreen.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => splashScreenState();
}

class splashScreenState extends State<splashScreen> {

  @override
  void initState() {
    super.initState();

    whereToGo();     // as soon as user starts the app this function here will be called

    /// ... When using SharedPreference to navigate to login or dashboard screen we cannot use a defined timer because the return type of
    /// ... SharedPreferences is a "Future" type thus we have to 'await' for "getInstance" thus we will have to handle it Asynchronously.

    // Timer(
    //     const Duration(seconds: 2),  //required parameter
    //
    //         () {
    //       // pushReplacement is used so that in the stack the current screen (splashScreen) can be replaced by next screen so that on back button you cannot come back to splashScreen()
    //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    //           return welcomeScreen();
    //         },));
    //     }
    // );
  }

  static const String KEYLOGIN = "login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff004880),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: MediaQuery.of(context).size.height * 0.22,),

              Center(
                  child: Container(
                    // width: MediaQuery.of(context).size.width * 0.43,
                    // height: MediaQuery.of(context).size.height * 0.22,
                    width: MediaQuery.of(context).size.width * 0.37,
                    height: MediaQuery.of(context).size.height * 0.18,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: SvgPicture.asset('assets/logos/splashScreenLogo.svg'),
                    ),
                  )
              ),

             //  Center(
             //    //// This code uses a FutureBuilder to load the contents of the SVG file asynchronously and then render the SvgPicture widget.
             //    // If an error occurs while loading the file, it logs the error and displays an error message.
             //    // If the file is still loading, it displays a 'CircularProgressIndicator'
             //    child: Container(
             // width: MediaQuery.of(context).size.width * 0.44,
             // height: MediaQuery.of(context).size.height * 0.23,
             //      decoration: BoxDecoration(
             //          borderRadius: BorderRadius.all(Radius.circular(20)),
             //          color: Colors.white
             //      ),
             //      child: Padding(
             //        padding: const EdgeInsets.all(9.0),
             //        child: FutureBuilder<String>(
             //          future: rootBundle.loadString('assets/logos/splashScreenLogo.svg'),
             //          builder: (context, snapshot) {
             //            if (snapshot.hasError) {
             //              // If an error occurred while loading the file, log the error
             //              // and return a Text widget to display the error message.
             //              print('Error loading SVG file: ${snapshot.error}');
             //              return Text('Error loading SVG file: ${snapshot.error}');
             //            }
             //
             //            if (!snapshot.hasData) {
             //              // If the file is still loading, return a CircularProgressIndicator.
             //              return const SizedBox(
             //                height: 25,
             //                  width: 25,
             //                  child: CircularProgressIndicator(color: Color(0xff004880))
             //              );
             //            }
             //            print('image is avilable');
             //            // If the file was loaded successfully, return the SvgPicture widget.
             //            return SvgPicture.string(
             //              snapshot.data!,
             //              fit: BoxFit.scaleDown,
             //            );
             //          },
             //        ),
             //      ),
             //    ),
             //  ),


              // Container(
              //     margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.009),
              //     width: MediaQuery.of(context).size.width * 0.76,
              //     height: MediaQuery.of(context).size.height * 0.12,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text('PREPARELY', style: TextStyle(color: Colors.white, fontSize: 37,fontWeight: FontWeight.w800)),
              //         Text('Exam Preparation App', style: TextStyle(color: Colors.white, fontSize: 18)),
              //       ],
              //     )
              //
              // ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.009),

              Text('PREPARELY', style: TextStyle(color: Colors.white, fontSize: 37,fontWeight: FontWeight.w800)),

              SizedBox(height: MediaQuery.of(context).size.height * 0.009),

              Text('Exam Preparation App', style: TextStyle(color: Colors.white, fontSize: 18)),

            ],
          ),
        ),
      ),
    );
  }

  void whereToGo() async{

    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);  // we will use the same key for logout and storing state as well so throughout it will not change so lets make it static

    Timer(
        const Duration(seconds: 3), () { //required parameter

      if ( isLoggedIn != null ) { // means it is either true or false and it's not the first time that user has come to app

        if(isLoggedIn) { // if user has not logged out so here the value will be true and will not see login Screen
// pushReplacement is used so that in the stack the current screen (splashScreen) can be replaced by next screen so that on back button you cannot come back to splashScreen()
          Get.offAll(()=> gridViewScreen(), transition: Transition.downToUp,duration: const Duration(milliseconds: 220));

        } else { // if user has logged out so here the value will be false and user will see a login Screen
          Get.offAll(()=> const welcomeScreen(), transition: Transition.downToUp,duration: Duration(milliseconds: 220));

        }

      } else { // this 'else' executes when "isLoggedIn" is null ie; user is comming first time to app so he will see login screen
        Get.offAll(()=> const welcomeScreen(), transition: Transition.downToUp,duration: Duration(milliseconds: 220));
      }
    }
    );

  }





}
