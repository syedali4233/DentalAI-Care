import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';

class HeartrateComponent extends StatelessWidget {
  final String? bpmm;
  const HeartrateComponent({super.key, this.bpmm});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: 320.w,
      decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: const Color(0xff407CE2).withOpacity(0.4),
          borderRadius: BorderRadius.circular(8.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                3.toHeight,
                Text(
                  'Heart rate',
                  style: maintext,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      bpmm ?? '97',
                      style: maintext.copyWith(fontSize: 70.sp),
                    ),
                    5.toWidth,
                    Padding(
                      padding: EdgeInsets.only(bottom: 18.h),
                      child: const Text('bpm'),
                    )
                  ],
                )
              ],
            ),
          ),
          Center(
            child: Image.asset(
              bpm,
              scale: 3.5.sp,
            ),
          )
        ],
      ),
    );
  }
}
