import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:preparely/views/privacyPolicy.dart';
import 'package:preparely/views/termsOfService.dart';

import '../utilities/route_name.dart';


//  ................ \u0027s ........... is the method to write apostrophie [ 's ]

class welcomeScreen extends StatefulWidget {
  const welcomeScreen({Key? key}) : super(key: key);

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,       // this property is not Working bc Padding is given from 'top'
      backgroundColor: Color(0xff004880),

      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,

          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: MediaQuery.of(context).size.height * 0.08),

              Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.12, bottom:MediaQuery.of(context).size.height * 0.05),
                  height: MediaQuery.of(context).size.height *0.14,
                  width: MediaQuery.of(context).size.width * 0.8,

                  child: Column(
                    children: [

                      Text('Welcome!',textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),

                      Text('Get yourself prepared for exams',textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, RouteName.loginScreenRoute);
                  },

                  style: ButtonStyle(

                    shape: MaterialStateProperty.all(RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(10.r))),),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    foregroundColor: MaterialStateProperty.all(Colors.black),

                    overlayColor: MaterialStateProperty.resolveWith<Color?>(      //
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Color(0xff004880); //<-- SEE HERE
                        return null; // Defer to the widget's default.
                      },
                    ),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "Login with Email/Phone",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),

                ),
              ),
              SizedBox(height: 30.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('New to preparely? ',style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                  ),
                  SizedBox(width: 15,),

                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.createAccountRoute);
                    },

                      child: Text('Create Account',style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                      )
                  ),
                ],
              ),

              Spacer(),    // Spacer and Expanded widgets do not work if you have wrapped them inside SingleChildScrollView

              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
                child: Container(
                    height: MediaQuery.of(context).size.height *0.08,
                    width: MediaQuery.of(context).size.width -35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                            'By creating an account you accept Preparely\u0027s',  // for apostrophy 's
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(()=> const TermsConditions());
                              },
                              child: Text('Terms of Service ',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.lightBlue,
                              ),
                              ),
                            ),
                            Text('and ',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => const PrivacyPolicy());
                              },
                              child: Text('Terms of Privacy Policy',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.lightBlue,
                              ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}

