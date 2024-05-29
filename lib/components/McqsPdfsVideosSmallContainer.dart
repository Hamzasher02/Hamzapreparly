import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class McqsPdfsVideosSmallContainer extends StatelessWidget {

  final String image;
  final String text;
  final VoidCallback onPress;        // onpressed () function is passed as an argument

  McqsPdfsVideosSmallContainer({Key? key,
    required this.image,
    required this.text,
    required this.onPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/8.4.h,
      width: MediaQuery.of(context).size.width /1.26.w,

      margin: EdgeInsets.only(top:11.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.blue[100],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 11.w),
                  child: Container(
                    height: 106.h,
                    width: MediaQuery.of(context).size.width/4.7.w ,
                    decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.solid, width: 2.5.w, color: Colors.indigo.shade700),
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(10.r),
                    ),

                    child: Center(
                      child: SvgPicture.asset(image, fit: BoxFit.cover,),           // image will be passed as parameter from other screens
                    ),
                  ),
                ),

                SizedBox(width: MediaQuery.of(context).size.width * 0.04,),

                Container(
                  width: MediaQuery.of(context).size.width/4.5.w,      // this will set the text container width for all the containers and so the forward_arrow_ios can be at equal distance for all
                //  margin: EdgeInsets.only(left: 11.w),
                  child: Text(text, style: TextStyle(color: Color(0xff004880), fontSize: 20.sp),),       // text will be passed from other screens
                ),

                //SizedBox(width: MediaQuery.of(context).size.width * 0.15.w,),
                const Spacer(),

                Center(
                  child: Container(
                      //margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.20.w),
                      height: MediaQuery.of(context).size.height * 0.1.h,
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