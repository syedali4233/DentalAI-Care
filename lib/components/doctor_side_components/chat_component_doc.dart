import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/styles.dart';

class ChatComponentDoc extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String image;
  final VoidCallback ontap;
  const ChatComponentDoc(
      {super.key,
      required this.ontap,
      required this.image,
      required this.name,
      required this.message,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
            radius: 30.r,
            backgroundColor: maincolor,
            backgroundImage: AssetImage(image)),
        10.toWidth,
        Expanded(
          child: GestureDetector(
            onTap: ontap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                5.toHeight,
                Text(
                  name,
                  style: maintext.copyWith(fontSize: 14.sp),
                ),
                5.toHeight,
                Text(
                  message,
                  style: simpletext,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            ),
          ),
        ),
        Column(
          children: [
            5.toHeight,
            Text(time, style: simpletext.copyWith(fontSize: 10.sp)),
          ],
        ),
      ],
    );
  }
}
