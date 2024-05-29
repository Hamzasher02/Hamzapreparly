
import 'package:flutter/material.dart';
import 'package:preparely/utilities/route_name.dart';



import '../views/chaptersScreen.dart';
import '../views/subjectsScreen.dart';
import '../views/McqsPdfsVideosScreen.dart';
import '../views/createAccountScreen.dart';
import '../views/engineeringSubjectsScreen.dart';
import '../views/gridViewScreen.dart';
import '../views/highSchoolSubjects.dart';
import '../views/loginScreen.dart';
import '../views/mockTestScreen.dart';
import '../views/simpleBlueWhiteScreen.dart';
import '../views/splashScreen.dart';
import '../views/welcomeScreen.dart';

class Routes{               // in this class we assign the path of route to RouteName

  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {         // 'settings' helps in setting the name of route

      case RouteName.splashScreenRoute:
        return MaterialPageRoute(builder: (context) =>  const splashScreen(),);


      case RouteName.welcomeScreenRoute:
        return MaterialPageRoute(builder: (context) =>const welcomeScreen(),);


      case RouteName.loginScreenRoute:
        return MaterialPageRoute(builder: (context) => const loginScreen(),);


      case RouteName.createAccountRoute:
        return MaterialPageRoute(builder: (context) => createAccountScreen(),);

      case RouteName.gridViewRoute :
        return MaterialPageRoute(builder: (context) => gridViewScreen(),);

      //
      // case RouteName.dropDownScreenRoute:
      //   return MaterialPageRoute(builder: (context) => dropDownScreen(),);


      case RouteName.highSchoolSubjectsRoute:
        return MaterialPageRoute(builder: (context) => highSchoolSubjects(),);


      // case RouteName.McqsPdfsVideosScreenRoute:
      //   return MaterialPageRoute(builder: (context) => McqsPdfsVideosScreen(),);


      case RouteName.simpleBlueWhiteScreenRoute:
        return MaterialPageRoute(builder: (context) => simpleBlueWhiteScreen(),);

      // case RouteName.mockTestScreenRoute:
      //   return MaterialPageRoute(builder: (context) => mockTestScreen(),);

        // :::::::::::::::::::::::::  Embeded Screens Routes ::::::::::::::::::::::::::::::://

    // ......... NAT Screens under NTS catagory..................................//
      case RouteName.engineeringSubjectsScreenRoute:
        return MaterialPageRoute(builder: (context) => engineeringSubjectsScreen());

      // case RouteName.SubjectsScreenRoute:
      //   return MaterialPageRoute(builder: (context) => SubjectsScreen());

    // ......... GATsubjects Screens under NTS catagory..................................//
    //   case RouteName.GATenglishRoute:
    //     return MaterialPageRoute(builder: (context) => GATenglish());
    //
    //   case RouteName.GATanalyticalRoute:
    //     return MaterialPageRoute(builder: (context) =>GATanalytical());
    //
    //   case RouteName.GATsubjectsRoute:
    //     return MaterialPageRoute(builder: (context) =>GATsubjects());

    //.............GATgeneral Screens under NTS catagory...............................//

      // case RouteName.GATverbalReasoningRoute:
      //   return MaterialPageRoute(builder: (context) =>GATverbalReasoning());
      //
      // case RouteName.GATquantitativeReasoningRoute:
      //   return MaterialPageRoute(builder: (context) =>GATquantitativeReasoning());
      //
      // case RouteName.GATanalyticalReasoningRoute:
      //   return MaterialPageRoute(builder: (context) =>GATanalyticalReasoning());

    //.............TOEIC bridge Screens under NTS catagory...............................//

      // case RouteName.TOEICbridgeListeningRoute:
      //   return MaterialPageRoute(builder: (context) =>TOEICbridgeListening());
      //
      // case RouteName.TOEICbridgeReadingRoute:
      //   return MaterialPageRoute(builder: (context) =>TOEICbridgeReading());

    //.............chapters sub embeded files............................//

      // case RouteName.ChaptersScreenRoute:
      //   return MaterialPageRoute(builder: (context) =>ChaptersScreen());




      default:
                return MaterialPageRoute(builder: (context) => const Scaffold(body: Center(child: Text("No route provided")),),);
    }
  }
}