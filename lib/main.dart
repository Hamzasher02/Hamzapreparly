import 'package:device_preview/device_preview.dart'; // This library is imported to use test the app on multiple sized devices

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:flutter/services.dart'; //imported for Status bar color channge ie; [ SystemChrome ]
import 'package:preparely/utilities/route_name.dart';
import 'package:preparely/utilities/routes.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // binding all widgets to Flutter Engine

  SystemChrome.setPreferredOrientations([
    //  using the following code i have made the app forced portrait so as not to allow rotation
    DeviceOrientation
        .portraitUp, // but just to allow video player to rotate i have allowed forced rotation on it
  ]);

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent,));      // Changing color of Status Bar on screen

  //  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);      // Changing color of Status Bar on screen

  // runApp(
  //     DevicePreview(             //This feature is used for " device_preview " package so as to show different mobile sizes on emulator
  //       enabled: true,
  //       builder: (context) => MyApp(), // Wrap your app
  //     ),);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);    // Forcefully making the app portrait by applying "Orientation Lock"
    return ScreenUtilInit(
        designSize: const Size(414, 896),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: RouteName.splashScreenRoute,
            onGenerateRoute: Routes.generateRoute,
          );
        });
  }
}
