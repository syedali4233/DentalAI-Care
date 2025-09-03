import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';

class AppointmentsComponents extends StatelessWidget {
  final String title;
  final String date;
  final String read;
  final String imagee;
  final bool onclicked;
  final VoidCallback? reject;
  final VoidCallback? ontap;
  final VoidCallback? accept;

  const AppointmentsComponents({
    super.key,
    this.accept,
    this.reject,
    required this.title,
    this.ontap,
    required this.date,
    required this.read,
    this.onclicked = false,
    required this.imagee,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.grey),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image Section
              Container(
                height: 83.h,
                width: 90.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    image: _resolveImage(imagee),
                    fit: BoxFit.fill,
                  ),
                  color: Colors.white,
                ),
              ),
              10.toWidth,

              /// Text Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: maintext.copyWith(fontSize: 14.sp)),
                    5.toHeight,
                    Text('Patient',
                        style: simpletext.copyWith(fontSize: 10.sp)),
                    10.toHeight,
                    Row(
                      children: [
                        Image.asset(clocktimer, scale: 4.sp),
                        5.toWidth,
                        Expanded(
                          child: Text(date,
                              style: simpletext.copyWith(fontSize: 10.sp),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    5.toHeight,
                    Row(
                      children: [
                        Image.asset(calender, scale: 4.sp),
                        5.toWidth,
                        Expanded(
                          child: Text(read,
                              style: simpletext.copyWith(fontSize: 10.sp),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// Buttons Section
              if (onclicked)
                Column(
                  children: [
                    5.toHeight,
                    GestureDetector(
                      onTap: accept,
                      child: Container(
                        height: 30.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: const Center(
                          child: Text('Accept',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    15.toHeight,
                    GestureDetector(
                      onTap: reject,
                      child: Container(
                        height: 30.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: const Center(
                          child: Text('Reject',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

ImageProvider _resolveImage(String pathOrUrl) {
  if (pathOrUrl.isEmpty) {
    return const AssetImage(maledoctor);
  }
  if (pathOrUrl.startsWith('http')) {
    return NetworkImage(pathOrUrl);
  }
  return AssetImage(pathOrUrl);
}
