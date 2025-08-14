import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';

class ProfileScreenComponents extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback? ontap;
  const ProfileScreenComponents(
      {super.key, required this.title, this.ontap, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
              children: [
                Container(
                  height: 35.h,
                  width: 35.w,
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: maincolor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      image,
                      scale: 5.sp,
                      // color: Colors.white,
                    ),
                  ),
                ),
                10.toWidth,
                Text(
                  title,
                  style: maintext.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.forward,
            color: maincolor,
          )
        ],
      ),
    );
  }
}
