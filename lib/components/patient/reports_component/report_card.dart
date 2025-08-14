import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';

class ReportCard extends StatelessWidget {
  final String image;
  final Color backgroundcolor;
  final String title;
  final String subtitile;
  final Color? borderColor;
  const ReportCard(
      {super.key,
      required this.image,
      required this.backgroundcolor,
      this.borderColor,
      required this.title,
      required this.subtitile});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: 150.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          // ignore: deprecated_member_use
          color: backgroundcolor.withOpacity(0.42.sp),
          border: Border.all(color: borderColor ?? Colors.transparent)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              image,
              scale: 4.sp,
            ),
            5.toHeight,
            Text(title),
            10.toHeight,
            Text(
              subtitile,
              style: maintext,
            )
          ],
        ),
      ),
    );
  }
}
