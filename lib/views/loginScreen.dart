import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:preparely/views/privacyPolicy.dart';
import 'package:preparely/views/termsOfService.dart';

import '../Widgets/login_inputTextField.dart';
import '../controllers/loginController.dart';
import 'passwordForgotScreen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  LoginController loginController = Get.put(LoginController());

  ValueNotifier<bool> passwordNotifier = ValueNotifier(true);        //This ValueNotifier is used to toggle the visibility of the text in a TextFormField widget based on whether or not the value of confirmPasswordNotifier is true or false.

  final _emailFormKey = GlobalKey<FormFieldState>();
  final _passwordFormKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff004880),
      resizeToAvoidBottomInset: false,   // used for text formFields to prevent bottom overflow when the keypad comes up and it is a better alternative to singleChildScrollView in this case

      body: SafeArea(
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Center(
                child: Container(
                  margin: EdgeInsets.only(top: 110.h),
                  height: 120.h,
                  width: 108.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SvgPicture.asset("assets/logos/splashScreenLogo.svg",  fit: BoxFit.scaleDown,),
                  ),
                ),
            ),

            SizedBox(height: 10,),

            Align(
              alignment: Alignment.center,
              child: Text('Login to your account',textAlign:TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(
                width:  MediaQuery.of(context).size.width - 55,
                child: TextFormField(
                  controller: loginController.emailController,
                  key: _emailFormKey,
                  validator: (value) {
                    if (GetUtils.isEmail(value!)) {     // if the email is correct so print null else print "Enter valid email"
                      return null;
                    } else if (value.contains(' ')) {
                      return 'email should not contain spaces';
                    }
                    return"Enter valid email";
                  },

                  style:  Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.9
                  ),
                  textAlign: TextAlign.center,         //   ...........codeLine 'A'
                  textAlignVertical: TextAlignVertical.center,  //center the text vertically within the TextFormField.
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0),     // ...........codeLine 'B'    ======> this code works in collaboration with codeLine 'A'
                    hintText: "username",
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),

                    prefixIcon: const Icon(Icons.account_circle,
                      color: Color(0xff517EAF),
                    ),

                    suffixIcon: Icon(
                      Icons.visibility, color: Colors.transparent,
                    ),

                    border:  OutlineInputBorder(         // this border is used to make sure that border doesn't disappear while validating
                      borderSide: BorderSide(color: Colors.white, width: 3.w),
                      borderRadius: BorderRadius.all(Radius.circular(30.r)),
                    ),

                    focusedBorder: OutlineInputBorder(                         // 'focusedBorder' : is used so that the outlineBorder doesnot dissapear when focused
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.9), width: 3.w),
                      borderRadius: BorderRadius.all(Radius.circular(30.r)),
                    ),

                    enabledBorder: OutlineInputBorder(                        // 'enabledBorder' : is used so that the border remain enabled after refreshing screen
                      borderSide: BorderSide(color: Colors.white, width: 3.w),
                      borderRadius: BorderRadius.all(Radius.circular(30.r)),
                    ),

                  ),

                ),
              ),

                  SizedBox(height: 13.h,),

                  SizedBox(
                    width:  MediaQuery.of(context).size.width - 55,
                    child: ValueListenableBuilder(        // // The ValueListenableBuilder widget listens to changes in the value of confirmPasswordNotifier.
                      valueListenable: passwordNotifier,  // Whenever the value of confirmPasswordNotifier changes, the builder function is called with the new value of confirmPasswordNotifier and the child widget (which is the TextFormField widget in this case).
                      builder: (context, bool value, Widget? child) {
                        return TextFormField(
                          controller: loginController.passwordController,

                          key: _passwordFormKey,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password cannot be empty';

                            }  if (value.length < 5 ) {
                              return 'Password must be at least 5 characters long';

                            } if (value.contains(' ')) {
                              return 'Password should not contain spaces';
                            }
                            // add more password validation logic as needed
                            return null;
                          },

                          obscureText: passwordNotifier.value,     // The obscureText property of the TextFormField widget is set to confirmPasswordNotifier.value, which means that if confirmPasswordNotifier is true, the text will be hidden, and if it is false, the text will be visible.

                          style:  Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.9
                          ),
                          textAlign: TextAlign.center,         //   ...........codeLine 'A'
                          textAlignVertical: TextAlignVertical.center,  //center the text vertically within the TextFormField.
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 12.0),     // ...........codeLine 'B'    ======> this code works in collaboration with codeLine 'A'
                            hintText: "password",
                            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),

                            //  filled: true,
                            // fillColor: Colors.lightBlueAccent,           // used to color TextFormField

                            //We added the 'Material' widget around the 'InkWell' and set its 'shape' property to 'CircleBorder()' to make it circular.
                            // We also set the 'clipBehavior' property to 'Clip.hardEdge' to clip the ink splash within the bounds of the circle.
                            // Finally, we set the 'color' property to 'Colors.transparent' to make the material widget invisible
                            suffixIcon: Material(
                              shape: CircleBorder(),
                              clipBehavior: Clip.hardEdge,
                              color: Colors.transparent,
                              child: InkWell(
                                //The suffixIcon property of the InputDecoration widget is set to an InkWell widget with an Icon widget as its child. When the user taps on the suffixIcon, the onTap function is called, which toggles the value of confirmPasswordNotifier between true and false.
                                // If confirmPasswordNotifier is true, the Icons.visibility_off icon is displayed, and if it is false, the Icons.visibility icon is displayed. This allows the user to toggle the visibility of the password text by tapping on the icon.
                                onTap: () {
                                  passwordNotifier.value = !passwordNotifier.value;
                                },
                                child: Icon(
                                  passwordNotifier.value ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.white,
                                ),
                              ),
                            ),


                            prefixIcon: Icon(Icons.lock_outline,
                              color: Color(0xff517EAF),
                            ),

                            border:  OutlineInputBorder(         // this border is used to make sure that border doesn't disappear while validating                     // 'focusedBorder' : is used so that the outlineBorder doesnot dissapear when focused
                              borderSide: BorderSide(color: Colors.white, width: 3.w),
                              borderRadius: BorderRadius.all(Radius.circular(30.r)),
                            ),

                            focusedBorder: OutlineInputBorder(                         // 'focusedBorder' : is used so that the outlineBorder doesnot dissapear when focused
                              borderSide: BorderSide(color: Colors.white, width: 3.w),
                              borderRadius: BorderRadius.all(Radius.circular(30.r)),
                            ),

                            enabledBorder: OutlineInputBorder(                        // 'enabledBorder' : is used so that the border remain enabled after refreshing screen
                              borderSide: BorderSide(color: Colors.white, width: 3.w),
                              borderRadius: BorderRadius.all(Radius.circular(30.r)),
                            ),

                          ),

                        );
                      },
                    ),
                  ),

                  SizedBox(height: 30.h,),

                  Obx(() => SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: ElevatedButton(
                      onPressed: () async {

                        if(    // first the email is validated then password is validated
                        _emailFormKey.currentState!.validate() &&
                            _passwordFormKey.currentState!.validate()
                        ) {

                          // This line of code below is an example of asynchronous programming as we see the login controller is called and until data is fetched from API it will take some time
                          // ... but the control doesn't wait for this function to finish its execution instead it moves forward to print the rest of the data as well because this is asynchronous programming
                          // ... and if we want to make the controller wait until the execution of login controller is completed before moving forward, then we have to use 'await' keyword.

                          // Navigator.pushNamed(context, RouteName.gridViewRoute);
                          await loginController.loginWithEmail();  // we wait until the login is completed

                        }
                      },

                      // onPressed: () {    // used to select each textFormField individually
                      //   if (_emailFormKey.currentState?.value?.isNotEmpty == true) {
                      //     _emailFormKey.currentState?.validate();
                      //     loginController.loginWithEmail();
                      //   } else if (_passwordFormKey.currentState?.value?.isNotEmpty == true) {
                      //     _passwordFormKey.currentState?.validate();
                      //     loginController.loginWithEmail();
                      //   }
                      // },

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
                        child:
                        // loginController.isLoading.value ?
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     const CircularProgressIndicator(color: Color(0xff004880),),
                        //     Text(
                        //       "Logging In...",
                        //       style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        //         fontWeight: FontWeight.w600,
                        //         color: Colors.black,
                        //       ),
                        //     )
                        //   ],
                        // )
                        //     :
                        Text(
                          loginController.isLoading.value ? "Loading ..." : "Log in",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),

                    ),
                  ),
                  )

                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 16.h),
              height: 50.h,
              width: 280.w,

              child: Center(
                child: Text.rich(
                  TextSpan(
                    children: [

                      TextSpan(text: 'Forgot Password?',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),

                        recognizer: TapGestureRecognizer()..onTap = () => Get.to( ()=> const ForgotPasswordScreen(),  transition: Transition.downToUp,duration: const Duration(milliseconds: 220)),

                      ),
                    ],
                  ),
                ),
              ),
            ),

            Spacer(),          // Spacer and Expanded widgets do not work if you have wrapped them inside SingleChildScrollView

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
                              Get.to(()=> PrivacyPolicy());
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
    );
  }
}
