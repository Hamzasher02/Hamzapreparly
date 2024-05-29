import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GridViewContainer extends StatelessWidget {
  final String image;
  final String text;
  final String abbreviation;
  GridViewContainer({
    Key? key,
    required this.image,
    required this.text,
    required this.abbreviation,
    required categoryObj,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                Container(
                  //  margin: EdgeInsets.only(top: 3),
                  height: 70,
                  width: 70,
                  child: ClipOval(
                    child: Image.network(
                      image,
                      height: 83,
                      width: 83,
                      fit: BoxFit.contain,
                      scale: 1.0,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              //    margin: EdgeInsets.only(top: 4),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  text,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff004880),
                        height: 1.2,
                        letterSpacing: 1.7,
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
              ),
            ),
            Container(
              //   margin: EdgeInsets.only(top: 4),
              //  height: 45.h,
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                abbreviation,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ));
  }
}
