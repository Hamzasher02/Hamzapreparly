import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallWhiteContainer extends StatelessWidget {
  final String image;
  final String text;
  // "image" and "text" both are required parameters each time therefore, we declared them as required in below line of code
  const SmallWhiteContainer({Key? key,required this.image, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.16,
      width: MediaQuery.of(context).size.width * 0.85,
      margin: EdgeInsets.only(top: 23.h,),    // creates distance between two widgets
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
      ),
      //padding: const EdgeInsets.only(right: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Container(
            height: 84.h,
            width: 84.w,
            decoration: BoxDecoration(
              color: Color(0xff7CB7FF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                bottomLeft: Radius.circular(20.r),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                bottomLeft: Radius.circular(20.r),
              ),
                child: Image.network(image, fit: BoxFit.cover)),
          ),


          SizedBox(width: MediaQuery.of(context).size.width * 0.04,),

          Container(
            child: Text(text, style: TextStyle(color: Colors.blueAccent, fontSize: 18.6.sp),),       // text will be passed from other screens
          ),
        ],
      ),
    );
  }
}
