import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/auth_components/button_component.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/view/screens/auth_screens/sign_in_screen.dart';
import 'package:fyp_project/view/screens/auth_screens/sign_up_screen.dart';
import 'package:fyp_project/view/screens/create_account/account_type_screen.dart';
import 'package:fyp_project/view/screens/create_account/create_account_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Screenshot 2025-08-28 115233.png',
                  scale: 3.sp,
                ),
                24.toHeight,
                Text(
                  'Welcome to Dental Care',
                  style: maintext.copyWith(fontSize: 20.sp),
                  textAlign: TextAlign.center,
                ),
                8.toHeight,
                Text(
                  'Your hub for appointments, chat, and doctors in one app.',
                  style: simpletext.copyWith(fontSize: 12.sp),
                  textAlign: TextAlign.center,
                ),
                32.toHeight,
                ButtonComponent(
                  title: 'Login',
                  color: maincolor,
                  height: 56.h,
                  width: 260.w,
                  ontap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                ),
                12.toHeight,
                ButtonComponent(
                  title: 'Sign Up',
                  textColor: maincolor,
                  color: Colors.white,
                  height: 56.h,
                  width: 260.w,
                  ontap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AccountTypeScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
