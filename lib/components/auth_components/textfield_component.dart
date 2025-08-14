import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';

class TextfieldComponent extends StatelessWidget {
  final String title;
  final String? iconimage;
  final double? height;
  final double? width;
  final Widget? suffixicon;

  final bool obscureText;
  final TextEditingController? controller;
  final String? validation;
  const TextfieldComponent({
    super.key,
    required this.title,
    this.validation,
    this.height,
    this.width,
    this.iconimage,
    this.controller,
    this.obscureText = false,
    this.suffixicon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //  height: height ?? 56.h,
      width: width ?? 300.w,
      child: TextFormField(
        obscureText: obscureText,
        validator: validation != null
            ? (value) {
                if (value == null || value.isEmpty) {
                  return validation.toString();
                }
                return null;
              }
            : null,
        controller: controller,
        decoration: InputDecoration(
          hintText: title,
          hintStyle: simpletext,
          filled: true,
          fillColor: Colors.grey.shade100,
          prefixIcon: iconimage != null
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    iconimage!,
                    width: 24.w,
                    height: 24.h,
                    fit: BoxFit.contain,
                  ),
                )
              : null,

          suffixIcon: suffixicon,
          // Add this!
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: const BorderSide(color: Colors.red, width: 1.2),
          ),
        ),
      ),
    );
  }
}
