import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerComponents {
  // Generic shimmer wrapper
  static Widget shimmerWrapper({required Widget child}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: child,
    );
  }

  // Profile picture shimmer
  static Widget profilePictureShimmer({double radius = 60}) {
    return shimmerWrapper(
      child: Stack(
        children: [
          CircleAvatar(
            radius: radius,
            backgroundColor: Colors.grey[300],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: radius * 0.33,
              backgroundColor: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

  // Text field shimmer
  static Widget textFieldShimmer({
    double? width,
    double height = 50,
    double borderRadius = 8,
  }) {
    return shimmerWrapper(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  // Text shimmer (for labels, titles, etc.)
  static Widget textShimmer({
    double width = 100,
    double height = 16,
    double borderRadius = 4,
  }) {
    return shimmerWrapper(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  // List tile shimmer
  static Widget listTileShimmer() {
    return shimmerWrapper(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundColor: Colors.grey[300],
            ),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 16.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  8.verticalSpace,
                  Container(
                    width: 150.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Card shimmer
  static Widget cardShimmer({
    double? width,
    double height = 120,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
  }) {
    return shimmerWrapper(
      child: Container(
        width: width,
        height: height,
        margin: margin ?? EdgeInsets.all(8.r),
        padding: padding ?? EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  // Grid shimmer
  static Widget gridShimmer({
    required int itemCount,
    required int crossAxisCount,
    double childAspectRatio = 1.0,
    double crossAxisSpacing = 8.0,
    double mainAxisSpacing = 8.0,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemBuilder: (context, index) {
        return cardShimmer(margin: EdgeInsets.zero);
      },
    );
  }
}

// Extension for easy access
extension ShimmerExtension on Widget {
  Widget toShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: this,
    );
  }
}
