// Note: This class is not used in the project

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InputTextFieldWidgetLogin extends StatelessWidget {

  TextEditingController textEditingController;
  final String hintText;
  final bool? obsecureText;
  final Widget icon;

  final String isValid;       //required for validation

   InputTextFieldWidgetLogin({
     Key? key,
     required this.textEditingController,
     required this.hintText,
     this.obsecureText,     //This property is used to hide the password written by user
     required this.icon,
      required this.isValid,
   }) : super(key: key);

  ValueNotifier<bool> passwordNotifier = ValueNotifier(true);        //This ValueNotifier is used to toggle the visibility of the text in a TextFormField widget based on whether or not the value of confirmPasswordNotifier is true or false.

  String? _validateInput(textEditingController) {            // function for validation
    if(isValid == null || isValid.isEmpty) {
      return 'Please enter the credentials';

    } else if (isValid == 'isEmail') {
      if (GetUtils.isEmail(textEditingController)) {
        return null;
      }
      return "Enter valid email";
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:  MediaQuery.of(context).size.width - 55,
      child: ValueListenableBuilder(        // // The ValueListenableBuilder widget listens to changes in the value of confirmPasswordNotifier.
        valueListenable: passwordNotifier,  // Whenever the value of confirmPasswordNotifier changes, the builder function is called with the new value of confirmPasswordNotifier and the child widget (which is the TextFormField widget in this case).
        builder: (context, bool value, Widget? child) {
          return Form(
            key: _formKey,
            child: TextFormField(
              controller: textEditingController,
              
              validator: _validateInput,

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
                hintText: hintText,
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


                prefixIcon: icon,

                focusedBorder: OutlineInputBorder(                         // 'focusedBorder' : is used so that the outlineBorder doesnot dissapear when focused
                  borderSide: BorderSide(color: Colors.white, width: 3.w),
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                ),

                enabledBorder: OutlineInputBorder(                        // 'enabledBorder' : is used so that the border remain enabled after refreshing screen
                  borderSide: BorderSide(color: Colors.white, width: 3.w),
                  borderRadius: BorderRadius.all(Radius.circular(30.r)),
                ),
              ),

            ),
          );
        },
      ),
    );
  }
}

