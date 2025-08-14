import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:readmore/readmore.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.toHeight,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back)),
                    70.toWidth,
                    Text(
                      'Doctors Detail',
                      style: maintext,
                    )
                  ],
                ),
              ),
              20.toHeight,
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.h),
                height: 120.h,
                width: 330.w,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 100.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image: const DecorationImage(
                                image: AssetImage('assets/Image (7).png'),
                                fit: BoxFit.fill),
                            color: Colors.white),
                      ),
                      20.toWidth,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          5.toHeight,
                          Text(
                            'Dr. Rishi',
                            style: maintext.copyWith(fontSize: 16.sp),
                          ),
                          5.toHeight,
                          Text(
                            'Chardiologist',
                            style: simpletext.copyWith(fontSize: 10.sp),
                          ),
                          8.toHeight,
                          Container(
                            height: 20.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                                // ignore: deprecated_member_use
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
                                  '4.7',
                                  style: simpletext.copyWith(
                                      color: maincolor, fontSize: 12.sp),
                                )
                              ],
                            ),
                          ),
                          8.toHeight,
                          Row(
                            children: [
                              Image.asset(
                                locationImage,
                                scale: 4.sp,
                              ),
                              5.toWidth,
                              Text(
                                '800m away',
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
              10.toHeight,
              Text(
                'About',
                style: maintext.copyWith(fontSize: 16.sp),
              ),
              ReadMoreText(
                'Lorem ipsum dolor sit amet, consectetur adipi elit, sed do eiusmod tempor incididunt ut laore et dolore magna aliqua. Ut enim ad minim veniam Lorem ipsum dolor sit amet, consectetur adipi elit, sed do eiusmod tempor incididunt ut laore et dolore magna aliqua. Ut enim ad minim veniam ',
                style: simpletext,
                trimLines: 3,
                textAlign: TextAlign.justify,
                moreStyle: simpletext.copyWith(color: maincolor),
                lessStyle: simpletext.copyWith(color: maincolor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
