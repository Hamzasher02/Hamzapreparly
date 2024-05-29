import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/VerifyOTPController.dart';
import '../controllers/forgotPasswordController.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());
  VerifyOTPController verifyOTPController = Get.put(VerifyOTPController());

  final _emailFormKey = GlobalKey<FormFieldState>();
  final _otpFormKey = GlobalKey<FormFieldState>();

  @override
  void dispose() {
    verifyOTPController.pinCodeController.dispose();
    super.dispose();

    print("the pinCodeController is manually disposed after getting out of passwordForgotScreen: ${verifyOTPController.pinCodeController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       // resizeToAvoidBottomInset: false, // this property automatically resize the content when the keyboard appears to avoid overflow error
        backgroundColor: Color(0xff004880),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Lottie.asset(
                    'animations/83608-email-white.json',
                  height: 150,
                  repeat: true,
                  fit: BoxFit.cover
                ),

                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.009),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                        "Forget\nPassword",textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
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

                      TextFormField(
                    controller: forgotPasswordController.emailController,
                      key: _emailFormKey,
                    validator: (value) {
                      if (GetUtils.isEmail(value!)) {
                      return null;
                      } else if (value.contains(' ')) {
                        return 'email should not contain spaces';
                      }
                      return"Enter valid email";
                    },

                    textAlign: TextAlign.center,         //   ...........codeLine 'A'
                    style:  Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.9
                  ),

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0.h),  // This line is used to adjust the height or width of the TextFormField
                      prefixIcon: Icon(Icons.email,color: Colors.white,),
                      labelText: 'email',
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: "Enter your registered email",
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
                        borderSide: BorderSide(color: Colors.white, width: 3.w),
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      ),

                      enabledBorder: OutlineInputBorder(                        // 'enabledBorder' : is used so that the border remain enabled after refreshing screen
                        borderSide: BorderSide(color: Colors.white, width: 3.w),
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      ),
                    ),

                  ),
                      SizedBox(height: 30.h,),
                      SizedBox(
                        height: 50.h,
                        width: 200.w,
                        child: ElevatedButton(
                          onPressed: (){

                            if (_emailFormKey.currentState!.validate()) {
                              //  Navigator.pushNamed(context, RouteName.loginScreenRoute);

                              forgotPasswordController.ForgotPassword();    // forgotPasswordController will be called thus Otp will be sent to email then the dialogueBox will open

                              showDialog(          // otp will be shown after validation of "new password" and "confirm password"
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    // contentPadding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                                    content: SingleChildScrollView(
                                      child: Padding(
                                        padding: EdgeInsets.zero,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [

                                            Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                    child: Icon(Icons.close_outlined)
                                                ),
                                              ),
                                            ),

                                            Lottie.asset('animations/resetAnimation.json',repeat: false, fit: BoxFit.cover),
                                            SizedBox(height: 15,),
                                            Text('Enter OTP'),
                                           SizedBox(height: 15),
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(horizontal: 16),
                                              child: Form(
                                                child: PinCodeTextField(
                                                  keyboardType: TextInputType.number,

                                                  //"autoDisposeControllers" is set to false otherwise, if user go back from AlertDialogue and immedietly open again so it will give error.
                                                  // error will be " TextEditingController was used after being disposed. Once you have called dispose() on a TextEditingController, it can no longer be used. The relevant error-causing widget was: AlertDialog()"
                                                  // so now that "autoDisposeControllers:" is set to false so we will just manually delete it after getting out of the "PasswordResetScreen()" by calling 'dispose' function
                                                  autoDisposeControllers: false,
                                                  controller: verifyOTPController.pinCodeController,
                                                  key: _otpFormKey,
                                                  autovalidateMode: AutovalidateMode.onUserInteraction, // as soon as user clicks on pinCodeTextField so the validation starts
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Please enter OTP';
                                                    }
                                                    return null;   // means otp is valid
                                                  },

                                                  length: 4,
                                                  onChanged: (value) {},
                                                  appContext: context,
                                                  pinTheme: PinTheme(
                                                    shape: PinCodeFieldShape.box,
                                                    borderRadius: BorderRadius.circular(5.r),
                                                    fieldHeight: 60.h,
                                                    fieldWidth: 50.w,
                                                    inactiveFillColor: Colors.transparent,
                                                    inactiveColor: Colors.grey,
                                                    activeColor: Colors.blue,
                                                    activeFillColor: Colors.transparent,
                                                    selectedColor: Colors.red,
                                                    selectedFillColor: Colors.transparent,
                                                    borderWidth: 2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 22),
                                        child: Center(
                                          child: SizedBox(
                                            width: 200,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // If otp is valid so user is verified then close the dialogue box and go to reset password screen
                                                final email = forgotPasswordController.emailController.text;
                                                verifyOTPController.verifyOTP(email);
                                              },

                                              style: ButtonStyle(
                                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.r)))),
                                                backgroundColor: MaterialStateProperty.all(Colors.grey.shade400),
                                                foregroundColor: MaterialStateProperty.all(Colors.black),
                                                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                                      (Set<MaterialState> states) {
                                                    if (states.contains(MaterialState.pressed)) return const Color(0xff004880);
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                child: Text("Proceed", textAlign: TextAlign.center,
                                                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],

                                  );
                                },
                              );
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
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            child: Text("Reset",textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
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
