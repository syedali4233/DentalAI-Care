import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/styles.dart';

class Article extends StatelessWidget {
  final String title;
  final String date;
  final String read;
  final String imagee;

  const Article(
      {super.key,
      required this.title,
      required this.date,
      required this.read,
      required this.imagee});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80.h,
      width: 330.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 60.h,
              width: 70.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                      image: AssetImage(imagee), fit: BoxFit.fill),
                  color: Colors.white),
            ),
            10.toWidth,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: simpletext.copyWith(fontSize: 10.sp),
                ),
                10.toHeight,
                Row(
                  children: [
                    Text(
                      date,
                      style: simpletext.copyWith(fontSize: 10.sp),
                    ),
                    5.toWidth,
                    Text(
                      read,
                      style: simpletext.copyWith(fontSize: 10.sp),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
