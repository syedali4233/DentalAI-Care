import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/main.dart';
import 'package:google_fonts/google_fonts.dart';

class customSnackBar extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  const customSnackBar(
      {super.key, required this.message, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: backgroundColor),
          borderRadius: BorderRadius.circular(16.r)),
      child: DefaultTextStyle(
          style: GoogleFonts.inter(
              color: const Color(0xff3F3C36),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700),
          child: Row(
            children: [Expanded(child: Center(child: Text(message)))],
          )),
    );
  }
}

class CustomSnackBarUtils {
  static void showTopSnackBar(String message, Color backgroundColor) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final overlay =
          navigatorKey.currentState?.overlay; // Access the navigatorKey
      if (overlay == null) {
        print('Overlay is null----> ');
        return;
      }

      final overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: 20.h,
          left: 15.w,
          right: 15.w,
          child: customSnackBar(
            message: message,
            backgroundColor: backgroundColor,
          ),
        ),
      );

      overlay.insert(overlayEntry); // Insert the overlay entry

      Future.delayed(const Duration(seconds: 3), () {
        overlayEntry.remove(); // Remove the overlay after delay
      });
    });
  }
}
