import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ButtonComponent extends StatelessWidget {
  final double? height;
  final double? width;
  final String title;
  final Color? textColor;
  final Color color;
  final VoidCallback ontap;

  final bool isLoading;
  const ButtonComponent(
      {super.key,
      this.height,
      this.width,
      required this.title,
      this.isLoading = false,
      this.textColor,
      required this.color,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: height ?? 50.h,
        width: width ?? 300.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: color,
            border: Border.all(color: maincolor)),
        child: Center(
          child: isLoading
              ? LoadingAnimationWidget.waveDots(
                  color: Colors.white, size: 40.sp)
              : Text(
                  title,
                  style: buttontext.copyWith(color: textColor ?? Colors.white),
                ),
        ),
      ),
    );
  }
}
