
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/resetPasswordController.dart';

class ResetPasswordScreen extends StatefulWidget {

  final String registeredEmail;

  const ResetPasswordScreen({Key? key,
    required this.registeredEmail
  }) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  ValueNotifier<bool> passwordNotifier = ValueNotifier(true);        //This ValueNotifier is used to toggle the visibility of the text in a TextFormField widget based on whether or not the value of confirmPasswordNotifier is true or false.
  ValueNotifier<bool> confirmPasswordNotifier = ValueNotifier(true); 

  ResetPasswordController resetPasswordController = Get.put(ResetPasswordController());


  final _newPasswordFormKey = GlobalKey<FormFieldState>();
  final _confirmPasswordFormKey = GlobalKey<FormFieldState>();

  //_passwordsMatch function is made to check if the new password and confirm password fields have the same value.
  // We then modify the onPressed callback of the submit button to check that both form fields are valid and that the passwords match before allowing the form to be submitted.
  bool _passwordsMatch() {
    return resetPasswordController.passwordController.text ==
        resetPasswordController.confirmPasswordController.text;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff004880),
      //  resizeToAvoidBottomInset: false,   // used for text formFields to prevent bottom overflow when the keypad comes up and it is a better alternative to singleChildScrollView in this case

        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Center(
                  child: Lottie.asset(
                      'animations/112418-forgot-password.json',
                      height: 150,
                      repeat: false,
                      fit: BoxFit.cover
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.009),

                  child: Text("Reset\nPassword",textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                  child: Opacity(
                      opacity: 0.7,
                      child: Text("We just need your registered Email to send\nyou a reset link",textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 15.h),
                  width: MediaQuery.of(context).size.width - 55,
                  child: Column(
                    children: [

                      SizedBox(height: 8.h,),

                      ValueListenableBuilder(                  // The ValueListenableBuilder widget listens to changes in the value of confirmPasswordNotifier.
                        valueListenable: passwordNotifier,     // Whenever the value of confirmPasswordNotifier changes, the builder function is called with the new value of confirmPasswordNotifier and the child widget (which is the TextFormField widget in this case).
                        builder: (BuildContext context, bool value, Widget? child) {
                          return TextFormField(
                            controller: resetPasswordController.passwordController,

                            key: _newPasswordFormKey,

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password cannot be empty';

                              } if (!RegExp(r'[A-Z]').hasMatch(value)) {      // At least one uppercase letter: Use a regular expression to check if the password contains at least one uppercase letter.
                                return 'Password must contain at least one uppercase letter';

                              } if (!RegExp(r'[a-z]').hasMatch(value)) {     // At least one lowercase letter: Use a regular expression to check if the password contains at least one lowercase letter.
                                return 'Password must contain at least one lowercase letter';

                              } if (!RegExp(r'\d').hasMatch(value)) {       // At least one number: Use a regular expression to check if the password contains at least one number.
                                return 'Password must contain at least one number';

                              } if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {    //At least one special character: Use a regular expression to check if the password contains at least one special character.
                                return 'Password must contain at least one special character';

                              } if (value.length < 5 ) {
                                return 'Password must be at least 5 characters long';

                              } if (value.contains(' ')) {
                                return 'Password should not contain spaces';
                              }
                              // add more password validation logic as needed
                              return null;
                            },

                            obscureText: passwordNotifier.value,      // The obscureText property of the TextFormField widget is set to confirmPasswordNotifier.value, which means that if confirmPasswordNotifier is true, the text will be hidden, and if it is false, the text will be visible.

                            textAlign: TextAlign.center,         //   ...........codeLine 'A'
                            style:  Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.9
                          ),

                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 10.0.h),  // This line is used to adjust the height or width of the TextFormField

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

                              prefixIcon: Icon(Icons.lock_outline_rounded,color: Colors.white,),
                              labelText: 'New Password',
                              labelStyle: TextStyle(color: Colors.white),
                              hintText: "New password",
                              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),

                              //  filled: true,
                              // fillColor: Colors.lightBlueAccent,           // used to color TextFormField

                              border: OutlineInputBorder(                       // this border is used to make sure that border doesn't disappear while validating
                            borderSide: BorderSide(color: Colors.white, width: 3.w),
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          ),

                              focusedBorder: OutlineInputBorder(                         // 'focusedBorder' : is used so that the outlineBorder doesnot dissapear when focused
                                borderSide: BorderSide(color: Colors.white.withOpacity(0.9), width: 3.w),
                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                              ),

                              enabledBorder: OutlineInputBorder(                        // 'enabledBorder' : is used so that the border remain enabled after refreshing screen
                                borderSide: BorderSide(color: Colors.white, width: 3.w),
                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                              ),
                            ),

                          );
                        },
                      ),

                      SizedBox(height: 8.h,),

                      ValueListenableBuilder(
                        valueListenable: confirmPasswordNotifier,
                        builder: (BuildContext context, value, Widget? child) {
                          return TextFormField(
                            controller: resetPasswordController.confirmPasswordController,

                            key: _confirmPasswordFormKey,

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password cannot be empty';

                              } if (!RegExp(r'[A-Z]').hasMatch(value)) {      // At least one uppercase letter: Use a regular expression to check if the password contains at least one uppercase letter.
                                return 'Password must contain at least one uppercase letter';

                              } if (!RegExp(r'[a-z]').hasMatch(value)) {     // At least one lowercase letter: Use a regular expression to check if the password contains at least one lowercase letter.
                                return 'Password must contain at least one lowercase letter';

                              } if (!RegExp(r'\d').hasMatch(value)) {       // At least one number: Use a regular expression to check if the password contains at least one number.
                                return 'Password must contain at least one number';

                              } if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {    //At least one special character: Use a regular expression to check if the password contains at least one special character.
                                return 'Password must contain at least one special character';

                              } if (value.length < 5 ) {
                                return 'Password must be at least 5 characters long';

                              } if (value.contains(' ')) {
                                return 'Password should not contain spaces';

                              } if (value != resetPasswordController.passwordController.text) {
                                return 'Passwords do not match';
                              }
                              // add more password validation logic as needed
                              return null;
                            },

                            obscureText: confirmPasswordNotifier.value,

                            textAlign: TextAlign.center,         //   ...........codeLine 'A'
                            style:  Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.9
                            ),

                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 10.0.h),  // This line is used to adjust the height or width of the TextFormField

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
                                    confirmPasswordNotifier.value = !confirmPasswordNotifier.value;
                                  },
                                  child: Icon(confirmPasswordNotifier.value ? Icons.visibility_off : Icons.visibility, color: Colors.white,)
                                ),
                              ),

                              prefixIcon: Icon(Icons.lock_outline_rounded,color: Colors.white,),
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(color: Colors.white),
                              hintText: "Confirm password",
                              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),

                              //  filled: true,
                              // fillColor: Colors.lightBlueAccent,           // used to color TextFormField

                              border: OutlineInputBorder(                       // this border is used to make sure that border doesn't disappear while validating
                                borderSide: BorderSide(color: Colors.white, width: 3.w),
                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                              ),

                              focusedBorder: OutlineInputBorder(                         // 'focusedBorder' : is used so that the outlineBorder doesnot dissapear when focused
                                borderSide: BorderSide(color: Colors.white.withOpacity(0.9), width: 3.w),
                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                              ),

                              enabledBorder: OutlineInputBorder(                        // 'enabledBorder' : is used so that the border remain enabled after refreshing screen
                                borderSide: BorderSide(color: Colors.white, width: 3.w),
                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                              ),
                            ),

                          );
                        },
                      ),

                      SizedBox(height: 30.h,),

                    ElevatedButton(
                      onPressed: () {

                        if (  // first the newPassword is validated then confirmPassword is validated then checked if both match or not
                        _newPasswordFormKey.currentState!.validate() &&
                        _confirmPasswordFormKey.currentState!.validate() &&
                        _passwordsMatch()
                        ) {

                          resetPasswordController.ResetPassword(widget.registeredEmail);  //  you can pass the pinCodeController to the ResetPassword method as a parameter


                        }
                      },
                      style: ButtonStyle(

                        shape: MaterialStateProperty.all( RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(20.r))),),
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
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        child: Text("Verify", textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
