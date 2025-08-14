import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizedBoxExtension on int {
  /// Responsive height-sized box
  Widget get toHeight => SizedBox(height: h);

  /// Responsive width-sized box
  Widget get toWidth => SizedBox(width: w);
}
