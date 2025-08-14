import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';

class TopDoctorComponent extends StatelessWidget {
  final String imagee;
  final String title;
  final String field;
  final String rating;
  final String locations;
  final VoidCallback ontapp;
  const TopDoctorComponent(
      {super.key,
      required this.imagee,
      required this.title,
      required this.field,
      required this.rating,
      required this.ontapp,
      required this.locations});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontapp,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        height: 120.h,
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
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                        image: AssetImage(imagee), fit: BoxFit.fill),
                    color: Colors.white),
              ),
              10.toWidth,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  5.toHeight,
                  Text(
                    title,
                    style: maintext.copyWith(fontSize: 16.sp),
                  ),
                  Text(
                    field,
                    style: simpletext.copyWith(fontSize: 10.sp),
                  ),
                  5.toHeight,
                  Container(
                    height: 20.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        color: maincolor.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          starRating,
                          scale: 4.sp,
                        ),
                        Text(
                          rating,
                          style: simpletext.copyWith(
                              color: maincolor, fontSize: 12.sp),
                        )
                      ],
                    ),
                  ),
                  5.toHeight,
                  Row(
                    children: [
                      Image.asset(
                        locationImage,
                        scale: 4.sp,
                      ),
                      5.toWidth,
                      Text(
                        '${locations}m away',
                        style: simpletext.copyWith(fontSize: 12.sp),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
