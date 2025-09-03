import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';

class ChatComponentDoc extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String image;
  final VoidCallback ontap;

  const ChatComponentDoc({
    super.key,
    required this.ontap,
    required this.image,
    required this.name,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundColor: maincolor,
              backgroundImage: image.isNotEmpty
                  ? NetworkImage(image)
                  : const AssetImage(maledoctor) as ImageProvider,
            ),
            10.toWidth,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  5.toHeight,
                  Text(
                    name,
                    style: maintext.copyWith(fontSize: 14.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                  5.toHeight,
                  Text(
                    message.isNotEmpty ? message : "No message yet",
                    style: simpletext,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                5.toHeight,
                Text(
                  time.isNotEmpty ? time : "",
                  style: simpletext.copyWith(fontSize: 10.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
