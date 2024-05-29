 // Note: This class is not used in the project

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';                        //this library is necessary for Taking Phone number in digits only from Numbers Keyboard specifically
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputTextFieldWidget extends StatelessWidget {

  TextEditingController textEditingController;
  final String hintText;

  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;


  InputTextFieldWidget({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],    //by default inputType is kept empty

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      textAlign: TextAlign.center,         //   ...........codeLine 'A'
      style: const TextStyle(color: Colors.white),

      /// The following Two items bellow ie; "keyboardType" and "inputFormatters" when specified for PhoneNuber Controller so then you will be able to enter phone number through phoneNumer Keyboard as numbers only
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0.h),  // This line is used to adjust the height or width of the TextFormField
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w500),

        //  filled: true,
        // fillColor: Colors.lightBlueAccent,           // used to color TextFormField

        focusedBorder: OutlineInputBorder(                         // 'focusedBorder' : is used so that the outlineBorder doesnot dissapear when focused
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.w),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),

        enabledBorder: OutlineInputBorder(                        // 'enabledBorder' : is used so that the border remain enabled after refreshing screen
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.w),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
      ),

    );
  }

}
