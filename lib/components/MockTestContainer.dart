import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MockTestContainer extends StatelessWidget {

  final String text;     // required parameters have no problem regarding null safety

  const MockTestContainer({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 85.h,
       // width: MediaQuery.of(context).size.width - 35,

       // height: MediaQuery.of(context).size.height/12.h,
       // width: MediaQuery.of(context).size.width /1.16.w,

        padding: EdgeInsets.only(right: 10),
        margin: EdgeInsets.only(top: 7.h,),    // creates distance between two widgets
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
            color: Colors.lightBlueAccent
        ),
        //padding: const EdgeInsets.only(right: 100),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Padding(
              padding: EdgeInsets.only(left: 11.w),
                child: Image.asset("assets/MockTestSmall.png", scale: 1.1,)
            ),

            Padding(
                padding: EdgeInsets.only(left: 22.w),
                child: Text(text.toString(), style: TextStyle(color: Color(0xff004880), fontSize: 22.sp),)
            ),

            Spacer(),

            Image.asset("assets/forwardarrow.png", scale: 1.2,)

          ],
        ),
      ),
    );
  }
}
