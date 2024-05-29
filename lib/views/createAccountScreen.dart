import 'package:flutter/services.dart';         // imported to receive Integers only as input in TextFormField
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:preparely/views/privacyPolicy.dart';
import 'package:preparely/views/termsOfService.dart';


import '../Widgets/signUp_inputTextField.dart';
import '../controllers/registerationController.dart';

class createAccountScreen extends StatefulWidget {
  const createAccountScreen({Key? key}) : super(key: key);

  @override
  State<createAccountScreen> createState() => _createAccountScreenState();
}

class _createAccountScreenState extends State<createAccountScreen> {

  RegisterationController registerationController = Get.put(RegisterationController());

  final _firstNameFormKey = GlobalKey<FormFieldState>();
  final _lastNameFormKey = GlobalKey<FormFieldState>();
  final _emailFormKey = GlobalKey<FormFieldState>();
  final _phoneFormKey = GlobalKey<FormFieldState>();
  final _passwordFormKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff004880),
     // resizeToAvoidBottomInset: false, // this property automatically resize the content when the keyboard appears to avoid overflow error
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.055),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Center(
                    child: Container(
                      height: 90.h,
                      width: 90.w,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset("assets/logos/splashScreenLogo.svg",  fit: BoxFit.scaleDown,),
                      ),
                    )
                ),

                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  height: 22.h,
                  width: 250.w,

                  child: Text('Create New Account',textAlign: TextAlign.center,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,)),
                ),

                Container(
                  margin: EdgeInsets.only(top: 15.h),
                  width: MediaQuery.of(context).size.width - 55,
                  child: Column(
                    children: [

                      SizedBox(
                    width:  MediaQuery.of(context).size.width - 55,
                    child: TextFormField(
                      controller: registerationController.firstNameController,

                      key: _firstNameFormKey,
                      validator: (value) {
                        if(GetUtils.isUsername(value!)) {
                          return null; // means that username is valid

                        } if (value == null || value.isEmpty) {
                          return 'First name cannot be empty';

                        } if (value.contains(' ')) {
                          return 'Firstname should not contain spaces';
                        }
                      },

                      textAlign: TextAlign.center,         //   ...........codeLine 'A'
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.9
                      ),

                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0.h),  // This line is used to adjust the height or width of the TextFormField
                        hintText: "First Name (Required)",
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

                    ),
                  ),

                      SizedBox(height: 13.h,),

                      SizedBox(
                        width:  MediaQuery.of(context).size.width - 55,
                        child: TextFormField(
                          controller: registerationController.lastNameController,

                          key: _lastNameFormKey,

                          validator: (value) {
                            if(GetUtils.isUsername(value!)) {
                              return null; // means that username is valid

                            } if (value == null || value.isEmpty) {
                              return 'Last name cannot be empty';

                            } if (value.contains(' ')) {
                              return 'Last Name should not contain spaces';
                            }
                          },

                          textAlign: TextAlign.center,         //   ...........codeLine 'A'
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.9
                          ),

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0.h),  // This line is used to adjust the height or width of the TextFormField
                            hintText: "Last Name (Required)",
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

                        ),
                      ),

                      SizedBox(height: 13.h,),

                      SizedBox(
                        width:  MediaQuery.of(context).size.width - 55,
                        child: TextFormField(
                          controller: registerationController.emailController,

                          key: _emailFormKey,
                          validator: (value) {
                            if(GetUtils.isEmail(value!)) {
                              return null; // means that username is valid

                            } if (value.isEmpty) {
                              return 'Email name cannot be empty';

                            } if (value.contains(' ')) {
                              return 'Email should not contain spaces';
                            }
                            return "Enter valid email";
                          },

                          textAlign: TextAlign.center,         //   ...........codeLine 'A'
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.9
                          ),

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0.h),  // This line is used to adjust the height or width of the TextFormField
                            hintText: "Email (Required)",
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

                        ),
                      ),

                      SizedBox(height: 13.h,),

                      SizedBox(
                        width:  MediaQuery.of(context).size.width - 55,
                        child: TextFormField(
                          controller: registerationController.phoneController,
                          keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                          maxLength: 11,  // length of digits that can be entered for phone number

                          key: _phoneFormKey,
                          validator: (value) {
                            if(GetUtils.isPhoneNumber(value!)) {
                              return null;   //means phone number is valid
                            } else if (value.isEmpty) {
                              return 'Phone number cannot be empty';
                            } else if (value.length < 11) {
                              return 'Phone number shall not be less than 11 digits';
                            } else if (value.contains(' ')) {
                              return 'Username should not contain spaces';
                            }
                            return "Enter valid phone number";
                          },

                          textAlign: TextAlign.center,         //   ...........codeLine 'A'
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.9
                          ),

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0.h),  // This line is used to adjust the height or width of the TextFormField
                            hintText: "Phone (Required)",
                            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            counterStyle: const TextStyle(color: Colors.white),      // this is the color given to the "maxLength : 11' text below the phone controller

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

                        ),
                      ),

                      SizedBox(height: 13.h,),

                      SizedBox(
                        width:  MediaQuery.of(context).size.width - 55,
                        child: TextFormField(
                          controller: registerationController.passwordController,

                          key: _passwordFormKey,

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password cannot be empty';

                            } if (value.length < 5 ) {
                              return 'Password must be at least 5 characters long';

                            } if (value.contains(' ')) {
                              return 'Password should not contain spaces';

                            } if (value.contains(',')) {
                              return 'Password cannot contain a comma';
                            }
                            if (!RegExp(r'[A-Z]').hasMatch(value)) {      // At least one uppercase letter: Use a regular expression to check if the password contains at least one uppercase letter.
                              return 'Password must contain at least one uppercase letter';

                            } if (!RegExp(r'[a-z]').hasMatch(value)) {     // At least one lowercase letter: Use a regular expression to check if the password contains at least one lowercase letter.
                              return 'Password must contain at least one lowercase letter';

                            } if (!RegExp(r'\d').hasMatch(value)) {       // At least one number: Use a regular expression to check if the password contains at least one number.
                              return 'Password must contain at least one number';

                            } if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {    //At least one special character: Use a regular expression to check if the password contains at least one special character.
                              return 'Password must contain at least one special character';
                            }
                            // add more password validation logic as needed
                            return null;
                          },

                          textAlign: TextAlign.center,         //   ...........codeLine 'A'
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.9
                          ),

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0.h),  // This line is used to adjust the height or width of the TextFormField
                            hintText: "Password (Required)",
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

                        ),
                      ),

                      SizedBox(height: 20.h,),

                      SizedBox(
                        height: 45.h,
                        width: 200.w,
                        child: ElevatedButton(
                          onPressed: (){

                            if (

                            _firstNameFormKey.currentState!.validate() &&
                            _lastNameFormKey.currentState!.validate() &&
                            _emailFormKey.currentState!.validate() &&
                            _phoneFormKey.currentState!.validate() &&
                            _passwordFormKey.currentState!.validate()

                            ) {    // when all the conditions in if block gets true one by one then only the registeration will happen

                              //  Navigator.pushNamed(context, RouteName.loginScreenRoute);

                              registerationController.registerWithEmail();
                            }
                          },

                          child: Text("Create",textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),

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

                        ),
                      ),

                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
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
                                Get.to(()=> const PrivacyPolicy());
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


              ],
            ),
          ),
        ),
      ),
    );
  }
}


