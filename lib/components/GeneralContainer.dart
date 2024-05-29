import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralContainer extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onPress;        // onpressed () function is passed as an argument

  const GeneralContainer({Key? key,
    required this.image,
    required this.text,
    required this.onPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/12.h,
      width: MediaQuery.of(context).size.width /1.16.w,

      margin: EdgeInsets.only(top:23.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
      ),

      child: Row(
       // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: Container(
              height: 106.h,
              width: MediaQuery.of(context).size.width/4.7.w ,

             // color: Colors.white,

              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r),
                ),
                child: Image.network(image, fit: BoxFit.cover,),           // image will be passed as parameter from other screens
              ),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width/2.7.w,      // this will set the text container width for all the containers and so the forward_arrow_ios can be at equal distance for all
            margin: EdgeInsets.only(left: 4.w),
            child: Text(text, style: TextStyle(color: Color(0xff004880), fontSize: 20.sp, fontWeight: FontWeight.w500)),       // text will be passed from other screens
          ),

          Spacer(),

          Center(
            child: Container(
              //margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.20.w),
              height: MediaQuery.of(context).size.height * 0.08.h,
              width: MediaQuery.of(context).size.width * 0.14.w,
              //child: IconButton,
              child: IconButton(onPressed: onPress, icon: Image.asset("assets/forwardarrow.png"), color: Color(0xff004880),),

            ),
          )
        ],
      ),
    );
  }
}
