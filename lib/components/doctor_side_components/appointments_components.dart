import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';

class AppointmentsComponents extends StatelessWidget {
  final String title;
  final String date;
  final String read;
  final String imagee;
  final bool onclicked;
  const AppointmentsComponents(
      {super.key,
      required this.title,
      required this.date,
      required this.read,
      this.onclicked = false,
      required this.imagee});

  @override
  Widget build(BuildContext context) {
    return Container(
      //   height: 100.h,
      width: 330.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            child: Row(
              children: [
                Container(
                  height: 83.h,
                  width: 90.w,
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
                      style: maintext.copyWith(fontSize: 14.sp),
                    ),
                    5.toHeight,
                    Text(
                      'Patient',
                      style: simpletext.copyWith(fontSize: 10.sp),
                    ),
                    10.toHeight,
                    Row(
                      children: [
                        Image.asset(
                          clocktimer,
                          scale: 4.sp,
                        ),
                        5.toWidth,
                        Text(
                          date,
                          style: simpletext.copyWith(fontSize: 10.sp),
                        )
                      ],
                    ),
                    5.toHeight,
                    Row(
                      children: [
                        Image.asset(
                          calender,
                          scale: 4.sp,
                        ),
                        5.toWidth,
                        Text(
                          read,
                          style: simpletext.copyWith(fontSize: 10.sp),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          if (onclicked)
            Column(
              children: [
                Container(
                    height: 30.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: const Center(
                        child: Text(
                      'Accept',
                      style: TextStyle(color: Colors.white),
                    ))),
                5.toHeight,
                Container(
                    height: 30.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: const Center(
                        child: Text(
                      'Reject',
                      style: TextStyle(color: Colors.white),
                    )))
              ],
            ),
        ]),
      ),
    );
  }
}
